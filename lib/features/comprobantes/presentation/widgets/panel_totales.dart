import 'package:flutter/material.dart';

import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatos.dart';
import '../../../../core/widgets/seccion.dart';
import '../../domain/entidades/totales.dart';

/// Desglose de totales del comprobante.
///
/// No suma ni redondea nada: recibe ya calculado lo que produce
/// `CalculadoraTotales`, que es la única fuente de verdad del cálculo fiscal.
/// Por eso sirve igual para el borrador que para un comprobante ya emitido.
class PanelTotales extends StatelessWidget {
  const PanelTotales({
    required this.totales,
    required this.moneda,
    this.mostrarLetras = true,
    super.key,
  });

  final Totales totales;
  final Moneda moneda;

  /// El importe en letras sólo se muestra en el detalle; en el formulario
  /// ocuparía sitio sin aportar nada mientras se capturan los ítems.
  final bool mostrarLetras;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final casilla in totales.casillasConImporte.entries)
          FilaDato(
            etiqueta: casilla.key,
            valor: formatearMoneda(casilla.value, moneda: moneda),
          ),
        // El IGV de las entregas gratuitas se informa a SUNAT pero no se cobra,
        // así que va aparte y atenuado para que nadie lo sume mentalmente.
        if (totales.totalIgvGratuitas > 0)
          FilaDato(
            etiqueta: 'IGV de gratuitas (informativo)',
            valor: formatearMoneda(totales.totalIgvGratuitas, moneda: moneda),
            colorValor: esquema.onSurfaceVariant,
          ),
        const Divider(height: Espaciado.lg),
        FilaDato(
          etiqueta: 'Importe total',
          valor: formatearMoneda(totales.importeTotal, moneda: moneda),
          destacado: true,
          colorValor: esquema.primary,
        ),
        if (mostrarLetras && totales.totalEnLetras.isNotEmpty) ...[
          const SizedBox(height: Espaciado.xs),
          Text(
            totales.totalEnLetras,
            style: textos.bodySmall?.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ],
    );
  }
}
