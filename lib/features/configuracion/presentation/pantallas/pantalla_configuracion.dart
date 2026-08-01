import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../../core/database/tablas.dart';
import '../../../../core/router/rutas.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/esqueletos.dart';
import '../../../../core/widgets/seccion.dart';
import '../../../empresa/presentation/providers/empresa_providers.dart';
import '../../domain/entidades/ajustes.dart';
import '../providers/ajustes_providers.dart';

/// Configuración de la app: modo de operación, conexión con la pasarela,
/// consulta de documentos, datos del emisor y apariencia.
///
/// Nada se escribe en el código: los valores llegan por
/// `--dart-define-from-file=env.json` y lo que se guarda aquí los sobrescribe
/// en la tabla `ajustes`.
class PantallaConfiguracion extends ConsumerWidget {
  const PantallaConfiguracion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ajustes = ref.watch(ajustesProvider);
    final empresa = ref.watch(empresaProvider).value;

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: switch (ajustes) {
        AsyncData(:final value) => ListView(
            padding: const EdgeInsets.fromLTRB(
              Espaciado.md,
              0,
              Espaciado.md,
              Espaciado.xxl,
            ),
            children: [
              _SeccionEmision(ajustes: value),
              const SizedBox(height: Espaciado.sm),
              _SeccionConexion(ajustes: value),
              const SizedBox(height: Espaciado.sm),
              _SeccionConsulta(ajustes: value),
              const SizedBox(height: Espaciado.sm),
              Seccion(
                titulo: 'Emisor',
                icono: Icons.apartment_rounded,
                hijo: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.business_outlined),
                  title: Text(empresa?.razonSocial ?? 'Sin configurar'),
                  subtitle: Text(
                    empresa == null
                        ? 'Completa los datos del emisor'
                        : 'RUC ${empresa.ruc} · '
                            '${empresa.seriesFactura.length + empresa.seriesBoleta.length} series',
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => context.push(Rutas.datosEmpresa),
                ),
              ),
              const SizedBox(height: Espaciado.sm),
              _SeccionApariencia(ajustes: value),
              const SizedBox(height: Espaciado.sm),
              const _SeccionAcercaDe(),
            ],
          ),
        AsyncError(:final error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(Espaciado.lg),
              child: Text(
                'No se pudo leer la configuración.\n$error',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        _ => const EsqueletoLista(filas: 6),
      },
    );
  }
}

/// Modo de operación: en Simulación nada sale del dispositivo.
class _SeccionEmision extends ConsumerWidget {
  const _SeccionEmision({required this.ajustes});

  final Ajustes ajustes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textos = Theme.of(context).textTheme;
    final esRealSinConfigurar =
        ajustes.modoOperacion == ModoOperacion.real && !ajustes.puedeEmitirEnReal;

    return Seccion(
      titulo: 'Modo de operación',
      icono: Icons.swap_horiz_rounded,
      subtitulo: 'Determina si los comprobantes viajan a SUNAT.',
      hijo: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SegmentedButton<ModoOperacion>(
            segments: [
              for (final modo in ModoOperacion.values)
                ButtonSegment(
                  value: modo,
                  label: Text(modo.etiqueta),
                  icon: Icon(
                    modo == ModoOperacion.simulacion
                        ? Icons.science_outlined
                        : Icons.cloud_outlined,
                  ),
                ),
            ],
            selected: {ajustes.modoOperacion},
            onSelectionChanged: (seleccion) => ref
                .read(controladorAjustesProvider.notifier)
                .cambiarModoOperacion(seleccion.first),
          ),
          const SizedBox(height: Espaciado.sm),
          Text(
            ajustes.modoOperacion == ModoOperacion.simulacion
                ? 'Los comprobantes se guardan y se imprimen con marca de agua, '
                    'pero no se envían a SUNAT.'
                : 'Los comprobantes se firman y envían al ambiente BETA de SUNAT '
                    'a través de Lycet.',
            style: textos.bodySmall,
          ),
          if (esRealSinConfigurar) ...[
            const SizedBox(height: Espaciado.xs),
            _Aviso(
              icono: Icons.warning_amber_rounded,
              color: ColoresEstado.advertencia(context),
              mensaje: 'Falta la URL de Lycet: hasta configurarla, la emisión '
                  'seguirá cayendo a modo Simulación.',
            ),
          ],
        ],
      ),
    );
  }
}

/// Conexión con la pasarela que firma y envía a SUNAT (Fase 3).
class _SeccionConexion extends ConsumerWidget {
  const _SeccionConexion({required this.ajustes});

  final Ajustes ajustes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Se observa en lugar de leerse: `guardarConexionLycet` escribe dos claves
    // con un `await` entre medias, y un provider `autoDispose` sin oyentes se
    // destruiría antes de la segunda.
    final controlador = ref.watch(controladorAjustesProvider.notifier);

