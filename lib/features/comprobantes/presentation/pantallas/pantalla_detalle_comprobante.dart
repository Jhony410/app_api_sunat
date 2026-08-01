import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:printing/printing.dart';

import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../../core/router/rutas.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatos.dart';
import '../../../../core/widgets/esqueletos.dart';
import '../../../../core/widgets/estado_vacio.dart';
import '../../../../core/widgets/etiqueta_estado.dart';
import '../../../../core/widgets/seccion.dart';
import '../../../configuracion/presentation/providers/ajustes_providers.dart';
import '../../../empresa/domain/entidades/empresa.dart';
import '../../../empresa/presentation/providers/empresa_providers.dart';
import '../../domain/entidades/comprobante.dart';
import '../providers/comprobantes_providers.dart';
import '../providers/emision_providers.dart';
import '../providers/ride_providers.dart';
import '../widgets/panel_totales.dart';
import '../widgets/tabla_items.dart';

/// Detalle de un comprobante ya guardado, con su representación impresa.
///
/// La pestaña «Detalle» muestra los datos tal como están en la base; la
/// pestaña «RIDE» renderiza el mismo PDF que se imprime o se comparte, para
/// que no haya dos versiones del documento.
class PantallaDetalleComprobante extends ConsumerWidget {
  const PantallaDetalleComprobante({required this.comprobanteId, super.key});

  final int comprobanteId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comprobante = ref.watch(comprobantePorIdProvider(comprobanteId));
    final empresa = ref.watch(empresaProvider).value;

    return switch (comprobante) {
      AsyncData(:final value) when value == null => Scaffold(
          appBar: AppBar(title: const Text('Comprobante')),
          body: EstadoVacio(
            icono: Icons.search_off_rounded,
            titulo: 'Comprobante no encontrado',
            mensaje: 'Es posible que se haya eliminado desde otra pantalla.',
            etiquetaAccion: 'Ver el historial',
            onAccion: () => context.go(Rutas.historial),
          ),
        ),
      AsyncData(:final value) when empresa != null => _Contenido(
          comprobante: value!,
          empresa: empresa,
        ),
      AsyncError(:final error) => Scaffold(
          appBar: AppBar(title: const Text('Comprobante')),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(Espaciado.lg),
              child: Text(
                'No se pudo cargar el comprobante.\n$error',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      _ => Scaffold(
          appBar: AppBar(title: const Text('Comprobante')),
          body: const EsqueletoLista(filas: 6),
        ),
    };
  }
}

class _Contenido extends ConsumerStatefulWidget {
  const _Contenido({required this.comprobante, required this.empresa});

  final Comprobante comprobante;
  final Empresa empresa;

  @override
  ConsumerState<_Contenido> createState() => _ContenidoState();
}

class _ContenidoState extends ConsumerState<_Contenido> {
  bool _trabajando = false;

  /// Controladores observados —no leídos— en `build`.
  ///
  /// Son providers `autoDispose` y sus métodos siguen usando `ref` después de
  /// varios `await` (generar el PDF, hablar con la pasarela). Observarlos los
  /// mantiene vivos mientras la pantalla lo esté; leerlos sin más los
  /// destruiría a mitad de la operación.
  late ControladorRide _ride;
  late ControladorEmision _emision;

  Comprobante get _comprobante => widget.comprobante;
  Empresa get _empresa => widget.empresa;

  /// Envuelve las acciones sobre el PDF: bloquea la barra mientras generan y
  /// convierte cualquier fallo en un aviso, nunca en una pantalla rota.
  Future<void> _ejecutar(
    Future<void> Function() accion, {
    String? exito,
  }) async {
    if (_trabajando) return;
    setState(() => _trabajando = true);
    try {
      await accion();
      if (mounted && exito != null) _avisar(exito);
    } catch (error) {
      if (mounted) _avisar('No se pudo completar la acción: $error');
    } finally {
      if (mounted) setState(() => _trabajando = false);
    }
  }

  Future<void> _imprimir() =>
      _ejecutar(() => _ride.imprimir(_comprobante, _empresa));

  Future<void> _compartir() =>
      _ejecutar(() => _ride.compartir(_comprobante, _empresa));

  Future<void> _guardar() => _ejecutar(() async {
        final ruta = await _ride.guardar(_comprobante, _empresa);
        if (mounted) _avisar('PDF guardado en $ruta');
      });

  Future<void> _reintentarEnvio() async {
    final ajustes = ref.read(ajustesProvider).value;
    if (ajustes == null || !ajustes.puedeEmitirEnReal) {
      _avisar(
        'Activa la emisión real y configura Lycet para reenviar a SUNAT.',
      );
      return;
    }

    await _ejecutar(() async {
      final resultado = await _emision.reintentar(_comprobante);
      if (!mounted || resultado == null) return;
      _avisar(
        resultado.degradadoASimulacion
            ? 'No se pudo enviar a SUNAT; el comprobante sigue en Simulación.'
            : 'Estado actualizado: ${resultado.estado.etiqueta}.',
      );
    });
  }

