import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../../core/router/rutas.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatos.dart';
import '../../../../core/widgets/estado_vacio.dart';
import '../../../../core/widgets/seccion.dart';
import '../../../clientes/domain/entidades/cliente.dart';
import '../../../clientes/presentation/pantallas/pantalla_clientes.dart';
import '../../../configuracion/presentation/providers/ajustes_providers.dart';
import '../../../empresa/domain/entidades/empresa.dart';
import '../../../empresa/presentation/providers/empresa_providers.dart';
import '../../domain/entidades/comprobante.dart';
import '../../domain/entidades/totales.dart';
import '../providers/borrador_providers.dart';
import '../providers/comprobantes_providers.dart';
import '../providers/emision_providers.dart';
import '../widgets/hoja_item_comprobante.dart';
import '../widgets/panel_totales.dart';
import '../widgets/tabla_items.dart';

/// Formulario de emisión.
///
/// Todo lo que se captura vive en `borradorComprobanteProvider`, que es
/// `autoDispose`: al salir de la pantalla el borrador se descarta y la
/// siguiente emisión empieza limpia. El correlativo que se muestra es sólo
/// informativo; el definitivo lo reserva el repositorio dentro de la
/// transacción en que se inserta el comprobante.
class PantallaNuevoComprobante extends ConsumerStatefulWidget {
  const PantallaNuevoComprobante({super.key});

  @override
  ConsumerState<PantallaNuevoComprobante> createState() =>
      _PantallaNuevoComprobanteState();
}