    return Seccion(
      titulo: 'Pasarela de emisión',
      icono: Icons.cloud_sync_outlined,
      subtitulo: 'Lycet, la API REST sobre Greenter que firma el XML.',
      hijo: Column(
        children: [
          _FilaAjuste(
            icono: Icons.link_rounded,
            titulo: 'URL del servicio',
            valor: ajustes.lycetUrl,
            vacio: 'Sin configurar',
            onTap: () => _editar(context, controlador),
          ),
          _FilaAjuste(
            icono: Icons.key_outlined,
            titulo: 'Token de acceso',
            valor: _enmascarar(ajustes.lycetToken),
            vacio: 'Sin token',
            onTap: () => _editar(context, controlador),
          ),
        ],
      ),
    );
  }

  Future<void> _editar(BuildContext context, ControladorAjustes controlador) async {
    final valores = await _HojaCredenciales.mostrar(
      context,
      titulo: 'Conexión con Lycet',
      descripcion: 'La URL apunta a tu instancia de Lycet. El token viaja en la '
          'cabecera de autorización y se guarda sólo en este dispositivo.',
      etiquetaPrimerCampo: 'URL del servicio',
      etiquetaSegundoCampo: 'Token de acceso',
      primerValor: ajustes.lycetUrl,
      segundoValor: ajustes.lycetToken,
      pistaPrimerCampo: 'https://lycet.example.com',
    );
    if (valores == null) return;

    await controlador.guardarConexionLycet(url: valores.$1, token: valores.$2);
  }
}

/// Proveedor de consulta RUC/DNI (Fase 2).
class _SeccionConsulta extends ConsumerWidget {
  const _SeccionConsulta({required this.ajustes});

  final Ajustes ajustes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controlador = ref.watch(controladorAjustesProvider.notifier);

    return Seccion(
      titulo: 'Consulta RUC/DNI',
      icono: Icons.travel_explore_rounded,
      subtitulo: 'Autocompleta los datos del cliente desde una API pública.',
      hijo: Column(
        children: [
          _FilaAjuste(
            icono: Icons.dns_outlined,
            titulo: 'Proveedor',
            valor: ajustes.proveedorConsulta,
            vacio: 'Sin proveedor',
            onTap: () => _editar(context, controlador),
          ),
          _FilaAjuste(
            icono: Icons.key_outlined,
            titulo: 'Token del proveedor',
            valor: _enmascarar(ajustes.tokenConsulta),
            vacio: 'Sin token',
            onTap: () => _editar(context, controlador),
          ),
          if (!ajustes.puedeConsultarDocumentos)
            Padding(
              padding: const EdgeInsets.only(top: Espaciado.xs),
              child: _Aviso(
                icono: Icons.info_outline_rounded,
                color: ColoresEstado.informacion(context),
                mensaje: 'Sin token la consulta queda desactivada; los datos del '
                    'cliente se teclean a mano.',
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _editar(BuildContext context, ControladorAjustes controlador) async {
    final valores = await _HojaCredenciales.mostrar(
      context,
      titulo: 'Consulta de documentos',
      descripcion: 'El proveedor se guarda por su nombre corto para poder '
          'cambiarlo sin tocar el código.',
      etiquetaPrimerCampo: 'Proveedor',
      etiquetaSegundoCampo: 'Token',
      primerValor: ajustes.proveedorConsulta,
      segundoValor: ajustes.tokenConsulta,
      pistaPrimerCampo: 'decolecta',
    );
    if (valores == null) return;

    await controlador.guardarConsultaDocumentos(
      proveedor: valores.$1,
      token: valores.$2,
    );
  }
}

/// Tema claro, oscuro o el del sistema.
class _SeccionApariencia extends ConsumerWidget {
  const _SeccionApariencia({required this.ajustes});

  final Ajustes ajustes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const opciones = [
      (modo: ThemeMode.system, etiqueta: 'Sistema', icono: Icons.brightness_auto_rounded),
      (modo: ThemeMode.light, etiqueta: 'Claro', icono: Icons.light_mode_outlined),
      (modo: ThemeMode.dark, etiqueta: 'Oscuro', icono: Icons.dark_mode_outlined),
    ];

    return Seccion(
      titulo: 'Apariencia',
      icono: Icons.palette_outlined,
      hijo: SegmentedButton<ThemeMode>(
        segments: [
          for (final opcion in opciones)
            ButtonSegment(
              value: opcion.modo,
              label: Text(opcion.etiqueta),
              icon: Icon(opcion.icono),
            ),
        ],
        selected: {ajustes.temaApp},
        onSelectionChanged: (seleccion) => ref
            .read(controladorAjustesProvider.notifier)
            .cambiarTema(seleccion.first),
      ),
    );
  }
}

class _SeccionAcercaDe extends StatelessWidget {
  const _SeccionAcercaDe();

  @override
  Widget build(BuildContext context) {
    return Seccion(
      titulo: 'Acerca de',
      icono: Icons.info_outline_rounded,
      hijo: Column(
        children: [
          const FilaDato(etiqueta: 'Aplicación', valor: 'app_api_sunat'),
          const FilaDato(etiqueta: 'Estándar', valor: 'UBL 2.1 (SUNAT)'),
          FilaDato(
            etiqueta: 'Tasa de IGV aplicada',
            valor: '${(kTasaIgv * 100).toStringAsFixed(0)} %',
          ),
        ],
      ),
    );
  }
}

/// Fila «etiqueta + valor» que abre el editor correspondiente al tocarla.
class _FilaAjuste extends StatelessWidget {
  const _FilaAjuste({
    required this.icono,
    required this.titulo,
    required this.valor,
    required this.vacio,
    required this.onTap,
  });

  final IconData icono;
  final String titulo;
  final String valor;
  final String vacio;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final estaVacio = valor.trim().isEmpty;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icono),
      title: Text(titulo),
      subtitle: Text(
        estaVacio ? vacio : valor,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: estaVacio ? esquema.onSurfaceVariant : esquema.onSurface,
        ),
      ),
      trailing: const Icon(Icons.edit_outlined, size: 18),
      onTap: onTap,
    );
  }
}