  Future<void> _eliminar() async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar el comprobante?'),
        content: Text(
          'Se borrará ${_comprobante.numeroCompleto} y sus ítems. El '
          'correlativo ya consumido no se reutiliza, para no romper la '
          'numeración de la serie.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmado != true || !mounted) return;

    await ref.read(comprobanteRepositorioProvider).eliminar(_comprobante.id!);
    if (mounted) context.pop();
  }

  void _avisar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    final comprobante = _comprobante;
    _ride = ref.watch(controladorRideProvider.notifier);
    _emision = ref.watch(controladorEmisionProvider.notifier);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Hero(
            tag: 'comprobante-${comprobante.id}',
            child: Material(
              type: MaterialType.transparency,
              child: Text(comprobante.numeroCompleto),
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (opcion) => switch (opcion) {
                'guardar' => _guardar(),
                'reintentar' => _reintentarEnvio(),
                'eliminar' => _eliminar(),
                _ => null,
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'guardar',
                  child: ListTile(
                    leading: Icon(Icons.save_alt_rounded),
                    title: Text('Guardar PDF'),
                  ),
                ),
                if (comprobante.admiteEnvio)
                  const PopupMenuItem(
                    value: 'reintentar',
                    child: ListTile(
                      leading: Icon(Icons.cloud_upload_outlined),
                      title: Text('Reintentar envío'),
                    ),
                  ),
                const PopupMenuItem(
                  value: 'eliminar',
                  child: ListTile(
                    leading: Icon(Icons.delete_outline_rounded),
                    title: Text('Eliminar'),
                  ),
                ),
              ],
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.article_outlined), text: 'Detalle'),
              Tab(icon: Icon(Icons.picture_as_pdf_outlined), text: 'RIDE'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _PestanaDetalle(comprobante: comprobante, empresa: _empresa),
            _PestanaRide(comprobante: comprobante, empresa: _empresa),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Espaciado.md),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _trabajando ? null : _imprimir,
                    icon: const Icon(Icons.print_outlined),
                    label: const Text('Imprimir'),
                  ),
                ),
                const SizedBox(width: Espaciado.sm),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _trabajando ? null : _compartir,
                    icon: _trabajando
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.ios_share_rounded),
                    label: const Text('Compartir'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Datos del comprobante agrupados por bloques.
class _PestanaDetalle extends StatelessWidget {
  const _PestanaDetalle({required this.comprobante, required this.empresa});

  final Comprobante comprobante;
  final Empresa empresa;

  @override
  Widget build(BuildContext context) {
    final totales = comprobante.totales;
    final cliente = comprobante.cliente;

    return ListView(
      padding: const EdgeInsets.all(Espaciado.md),
      children: [
        _Encabezado(comprobante: comprobante),
        const SizedBox(height: Espaciado.sm),

        if (comprobante.mensajeSunat != null &&
            comprobante.mensajeSunat!.trim().isNotEmpty) ...[
          _AvisoSunat(
            mensaje: comprobante.mensajeSunat!,
            estado: comprobante.estadoSunat,
          ),
          const SizedBox(height: Espaciado.sm),
        ],

        Seccion(
          titulo: 'Receptor',
          icono: Icons.person_outline_rounded,
          subtitulo: 'Copia guardada al emitir; no cambia si se edita la ficha.',
          hijo: Column(
            children: [
              FilaDato(
                etiqueta: cliente.tipoDocumento == TipoDocumentoIdentidad.ruc
                    ? 'Razón social'
                    : 'Nombres',
                valor: cliente.razonSocialONombres,
              ),
              FilaDato(
                etiqueta: cliente.tipoDocumento.etiqueta,
                valor: cliente.numeroDocumento,
              ),
              if (cliente.direccion != null && cliente.direccion!.isNotEmpty)
                FilaDato(etiqueta: 'Dirección', valor: cliente.direccion!),
              if (cliente.email != null && cliente.email!.isNotEmpty)
                FilaDato(etiqueta: 'Correo', valor: cliente.email!),
            ],
          ),
        ),
        const SizedBox(height: Espaciado.sm),

        Seccion(
          titulo: 'Condiciones',
          icono: Icons.tune_rounded,
          hijo: Column(
            children: [
              FilaDato(
                etiqueta: 'Fecha de emisión',
                valor: formatearFechaLarga(comprobante.fechaEmision),
              ),
              FilaDato(
                etiqueta: 'Forma de pago',
                valor: comprobante.formaPago.etiqueta,
              ),
              if (comprobante.fechaVencimiento != null)
                FilaDato(
                  etiqueta: 'Vence el',
                  valor: formatearFecha(comprobante.fechaVencimiento!),
                ),
              FilaDato(etiqueta: 'Moneda', valor: comprobante.moneda.etiqueta),
              if (comprobante.observaciones != null &&
                  comprobante.observaciones!.trim().isNotEmpty)
                FilaDato(
                  etiqueta: 'Observaciones',
                  valor: comprobante.observaciones!,
                ),
            ],
          ),
        ),
        const SizedBox(height: Espaciado.sm),

        Seccion(
          titulo: 'Ítems',
          icono: Icons.list_alt_rounded,
          subtitulo:
              '${comprobante.items.length} línea${comprobante.items.length == 1 ? '' : 's'}',
          hijo: Column(
            children: [
              for (var i = 0; i < comprobante.items.length; i++) ...[
                if (i > 0) const Divider(height: 1),
                FilaItemComprobante(
                  item: comprobante.items[i],
                  linea: totales.lineas[i],
                  moneda: comprobante.moneda,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: Espaciado.sm),

        Seccion(
          titulo: 'Totales',
          icono: Icons.calculate_outlined,
          hijo: PanelTotales(totales: totales, moneda: comprobante.moneda),
        ),
        const SizedBox(height: Espaciado.sm),

        Seccion(
          titulo: 'Trazabilidad',
          icono: Icons.fingerprint_rounded,
          subtitulo: 'Lo que identifica al documento ante SUNAT.',
          hijo: Column(
            children: [
              FilaDato(etiqueta: 'RUC emisor', valor: empresa.ruc),
              FilaDato(
                etiqueta: 'Tipo (catálogo 01)',
                valor: '${comprobante.tipo.codigo} — ${comprobante.tipo.etiqueta}',
              ),
              FilaDato(
                etiqueta: 'Valor resumen',
                valor: comprobante.hashCodigo ?? 'Sin generar',
              ),
              if (comprobante.ticket != null)
                FilaDato(etiqueta: 'Ticket', valor: comprobante.ticket!),
              if (comprobante.creadoEn != null)
                FilaDato(
                  etiqueta: 'Registrado',
                  valor: formatearFechaHora(comprobante.creadoEn!),
                ),
            ],
          ),
        ),
        const SizedBox(height: Espaciado.lg),
      ],
    );
  }
}

/// Tarjeta superior: tipo, estado e importe total.
class _Encabezado extends StatelessWidget {
  const _Encabezado({required this.comprobante});

  final Comprobante comprobante;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Espaciado.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                EtiquetaTipoComprobante(comprobante.tipo),
                const SizedBox(width: Espaciado.xs),
                EtiquetaEstado(comprobante.estadoSunat),
              ],
            ),
            const SizedBox(height: Espaciado.sm),
            Text(comprobante.numeroCompleto, style: textos.headlineSmall),
            Text(
              comprobante.cliente.razonSocialONombres,
              style: textos.bodyMedium?.copyWith(color: esquema.onSurfaceVariant),
            ),
            const SizedBox(height: Espaciado.sm),
            Text(
              formatearMoneda(
                comprobante.totales.importeTotal,
                moneda: comprobante.moneda,
              ),
              style: textos.displaySmall?.copyWith(color: esquema.primary),
            ),
          ],
        ),
      ),
    );
  }
}

