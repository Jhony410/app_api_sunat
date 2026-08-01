import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/tablas.dart';
import '../../../../core/router/rutas.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatos.dart';
import '../../../../core/widgets/estado_vacio.dart';
import '../../../../core/widgets/esqueletos.dart';
import '../../../comprobantes/presentation/providers/comprobantes_providers.dart';
import '../../../comprobantes/presentation/widgets/fila_comprobante.dart';
import '../../../configuracion/presentation/providers/ajustes_providers.dart';
import '../../../empresa/presentation/providers/empresa_providers.dart';
import '../widgets/grafico_facturacion.dart';
import '../widgets/tarjeta_metrica.dart';

/// Dashboard: resumen del día y del mes, tendencia de los últimos días,
/// accesos directos y los comprobantes más recientes.
class PantallaInicio extends ConsumerWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final empresa = ref.watch(empresaProvider).value;
    final resumenDia = ref.watch(resumenDelDiaProvider);
    final resumenMes = ref.watch(resumenDelMesProvider);
    final historial = ref.watch(historialComprobantesProvider);
    final ajustes = ref.watch(ajustesProvider).value;

    final textos = Theme.of(context).textTheme;
    final esquema = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(resumenDelDiaProvider);
            ref.invalidate(resumenDelMesProvider);
            ref.invalidate(historialComprobantesProvider);
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  Espaciado.md,
                  Espaciado.md,
                  Espaciado.md,
                  0,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_saludo(), style: textos.bodyMedium),
                      Text(
                        empresa?.nombreParaMostrar ?? 'Tu empresa',
                        style: textos.headlineSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: Espaciado.md),
                      if (ajustes != null)
                        _AvisoModoOperacion(modo: ajustes.modoOperacion),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: Espaciado.md),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: TarjetaMetrica(
                          etiqueta: 'Hoy',
                          icono: Icons.today_rounded,
                          valor: resumenDia.value == null
                              ? null
                              : formatearMoneda(resumenDia.value!.totalFacturado),
                          detalle: resumenDia.value == null
                              ? null
                              : '${resumenDia.value!.cantidadComprobantes} comprobante'
                                  '${resumenDia.value!.cantidadComprobantes == 1 ? '' : 's'}',
                        ),
                      ),
                      const SizedBox(width: Espaciado.sm),
                      Expanded(
                        child: TarjetaMetrica(
                          etiqueta: 'Este mes',
                          icono: Icons.calendar_month_rounded,
                          acentuada: true,
                          valor: resumenMes.value == null
                              ? null
                              : formatearMoneda(resumenMes.value!.totalFacturado),
                          detalle: resumenMes.value == null
                              ? null
                              : '${resumenMes.value!.cantidadComprobantes} comprobante'
                                  '${resumenMes.value!.cantidadComprobantes == 1 ? '' : 's'}',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  Espaciado.md,
                  Espaciado.sm,
                  Espaciado.md,
                  0,
                ),
                sliver: SliverToBoxAdapter(child: GraficoFacturacion()),
              ),

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  Espaciado.md,
                  Espaciado.md,
                  Espaciado.md,
                  0,
                ),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: _AccesoDirecto(
                          icono: Icons.add_circle_outline_rounded,
                          etiqueta: 'Nuevo comprobante',
                          principal: true,
                          onTap: () => context.push(Rutas.nuevoComprobante),
                        ),
                      ),
                      const SizedBox(width: Espaciado.sm),
                      Expanded(
                        child: _AccesoDirecto(
                          icono: Icons.people_outline_rounded,
                          etiqueta: 'Clientes',
                          onTap: () => context.go(Rutas.clientes),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  Espaciado.md,
                  Espaciado.lg,
                  Espaciado.md,
                  Espaciado.xs,
                ),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Últimos comprobantes', style: textos.titleSmall),
                      TextButton(
                        onPressed: () => context.go(Rutas.historial),
                        child: const Text('Ver todo'),
                      ),
                    ],
                  ),
                ),
              ),

              switch (historial) {
                AsyncData(:final value) when value.isEmpty => SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Espaciado.lg),
                      child: EstadoVacio(
                        compacto: true,
                        icono: Icons.receipt_long_outlined,
                        titulo: 'Todavía no emites comprobantes',
                        mensaje:
                            'Cuando crees tu primera factura o boleta aparecerá aquí.',
                        etiquetaAccion: 'Crear el primero',
                        onAccion: () => context.push(Rutas.nuevoComprobante),
                      ),
                    ),
                  ),
                AsyncData(:final value) => SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: Espaciado.md),
                    sliver: SliverList.separated(
                      itemCount: value.length > 5 ? 5 : value.length,
                      separatorBuilder: (_, _) => const SizedBox(height: Espaciado.xs),
                      itemBuilder: (context, indice) =>
                          FilaComprobante(value[indice]),
                    ),
                  ),
                AsyncError(:final error) => SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(Espaciado.md),
                      child: Text(
                        'No se pudo cargar el historial: $error',
                        style: textos.bodyMedium?.copyWith(color: esquema.error),
                      ),
                    ),
                  ),
                _ => const SliverToBoxAdapter(
                    child: SizedBox(height: 220, child: EsqueletoLista(filas: 3)),
                  ),
              },

              const SliverToBoxAdapter(child: SizedBox(height: Espaciado.xxl)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Rutas.nuevoComprobante),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Emitir'),
      ),
    );
  }

  static String _saludo() {
    final hora = DateTime.now().hour;
    if (hora < 12) return 'Buenos días';
    if (hora < 19) return 'Buenas tardes';
    return 'Buenas noches';
  }
}

/// Recordatorio permanente de en qué modo está emitiendo la app.
class _AvisoModoOperacion extends StatelessWidget {
  const _AvisoModoOperacion({required this.modo});

  final ModoOperacion modo;

  @override
  Widget build(BuildContext context) {
    final esSimulacion = modo == ModoOperacion.simulacion;
    final color = esSimulacion
        ? ColoresEstado.advertencia(context)
        : ColoresEstado.exito(context);

    return Container(
      margin: const EdgeInsets.only(bottom: Espaciado.sm),
      padding: const EdgeInsets.symmetric(
        horizontal: Espaciado.sm,
        vertical: Espaciado.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(Radios.chico),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(
            esSimulacion ? Icons.science_outlined : Icons.cloud_done_outlined,
            size: 18,
            color: color,
          ),
          const SizedBox(width: Espaciado.xs),
          Expanded(
            child: Text(
              esSimulacion
                  ? 'Modo Simulación: los comprobantes no se envían a SUNAT.'
                  : 'Emisión real activa contra el ambiente BETA de SUNAT.',
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

class _AccesoDirecto extends StatelessWidget {
  const _AccesoDirecto({
    required this.icono,
    required this.etiqueta,
    required this.onTap,
    this.principal = false,
  });

  final IconData icono;
  final String etiqueta;
  final VoidCallback onTap;
  final bool principal;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final fondo = principal ? esquema.primaryContainer : esquema.surfaceContainerLowest;
    final tinte = principal ? esquema.onPrimaryContainer : esquema.onSurface;

    return Material(
      color: fondo,
      borderRadius: BorderRadius.circular(Radios.medio),
      child: InkWell(
        borderRadius: BorderRadius.circular(Radios.medio),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(Espaciado.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radios.medio),
            border: principal
                ? null
                : Border.all(color: esquema.outlineVariant.withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icono, color: tinte),
              const SizedBox(height: Espaciado.sm),
              Text(
                etiqueta,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: tinte),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
