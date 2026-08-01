import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constantes/catalogos_sunat.dart';

part 'totales.freezed.dart';

/// Resultado del cálculo de una línea del comprobante.
///
/// Todos los importes ya vienen redondeados a dos decimales, salvo
/// [precioUnitario], que admite más precisión porque SUNAT lo permite.
@freezed
abstract class LineaCalculada with _$LineaCalculada {
  const factory LineaCalculada({
    required int orden,
    required TipoAfectacionIgv afectacion,
    required double cantidad,

    /// Valor unitario sin IGV tal como lo capturó el usuario.
    required double valorUnitario,

    /// `cantidad × valorUnitario`, antes de aplicar el descuento.
    required double valorBruto,
    required double descuento,

    /// Base imponible de la línea (`cbc:LineExtensionAmount`).
    /// Vale 0 en las entregas gratuitas.
    required double valorVenta,

    /// Valor referencial de las entregas gratuitas. Vale 0 en el resto.
    required double valorReferencial,

    /// IGV de la línea. En las gratuitas se informa pero no se cobra.
    required double igv,

    /// Precio unitario con IGV incluido (`cac:AlternativeConditionPrice`).
    required double precioUnitario,

    /// Importe que ve el usuario en la fila: base + IGV. Vale 0 si es gratuita.
    required double totalLinea,
  }) = _LineaCalculada;

  const LineaCalculada._();

  /// Valor unitario que se declara en `cac:Price/cbc:PriceAmount`.
  ///
  /// En las entregas gratuitas SUNAT exige declararlo en cero y llevar el valor
  /// real al precio de referencia con código `02`.
  double get valorUnitarioDeclarado => afectacion.esGratuita ? 0 : valorUnitario;

  /// Código del precio de referencia (catálogo N.° 16): `01` precio unitario
  /// de venta, `02` valor referencial de una operación gratuita.
  String get codigoTipoPrecio => afectacion.esGratuita ? '02' : '01';

  /// Base sobre la que se calculó el IGV de la línea.
  double get baseImponible => afectacion.esGratuita ? valorReferencial : valorVenta;
}

/// Totales del comprobante. Se recalculan siempre; nunca se editan a mano.
@freezed
abstract class Totales with _$Totales {
  const factory Totales({
    @Default(0.0) double opGravadas,
    @Default(0.0) double opExoneradas,
    @Default(0.0) double opInafectas,
    @Default(0.0) double opExportacion,
    @Default(0.0) double opGratuitas,
    @Default(0.0) double totalIgv,

    /// IGV informativo de las entregas gratuitas (no forma parte del total).
    @Default(0.0) double totalIgvGratuitas,
    @Default(0.0) double totalDescuentos,

    /// Suma de las bases imponibles onerosas (`cbc:LineExtensionAmount`).
    @Default(0.0) double totalValorVenta,

    /// Importe a pagar (`cbc:PayableAmount`).
    @Default(0.0) double importeTotal,
    @Default('') String totalEnLetras,
    @Default(<LineaCalculada>[]) List<LineaCalculada> lineas,
  }) = _Totales;

  const Totales._();

  /// `true` cuando el comprobante sólo contiene entregas gratuitas.
  bool get esTotalmenteGratuito => importeTotal == 0 && opGratuitas > 0;

  /// Casillas con importe distinto de cero, para no imprimir filas vacías en el RIDE.
  Map<String, double> get casillasConImporte => {
        if (opGravadas > 0) 'Op. gravadas': opGravadas,
        if (opExoneradas > 0) 'Op. exoneradas': opExoneradas,
        if (opInafectas > 0) 'Op. inafectas': opInafectas,
        if (opExportacion > 0) 'Op. exportación': opExportacion,
        if (opGratuitas > 0) 'Op. gratuitas': opGratuitas,
        if (totalDescuentos > 0) 'Descuentos': totalDescuentos,
        'IGV (18%)': totalIgv,
      };
}