class _PantallaNuevoComprobanteState
    extends ConsumerState<PantallaNuevoComprobante> {
  @override
  void initState() {
    super.initState();
    // Se difiere al primer frame: en `initState` todavía no hay oyentes del
    // borrador y un provider `autoDispose` se descartaría nada más crearlo.
    WidgetsBinding.instance.addPostFrameCallback((_) => _prepararBorrador());
  }

  /// Deja el borrador recién creado listo para capturar.
  void _prepararBorrador() {
    if (!mounted) return;
    // El borrador nace con "CLIENTES VARIOS", que no sirve para una factura;
    // `cambiarTipo` limpia el receptor cuando es incompatible.
    ref
        .read(borradorComprobanteProvider.notifier)
        .cambiarTipo(ref.read(borradorComprobanteProvider).tipo);
    _sincronizarSerie();
  }

  /// Deja el borrador con una serie válida para su tipo de comprobante.
  void _sincronizarSerie() {
    if (!mounted) return;
    final empresa = ref.read(empresaProvider).value;
    if (empresa == null) return;

    final borrador = ref.read(borradorComprobanteProvider);
    final series = _seriesDisponibles(empresa, borrador.tipo);
    if (series.isEmpty || series.contains(borrador.serie)) return;

    ref.read(borradorComprobanteProvider.notifier).cambiarSerie(series.first);
  }

  static List<String> _seriesDisponibles(Empresa empresa, TipoComprobante tipo) =>
      tipo == TipoComprobante.boleta ? empresa.seriesBoleta : empresa.seriesFactura;

  void _cambiarTipo(TipoComprobante tipo) {
    ref.read(borradorComprobanteProvider.notifier).cambiarTipo(tipo);
    _sincronizarSerie();
  }

  Future<void> _elegirClienteDeAgenda() async {
    final elegido = await Navigator.push<Cliente>(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => const PantallaClientes(modoSeleccion: true),
      ),
    );
    if (elegido == null || !mounted) return;

    final borrador = ref.read(borradorComprobanteProvider);
    if (borrador.tipo == TipoComprobante.factura && !elegido.puedeRecibirFactura) {
      _avisar('Una factura sólo puede emitirse a un cliente con RUC.');
      return;
    }

    ref.read(borradorComprobanteProvider.notifier).cambiarCliente(elegido);
  }

  void _usarPublicoGeneral() => ref
      .read(borradorComprobanteProvider.notifier)
      .cambiarCliente(Cliente.publicoGeneral());

  Future<void> _agregarItem() async {
    final item = await HojaItemComprobante.mostrar(context);
    if (item == null || !mounted) return;
    ref.read(borradorComprobanteProvider.notifier).agregarItem(item);
  }

  Future<void> _editarItem(int indice) async {
    final actual = ref.read(borradorComprobanteProvider).items[indice];
    final editado = await HojaItemComprobante.mostrar(context, inicial: actual);
    if (editado == null || !mounted) return;
    ref.read(borradorComprobanteProvider.notifier).actualizarItem(indice, editado);
  }

  Future<void> _elegirFecha({required bool esVencimiento}) async {
    final borrador = ref.read(borradorComprobanteProvider);
    final inicial = esVencimiento
        ? (borrador.fechaVencimiento ?? borrador.fechaEmision)
        : borrador.fechaEmision;
    final ahora = DateTime.now();

    final elegida = await showDatePicker(
      context: context,
      initialDate: inicial,
      firstDate: DateTime(ahora.year - 1),
      lastDate: DateTime(ahora.year + 2, 12, 31),
      locale: const Locale('es', 'PE'),
      helpText: esVencimiento ? 'Fecha de vencimiento' : 'Fecha de emisión',
    );
    if (elegida == null || !mounted) return;

    final notificador = ref.read(borradorComprobanteProvider.notifier);
    if (esVencimiento) {
      notificador.cambiarFechaVencimiento(elegida);
    } else {
      notificador.cambiarFechaEmision(elegida);
    }
  }

  Future<void> _emitir() async {
    final borrador = ref.read(borradorComprobanteProvider);
    final problemas = borrador.validar();
    if (problemas.isNotEmpty) {
      await _mostrarProblemas(problemas);
      return;
    }

    final ajustes = ref.read(ajustesProvider).value;
    // El messenger se toma antes de navegar: después de `pushReplacement` este
    // contexto ya no cuelga del árbol.
    final messenger = ScaffoldMessenger.of(context);

    final completada = await ref
        .read(controladorEmisionProvider.notifier)
        .emitirBorrador(intentarEnvioReal: ajustes?.puedeEmitirEnReal ?? false);

    if (!mounted) return;

    if (completada == null) {
      final error = ref.read(controladorEmisionProvider).error;
      _avisar('No se pudo emitir el comprobante. ${error ?? ''}'.trim());
      return;
    }

    final comprobante = completada.comprobante;
    context.pushReplacement(Rutas.detalleDe(comprobante.id!));

    messenger.showSnackBar(
      SnackBar(
        content: Text(
          completada.resultado.degradadoASimulacion
              ? '${comprobante.numeroCompleto} se guardó en modo Simulación.'
              : '${comprobante.tipo.etiqueta} ${comprobante.numeroCompleto} emitida.',
        ),
      ),
    );
  }

  Future<void> _mostrarProblemas(List<String> problemas) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.rule_rounded),
        title: const Text('Falta completar el comprobante'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final problema in problemas)
              Padding(
                padding: const EdgeInsets.only(bottom: Espaciado.xs),
                child: Text('•  $problema'),
              ),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  Future<bool> _confirmarSalida() async {
    if (ref.read(borradorComprobanteProvider).items.isEmpty) return true;

    final salir = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Descartar el comprobante?'),
        content: const Text(
          'Todavía no se ha emitido: los ítems capturados se perderán.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Seguir editando'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Descartar'),
          ),
        ],
      ),
    );
    return salir ?? false;
  }

  void _avisar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    final borrador = ref.watch(borradorComprobanteProvider);
    final totales = ref.watch(totalesBorradorProvider);
    final empresa = ref.watch(empresaProvider).value;
    final emision = ref.watch(controladorEmisionProvider);
    final emitiendo = emision.isLoading;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (yaSalio, _) async {
        if (yaSalio) return;
        final salir = await _confirmarSalida();
        if (salir && context.mounted) context.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nueva ${borrador.tipo.etiqueta.toLowerCase()}'),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(
            Espaciado.md,
            0,
            Espaciado.md,
            Espaciado.md,
          ),
          children: [
            _SeccionDocumento(
              borrador: borrador,
              empresa: empresa,
              onCambiarTipo: _cambiarTipo,
              onCambiarSerie: (serie) => ref
                  .read(borradorComprobanteProvider.notifier)
                  .cambiarSerie(serie),
              onElegirFecha: () => _elegirFecha(esVencimiento: false),
            ),
            const SizedBox(height: Espaciado.sm),

            _SeccionCliente(
              borrador: borrador,
              onElegirDeAgenda: _elegirClienteDeAgenda,
              onPublicoGeneral: _usarPublicoGeneral,
            ),
            const SizedBox(height: Espaciado.sm),

            _SeccionItems(
              borrador: borrador,
              onAgregar: _agregarItem,
              onEditar: _editarItem,
              onEliminar: (indice) => ref
                  .read(borradorComprobanteProvider.notifier)
                  .eliminarItem(indice),
            ),
            const SizedBox(height: Espaciado.sm),

            _SeccionCondiciones(
              borrador: borrador,
              onCambiarMoneda: (moneda) => ref
                  .read(borradorComprobanteProvider.notifier)
                  .cambiarMoneda(moneda),
              onCambiarFormaPago: (forma) => ref
                  .read(borradorComprobanteProvider.notifier)
                  .cambiarFormaPago(forma),
              onElegirVencimiento: () => _elegirFecha(esVencimiento: true),
              onCambiarObservaciones: (texto) => ref
                  .read(borradorComprobanteProvider.notifier)
                  .cambiarObservaciones(texto),
            ),

            if (borrador.items.isNotEmpty) ...[
              const SizedBox(height: Espaciado.sm),
              Seccion(
                titulo: 'Totales',
                icono: Icons.calculate_outlined,
                subtitulo: 'Calculados línea a línea, como los valida SUNAT.',
                hijo: PanelTotales(
                  totales: totales,
                  moneda: borrador.moneda,
                  mostrarLetras: false,
                ),
              ),
            ],
          ],
        ),
        bottomNavigationBar: _BarraEmision(
          totales: totales,
          moneda: borrador.moneda,
          emitiendo: emitiendo,
          onEmitir: emitiendo ? null : _emitir,
        ),
      ),
    );
  }
}

