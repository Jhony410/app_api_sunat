import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatos.dart';
import '../../../../core/widgets/esqueletos.dart';
import '../../../comprobantes/presentation/providers/comprobantes_providers.dart';

/// Barras con lo facturado cada día durante las últimas dos semanas.
///
/// Es intencionalmente sobrio: sin ejes cargados ni cuadrícula, para que se lea
/// de un vistazo desde el móvil.
class GraficoFacturacion extends ConsumerWidget {
  const GraficoFacturacion({this.dias = 14, super.key});

  final int dias;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datos = ref.watch(importeUltimosDiasProvider(dias: dias));
    final esquema = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Espaciado.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Últimos $dias días', style: textos.titleSmall),
            const SizedBox(height: Espaciado.md),
            SizedBox(
              height: 132,
              child: switch (datos) {
                AsyncData(:final value) => _Barras(porDia: value, dias: dias),
                AsyncError() => Center(
                    child: Text(
                      'No se pudo cargar el gráfico.',
                      style: textos.bodySmall,
                    ),
                  ),
                _ => const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: Esqueleto(alto: 40)),
                      SizedBox(width: Espaciado.xs),
                      Expanded(child: Esqueleto(alto: 84)),
                      SizedBox(width: Espaciado.xs),
                      Expanded(child: Esqueleto(alto: 60)),
                      SizedBox(width: Espaciado.xs),
                      Expanded(child: Esqueleto(alto: 100)),
                    ],
                  ),
              },
            ),
            const SizedBox(height: Espaciado.xs),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Importe emitido por día',
                style: textos.bodySmall?.copyWith(color: esquema.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Barras extends StatelessWidget {
  const _Barras({required this.porDia, required this.dias});

  final Map<DateTime, double> porDia;
  final int dias;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final hoy = DateTime.now();

    // Se completan los días sin ventas con cero para que el eje no tenga huecos.
    final serie = List.generate(dias, (indice) {
      final fecha = DateTime(hoy.year, hoy.month, hoy.day)
          .subtract(Duration(days: dias - 1 - indice));
      return (fecha: fecha, importe: porDia[fecha] ?? 0);
    });

    final maximo = serie.fold<double>(0, (max, d) => d.importe > max ? d.importe : max);

    if (maximo <= 0) {
      return Center(
        child: Text(
          'Sin movimientos en este periodo',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: esquema.onSurfaceVariant),
        ),
      );
    }

    return BarChart(
      BarChartData(
        maxY: maximo * 1.18,
        alignment: BarChartAlignment.spaceBetween,
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => esquema.inverseSurface,
            getTooltipItem: (grupo, _, barra, _) => BarTooltipItem(
              '${DateFormat('dd/MM').format(serie[grupo.x].fecha)}\n'
              '${formatearMoneda(barra.toY)}',
              TextStyle(
                color: esquema.onInverseSurface,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (valor, meta) {
                final indice = valor.toInt();
                if (indice < 0 || indice >= serie.length) {
                  return const SizedBox.shrink();
                }
                // Sólo se rotula uno de cada tres días y el último, para no
                // amontonar etiquetas en pantallas estrechas. El periódico que
                // caiga pegado al último se omite: si no, ambas fechas se
                // solapan en el borde derecho.
                final ultimo = serie.length - 1;
                final esUltimo = indice == ultimo;
                if (!esUltimo && (indice % 3 != 0 || ultimo - indice < 3)) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: Espaciado.xxs),
                  child: Text(
                    DateFormat('dd/MM').format(serie[indice].fecha),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: esquema.onSurfaceVariant,
                          fontSize: 10,
                        ),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < serie.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: serie[i].importe,
                  width: 9,
                  borderRadius: BorderRadius.circular(3),
                  color: serie[i].importe > 0
                      ? esquema.primary
                      : esquema.surfaceContainerHighest,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