/// Franja de aviso con ícono, para explicaciones cortas dentro de una sección.
class _Aviso extends StatelessWidget {
  const _Aviso({
    required this.icono,
    required this.color,
    required this.mensaje,
  });

  final IconData icono;
  final Color color;
  final String mensaje;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Espaciado.xs),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(Radios.chico),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, size: 16, color: color),
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

/// Hoja para editar un par «servicio + credencial».
///
/// Se comparte entre Lycet y el proveedor de consulta porque ambos son lo
/// mismo: una dirección y un secreto que nunca se escriben en el código.
class _HojaCredenciales extends StatefulWidget {
  const _HojaCredenciales({
    required this.titulo,
    required this.descripcion,
    required this.etiquetaPrimerCampo,
    required this.etiquetaSegundoCampo,
    required this.primerValor,
    required this.segundoValor,
    this.pistaPrimerCampo,
  });

  final String titulo;
  final String descripcion;
  final String etiquetaPrimerCampo;
  final String etiquetaSegundoCampo;
  final String primerValor;
  final String segundoValor;
  final String? pistaPrimerCampo;

  static Future<(String, String)?> mostrar(
    BuildContext context, {
    required String titulo,
    required String descripcion,
    required String etiquetaPrimerCampo,
    required String etiquetaSegundoCampo,
    required String primerValor,
    required String segundoValor,
    String? pistaPrimerCampo,
  }) {
    return showModalBottomSheet<(String, String)>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _HojaCredenciales(
        titulo: titulo,
        descripcion: descripcion,
        etiquetaPrimerCampo: etiquetaPrimerCampo,
        etiquetaSegundoCampo: etiquetaSegundoCampo,
        primerValor: primerValor,
        segundoValor: segundoValor,
        pistaPrimerCampo: pistaPrimerCampo,
      ),
    );
  }

  @override
  State<_HojaCredenciales> createState() => _HojaCredencialesState();
}

class _HojaCredencialesState extends State<_HojaCredenciales> {
  late final _primero = TextEditingController(text: widget.primerValor);
  late final _segundo = TextEditingController(text: widget.segundoValor);
  bool _mostrarSecreto = false;

  @override
  void dispose() {
    _primero.dispose();
    _segundo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          Espaciado.md,
          0,
          Espaciado.md,
          Espaciado.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.titulo, style: textos.titleMedium),
            const SizedBox(height: Espaciado.xxs),
            Text(widget.descripcion, style: textos.bodySmall),
            const SizedBox(height: Espaciado.md),
            TextField(
              controller: _primero,
              autocorrect: false,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: widget.etiquetaPrimerCampo,
                hintText: widget.pistaPrimerCampo,
                prefixIcon: const Icon(Icons.link_rounded),
              ),
            ),
            const SizedBox(height: Espaciado.md),
            TextField(
              controller: _segundo,
              autocorrect: false,
              enableSuggestions: false,
              obscureText: !_mostrarSecreto,
              decoration: InputDecoration(
                labelText: widget.etiquetaSegundoCampo,
                prefixIcon: const Icon(Icons.key_outlined),
                suffixIcon: IconButton(
                  tooltip: _mostrarSecreto ? 'Ocultar' : 'Mostrar',
                  icon: Icon(
                    _mostrarSecreto
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: () =>
                      setState(() => _mostrarSecreto = !_mostrarSecreto),
                ),
              ),
            ),
            const SizedBox(height: Espaciado.md),
            FilledButton.icon(
              onPressed: () => Navigator.pop(
                context,
                (_primero.text.trim(), _segundo.text.trim()),
              ),
              icon: const Icon(Icons.save_outlined),
              label: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Deja ver los últimos caracteres para reconocer el token sin exponerlo.
String _enmascarar(String secreto) {
  final limpio = secreto.trim();
  if (limpio.isEmpty) return '';
  if (limpio.length <= 4) return '•' * limpio.length;
  return '${'•' * 8}${limpio.substring(limpio.length - 4)}';
}