/// Tipo de comprobante, serie, número previsto y fecha de emisión.
class _SeccionDocumento extends ConsumerWidget {
  const _SeccionDocumento({
    required this.borrador,
    required this.empresa,
    required this.onCambiarTipo,
    required this.onCambiarSerie,
    required this.onElegirFecha,
  });

  final Comprobante borrador;
  final Empresa? empresa;
  final ValueChanged<TipoComprobante> onCambiarTipo;
  final ValueChanged<String> onCambiarSerie;
  final VoidCallback onElegirFecha;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textos = Theme.of(context).textTheme;
    final series = empresa == null
        ? const <String>[]
        : (borrador.tipo == TipoComprobante.boleta
            ? empresa!.seriesBoleta
            : empresa!.seriesFactura);

    // Se consulta sólo para mostrarlo: el número real se reserva al guardar.
    final proximo = borrador.serie.isEmpty
        ? const AsyncValue<int>.loading()
        : ref.watch(proximoCorrelativoProvider(borrador.serie));

    return Seccion(
      titulo: 'Documento',
      icono: Icons.description_outlined,
      hijo: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              // Fase 1 sólo emite factura y boleta; las notas llegan después.
              for (final tipo in const [
                TipoComprobante.factura,
                TipoComprobante.boleta,
              ])
                Padding(
                  padding: const EdgeInsets.only(right: Espaciado.xs),
                  child: ChoiceChip(
                    label: Text(tipo.etiqueta),
                    selected: borrador.tipo == tipo,
                    showCheckmark: false,
                    onSelected: (_) => onCambiarTipo(tipo),
                  ),
                ),
            ],
          ),
          const SizedBox(height: Espaciado.md),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  key: ValueKey('serie-${borrador.tipo.name}-${borrador.serie}'),
                  initialValue: series.contains(borrador.serie) ? borrador.serie : null,
                  decoration: const InputDecoration(labelText: 'Serie'),
                  items: [
                    for (final serie in series)
                      DropdownMenuItem(value: serie, child: Text(serie)),
                  ],
                  onChanged: (serie) {
                    if (serie != null) onCambiarSerie(serie);
                  },
                ),
              ),
              const SizedBox(width: Espaciado.sm),
              Expanded(
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'N.º previsto',
                    helperText: 'Se asigna al emitir',
                  ),
                  child: Text(
                    switch (proximo) {
                      AsyncData(:final value) =>
                        value.toString().padLeft(8, '0'),
                      _ => '—',
                    },
                    style: textos.bodyLarge?.copyWith(
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (series.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: Espaciado.xs),
              child: Text(
                'No hay series de ${borrador.tipo.etiqueta.toLowerCase()} '
                'declaradas. Agrégalas en Configuración.',
                style: textos.bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ),
          const SizedBox(height: Espaciado.md),
          _CampoFecha(
            etiqueta: 'Fecha de emisión',
            valor: formatearFechaLarga(borrador.fechaEmision),
            onTap: onElegirFecha,
          ),
        ],
      ),
    );
  }
}

