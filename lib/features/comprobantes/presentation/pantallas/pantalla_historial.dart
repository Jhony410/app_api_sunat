import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../../core/router/rutas.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatos.dart';
import '../../../../core/widgets/estado_vacio.dart';
import '../../../../core/widgets/esqueletos.dart';
import '../providers/comprobantes_providers.dart';
import '../widgets/fila_comprobante.dart';

/// Historial de comprobantes con buscador y filtros por tipo, estado y fecha.
class PantallaHistorial extends ConsumerStatefulWidget {
  const PantallaHistorial({super.key});

  @override
  ConsumerState<PantallaHistorial> createState() => _PantallaHistorialState();
}

class _PantallaHistorialState extends ConsumerState<PantallaHistorial> {
  late final TextEditingController _buscador;

  @override
  void initState() {
    super.initState();
    _buscador = TextEditingController(text: ref.read(filtroHistorialProvider).texto);
  }

  @override
  void dispose() {
    _buscador.dispose();
    super.dispose();
  }

  Future<void> _elegirRangoFechas() async {
    final filtro = ref.read(filtroHistorialProvider);
    final ahora = DateTime.now();

    final rango = await showDateRangePicker(
      context: context,
      firstDate: DateTime(ahora.year - 5),
      lastDate: DateTime(ahora.year + 1, 12, 31),
      initialDateRange: filtro.desde != null && filtro.hasta != null
          ? DateTimeRange(start: filtro.desde!, end: filtro.hasta!)
          : null,
      locale: const Locale('es', 'PE'),
      helpText: 'Rango de fechas de emisión',
      saveText: 'Aplicar',
    );

    if (rango != null) {
      ref
          .read(filtroHistorialProvider.notifier)
          .cambiarRangoFechas(rango.start, rango.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtro = ref.watch(filtroHistorialProvider);
    final historial = ref.watch(historialComprobantesProvider);
    final notificador = ref.read(filtroHistorialProvider.notifier);
    final textos = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          if (filtro.filtrosActivos > 0)
            TextButton.icon(
              onPressed: () {
                _buscador.clear();
                notificador.limpiar();
              },
              icon: const Icon(Icons.filter_alt_off_outlined, size: 18),
              label: Text('Limpiar (${filtro.filtrosActivos})'),
            ),
          const SizedBox(width: Espaciado.xs),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Espaciado.md,
              0,
              Espaciado.md,
              Espaciado.xs,
            ),
            child: TextField(
              controller: _buscador,
              onChanged: notificador.cambiarTexto,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Buscar por número, cliente o documento',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: filtro.texto.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Limpiar búsqueda',
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          _buscador.clear();
                          notificador.cambiarTexto('');
                        },
                      ),
              ),
            ),
          ),

          // Fila de filtros rápidos, desplazable en horizontal.
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: Espaciado.md),
              children: [
                _ChipFiltro(
                  etiqueta: filtro.desde == null
                      ? 'Fechas'
                      : '${formatearFecha(filtro.desde!)} – ${formatearFecha(filtro.hasta!)}',
                  activo: filtro.desde != null,
                  icono: Icons.date_range_outlined,
                  onTap: _elegirRangoFechas,
                  onQuitar: filtro.desde == null
                      ? null
                      : () => notificador.cambiarRangoFechas(null, null),
                ),
                const SizedBox(width: Espaciado.xs),
                for (final tipo in TipoComprobante.values)
                  Padding(
                    padding: const EdgeInsets.only(right: Espaciado.xs),
                    child: _ChipFiltro(
                      etiqueta: tipo.etiqueta,
                      activo: filtro.tipo == tipo,
                      onTap: () => notificador
                          .cambiarTipo(filtro.tipo == tipo ? null : tipo),
                    ),
                  ),
                for (final estado in EstadoSunat.values)
                  Padding(
                    padding: const EdgeInsets.only(right: Espaciado.xs),
                    child: _ChipFiltro(
                      etiqueta: estado.etiqueta,
                      activo: filtro.estado == estado,
                      onTap: () => notificador
                          .cambiarEstado(filtro.estado == estado ? null : estado),
                    ),
                  ),
              ],
            ),
          ),

          Expanded(
            child: switch (historial) {
              AsyncData(:final value) when value.isEmpty => EstadoVacio(
                  icono: filtro.estaVacio
                      ? Icons.receipt_long_outlined
                      : Icons.search_off_rounded,
                  titulo: filtro.estaVacio
                      ? 'Aún no hay comprobantes'
                      : 'Sin resultados',
                  mensaje: filtro.estaVacio
                      ? 'Emite tu primera factura o boleta y la verás aquí, con su estado ante SUNAT.'
                      : 'Ningún comprobante coincide con los filtros aplicados.',
                  etiquetaAccion: filtro.estaVacio ? 'Nuevo comprobante' : 'Limpiar filtros',
                  onAccion: filtro.estaVacio
                      ? () => context.push(Rutas.nuevoComprobante)
                      : () {
                          _buscador.clear();
                          notificador.limpiar();
                        },
                ),
              AsyncData(:final value) => ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    Espaciado.md,
                    Espaciado.xs,
                    Espaciado.md,
                    Espaciado.xxl + Espaciado.lg,
                  ),
                  itemCount: value.length,
                  separatorBuilder: (_, _) => const SizedBox(height: Espaciado.xs),
                  itemBuilder: (context, indice) => FilaComprobante(value[indice]),
                ),
              AsyncError(:final error) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(Espaciado.lg),
                    child: Text(
                      'No se pudo cargar el historial.\n$error',
                      textAlign: TextAlign.center,
                      style: textos.bodyMedium,
                    ),
                  ),
                ),
              _ => const EsqueletoLista(filas: 8),
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Rutas.nuevoComprobante),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}

class _ChipFiltro extends StatelessWidget {
  const _ChipFiltro({
    required this.etiqueta,
    required this.activo,
    required this.onTap,
    this.icono,
    this.onQuitar,
  });

  final String etiqueta;
  final bool activo;
  final VoidCallback onTap;
  final IconData? icono;
  final VoidCallback? onQuitar;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FilterChip(
        selected: activo,
        onSelected: (_) => onTap(),
        avatar: icono == null ? null : Icon(icono, size: 16),
        label: Text(etiqueta),
        onDeleted: activo ? onQuitar : null,
        showCheckmark: false,
      ),
    );
  }
}