/// Mensaje devuelto por SUNAT o por la degradación a modo Simulación.
class _AvisoSunat extends StatelessWidget {
  const _AvisoSunat({required this.mensaje, required this.estado});

  final String mensaje;
  final EstadoSunat estado;

  @override
  Widget build(BuildContext context) {
    final color = switch (estado) {
      EstadoSunat.aceptado => ColoresEstado.exito(context),
      EstadoSunat.rechazado => Theme.of(context).colorScheme.error,
      _ => ColoresEstado.advertencia(context),
    };

    return Container(
      padding: const EdgeInsets.all(Espaciado.sm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(Radios.chico),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, size: 18, color: color),
          const SizedBox(width: Espaciado.xs),
          Expanded(
            child: Text(
              mensaje,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: color, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

/// Previsualización del PDF, generada con el mismo `GeneradorRide` que usan
/// imprimir, compartir y guardar.
class _PestanaRide extends ConsumerWidget {
  const _PestanaRide({required this.comprobante, required this.empresa});

  final Comprobante comprobante;
  final Empresa empresa;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ride = ref.watch(controladorRideProvider.notifier);

    return PdfPreview(
      // Los botones propios de `PdfPreview` se ocultan: las acciones viven en
      // la barra inferior, iguales en las dos pestañas.
      allowPrinting: false,
      allowSharing: false,
      canChangePageFormat: false,
      canChangeOrientation: false,
      canDebug: false,
      useActions: false,
      pdfFileName:
          ref.read(generadorRideProvider).nombreArchivo(comprobante, empresa),
      build: (_) => ride.bytes(comprobante, empresa),
    );
  }
}