/// Receptor del comprobante.
class _SeccionCliente extends StatelessWidget {
  const _SeccionCliente({
    required this.borrador,
    required this.onElegirDeAgenda,
    required this.onPublicoGeneral,
  });

  final Comprobante borrador;
  final VoidCallback onElegirDeAgenda;
  final VoidCallback onPublicoGeneral;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;
    final cliente = borrador.cliente;
    final sinElegir = cliente.razonSocialONombres.trim().isEmpty;
    final esFactura = borrador.tipo == TipoComprobante.factura;

    return Seccion(
      titulo: 'Cliente',
      icono: Icons.person_outline_rounded,
      subtitulo: esFactura ? 'Una factura exige receptor con RUC.' : null,
      accion: TextButton.icon(
        onPressed: onElegirDeAgenda,
        icon: const Icon(Icons.search_rounded, size: 18),
        label: const Text('Elegir'),
      ),
      hijo: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (sinElegir)
            EstadoVacio(
              compacto: true,
              icono: Icons.person_search_outlined,
              titulo: 'Sin cliente',
              mensaje: esFactura
                  ? 'Busca en tu agenda o registra al receptor con su RUC.'
                  : 'Elige un cliente o emite a "CLIENTES VARIOS".',
              etiquetaAccion: 'Buscar en la agenda',
              onAccion: onElegirDeAgenda,
            )
          else
            Row(
              children: [
                CircleAvatar(
                  radius: 21,
                  backgroundColor: esquema.primaryContainer,
                  child: Text(
                    cliente.iniciales,
                    style: textos.titleSmall
                        ?.copyWith(color: esquema.onPrimaryContainer),
                  ),
                ),
                const SizedBox(width: Espaciado.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cliente.razonSocialONombres,
                        style: textos.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(cliente.documentoFormateado, style: textos.bodySmall),
                      if (cliente.direccion != null &&
                          cliente.direccion!.trim().isNotEmpty)
                        Text(
                          cliente.direccion!,
                          style: textos.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          if (!esFactura) ...[
            const SizedBox(height: Espaciado.xs),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: onPublicoGeneral,
                icon: const Icon(Icons.groups_outlined, size: 18),
                label: const Text('Emitir a CLIENTES VARIOS'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Líneas del comprobante.
class _SeccionItems extends StatelessWidget {
  const _SeccionItems({
    required this.borrador,
    required this.onAgregar,
    required this.onEditar,
    required this.onEliminar,
  });

  final Comprobante borrador;
  final VoidCallback onAgregar;
  final ValueChanged<int> onEditar;
  final ValueChanged<int> onEliminar;

  @override
  Widget build(BuildContext context) {
    final items = borrador.items;
    final lineas = borrador.totales.lineas;

    return Seccion(
      titulo: 'Ítems',
      icono: Icons.list_alt_rounded,
      subtitulo: items.isEmpty ? null : '${items.length} línea${items.length == 1 ? '' : 's'}',
      accion: items.isEmpty
          ? null
          : TextButton.icon(
              onPressed: onAgregar,
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Agregar'),
            ),
      hijo: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (items.isEmpty)
            EstadoVacio(
              compacto: true,
              icono: Icons.playlist_add_rounded,
              titulo: 'Sin ítems',
              mensaje: 'Agrega los bienes o servicios que vas a facturar.',
              etiquetaAccion: 'Agregar el primero',
              onAccion: onAgregar,
            )
          else
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0) const Divider(height: 1),
              FilaItemComprobante(
                item: items[i],
                linea: lineas[i],
                moneda: borrador.moneda,
                onEditar: () => onEditar(i),
                onEliminar: () => onEliminar(i),
              ),
            ],
        ],
      ),
    );
  }
}

/// Moneda, forma de pago, vencimiento y observaciones.
class _SeccionCondiciones extends StatelessWidget {
  const _SeccionCondiciones({
    required this.borrador,
    required this.onCambiarMoneda,
    required this.onCambiarFormaPago,
    required this.onElegirVencimiento,
    required this.onCambiarObservaciones,
  });

  final Comprobante borrador;
  final ValueChanged<Moneda> onCambiarMoneda;
  final ValueChanged<FormaPago> onCambiarFormaPago;
  final VoidCallback onElegirVencimiento;
  final ValueChanged<String> onCambiarObservaciones;

  @override
  Widget build(BuildContext context) {
    return Seccion(
      titulo: 'Condiciones',
      icono: Icons.tune_rounded,
      hijo: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<Moneda>(
                  initialValue: borrador.moneda,
                  decoration: const InputDecoration(labelText: 'Moneda'),
                  isExpanded: true,
                  items: [
                    for (final moneda in Moneda.values)
                      DropdownMenuItem(
                        value: moneda,
                        child: Text(
                          '${moneda.simbolo}  ${moneda.etiqueta}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  onChanged: (moneda) {
                    if (moneda != null) onCambiarMoneda(moneda);
                  },
                ),
              ),
              const SizedBox(width: Espaciado.sm),
              Expanded(
                child: DropdownButtonFormField<FormaPago>(
                  initialValue: borrador.formaPago,
                  decoration: const InputDecoration(labelText: 'Forma de pago'),
                  isExpanded: true,
                  items: [
                    for (final forma in FormaPago.values)
                      DropdownMenuItem(
                        value: forma,
                        child: Text(forma.etiqueta),
                      ),
                  ],
                  onChanged: (forma) {
                    if (forma != null) onCambiarFormaPago(forma);
                  },
                ),
              ),
            ],
          ),
          if (borrador.formaPago == FormaPago.credito) ...[
            const SizedBox(height: Espaciado.md),
            _CampoFecha(
              etiqueta: 'Fecha de vencimiento',
              valor: borrador.fechaVencimiento == null
                  ? 'Sin definir'
                  : formatearFechaLarga(borrador.fechaVencimiento!),
              onTap: onElegirVencimiento,
            ),
          ],
          const SizedBox(height: Espaciado.md),
          TextFormField(
            initialValue: borrador.observaciones ?? '',
            decoration: const InputDecoration(
              labelText: 'Observaciones (opcional)',
              hintText: 'Notas que se imprimen en el RIDE',
              prefixIcon: Icon(Icons.sticky_note_2_outlined),
            ),
            minLines: 2,
            maxLines: 4,
            textCapitalization: TextCapitalization.sentences,
            onChanged: onCambiarObservaciones,
          ),
        ],
      ),
    );
  }
}

/// Campo de sólo lectura que abre el selector de fechas al tocarlo.
class _CampoFecha extends StatelessWidget {
  const _CampoFecha({
    required this.etiqueta,
    required this.valor,
    required this.onTap,
  });

  final String etiqueta;
  final String valor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Radios.chico),
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: etiqueta,
          prefixIcon: const Icon(Icons.event_outlined),
          suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
        ),
        child: Text(valor, style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}

/// Barra fija con el importe a pagar y el botón de emisión.
class _BarraEmision extends StatelessWidget {
  const _BarraEmision({
    required this.totales,
    required this.moneda,
    required this.emitiendo,
    required this.onEmitir,
  });

  final Totales totales;
  final Moneda moneda;
  final bool emitiendo;
  final VoidCallback? onEmitir;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return Material(
      color: esquema.surfaceContainerLowest,
      elevation: 0,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(Espaciado.md),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: esquema.outlineVariant.withValues(alpha: 0.6)),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Total a pagar', style: textos.bodySmall),
                    Text(
                      formatearMoneda(totales.importeTotal, moneda: moneda),
                      style: textos.headlineSmall?.copyWith(
                        color: esquema.primary,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Espaciado.sm),
              FilledButton.icon(
                onPressed: onEmitir,
                icon: emitiendo
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send_rounded),
                label: Text(emitiendo ? 'Emitiendo…' : 'Emitir'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
