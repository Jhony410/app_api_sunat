import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constantes/catalogos_sunat.dart';

part 'item_comprobante.freezed.dart';

/// Una línea del comprobante (`cac:InvoiceLine`).
///
/// Guarda únicamente los datos que el usuario captura. Todo lo derivado
/// (valor de venta, IGV, precio unitario) lo produce
/// `CalculadoraTotales.calcularLinea`, para que exista una sola fuente de
/// verdad del cálculo fiscal.
@freezed
abstract class ItemComprobante with _$ItemComprobante {
  const factory ItemComprobante({
    int? id,
    int? comprobanteId,

    /// Código interno del producto o servicio (`cac:SellersItemIdentification`).
    @Default('') String codigo,
    required String descripcion,
    @Default(UnidadMedida.unidad) UnidadMedida unidadMedida,
    @Default(1.0) double cantidad,

    /// Valor unitario **sin IGV**. Es el dato canónico que se persiste.
    @Default(0.0) double valorUnitario,
    @Default(TipoAfectacionIgv.gravado) TipoAfectacionIgv tipoAfectacionIgv,

    /// Descuento en importe (no porcentaje) aplicado a la línea completa.
    @Default(0.0) double descuento,

    /// Orden de la línea dentro del comprobante (`cbc:ID`, empieza en 1).
    @Default(0) int orden,
  }) = _ItemComprobante;

  const ItemComprobante._();

  /// La línea es válida si tiene descripción, cantidad positiva y un valor
  /// unitario que no sea negativo.
  bool get esValida =>
      descripcion.trim().isNotEmpty && cantidad > 0 && valorUnitario >= 0 && descuento >= 0;
}
