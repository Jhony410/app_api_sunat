import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../../core/utils/numero_a_letras.dart';
import '../../../../core/utils/redondeo.dart';
import '../entidades/item_comprobante.dart';
import '../entidades/totales.dart';

/// Motor de cálculo fiscal del comprobante.
///
/// Es deliberadamente **puro**: no toca la base de datos, la red ni la UI, no
/// guarda estado y siempre devuelve el mismo resultado para las mismas
/// entradas. Toda la exactitud tributaria de la app depende de este archivo,
/// por eso está cubierto por pruebas unitarias en
/// `test/calculadora_totales_test.dart`.
///
/// Reglas aplicadas (Anexo VIII del Reglamento de Comprobantes de Pago):
///
/// * La base imponible de la línea es `cantidad × valorUnitario − descuento`,
///   redondeada a dos decimales.
/// * El IGV se calcula **por línea** sobre esa base ya redondeada. Sumar líneas
///   redondeadas es lo que hace que el total cuadre con la validación de SUNAT,
///   que admite una tolerancia de un céntimo.
/// * Las entregas a título gratuito no suman al importe total: declaran
///   `LineExtensionAmount = 0`, llevan su valor al precio de referencia y su
///   IGV se informa por separado.
class CalculadoraTotales {
  const CalculadoraTotales({this.tasaIgv = kTasaIgv});

  /// Se inyecta para poder probar con otras tasas y sobrevivir a un cambio
  /// normativo sin tocar la lógica.
  final double tasaIgv;

  /// Calcula una sola línea del comprobante.
  LineaCalculada calcularLinea(ItemComprobante item, {int? orden}) {
    final cantidad = item.cantidad < 0 ? 0.0 : item.cantidad;
    final valorUnitario = item.valorUnitario < 0 ? 0.0 : item.valorUnitario;
    final descuentoSolicitado = item.descuento < 0 ? 0.0 : item.descuento;

    final valorBruto = redondear(cantidad * valorUnitario, 2);
    // Un descuento nunca puede dejar la base imponible en negativo.
    final descuento = redondear(
      descuentoSolicitado > valorBruto ? valorBruto : descuentoSolicitado,
      2,
    );
    final baseNeta = redondear(valorBruto - descuento, 2);

    final afectacion = item.tipoAfectacionIgv;
    final esGratuita = afectacion.esGratuita;

    // El IGV sólo existe sobre operaciones gravadas, sean onerosas o gratuitas.
    final generaIgv = afectacion.generaIgv || afectacion.esGratuitaGravada;
    final igv = generaIgv ? redondear(baseNeta * tasaIgv, 2) : 0.0;

    final valorVenta = esGratuita ? 0.0 : baseNeta;
    final valorReferencial = esGratuita ? baseNeta : 0.0;

    // Precio unitario con IGV incluido: es el que el comprador ve en la etiqueta.
    final precioUnitario = esGratuita
        ? 0.0
        : redondear(
            generaIgv ? valorUnitario * (1 + tasaIgv) : valorUnitario,
            // SUNAT admite hasta 10 decimales en el precio unitario; con 6 basta
            // y se evita arrastrar ruido binario a la vista.
            6,
          );

    return LineaCalculada(
      orden: orden ?? item.orden,
      afectacion: afectacion,
      cantidad: cantidad,
      valorUnitario: valorUnitario,
      valorBruto: valorBruto,
      descuento: descuento,
      valorVenta: valorVenta,
      valorReferencial: valorReferencial,
      igv: igv,
      precioUnitario: precioUnitario,
      totalLinea: esGratuita ? 0.0 : redondear(valorVenta + igv, 2),
    );
  }

  /// Calcula los totales del comprobante a partir de sus ítems.
  ///
  /// [moneda] sólo se usa para redactar el importe en letras.
  Totales calcular(List<ItemComprobante> items, {Moneda moneda = Moneda.soles}) {
    final lineas = <LineaCalculada>[];
    for (var i = 0; i < items.length; i++) {
      lineas.add(calcularLinea(items[i], orden: i + 1));
    }

    var opGravadas = 0.0;
    var opExoneradas = 0.0;
    var opInafectas = 0.0;
    var opExportacion = 0.0;
    var opGratuitas = 0.0;
    var totalIgv = 0.0;
    var totalIgvGratuitas = 0.0;
    var totalDescuentos = 0.0;

    for (final linea in lineas) {
      totalDescuentos += linea.descuento;

      if (linea.afectacion.esGratuita) {
        opGratuitas += linea.valorReferencial;
        totalIgvGratuitas += linea.igv;
        continue;
      }

      totalIgv += linea.igv;

      switch (linea.afectacion.grupo) {
        case GrupoAfectacion.gravado:
          opGravadas += linea.valorVenta;
        case GrupoAfectacion.exonerado:
          opExoneradas += linea.valorVenta;
        case GrupoAfectacion.inafecto:
          opInafectas += linea.valorVenta;
        case GrupoAfectacion.exportacion:
          opExportacion += linea.valorVenta;
        case GrupoAfectacion.gratuito:
          // Ya se trató arriba; se deja explícito para que el switch sea exhaustivo.
          break;
      }
    }

    opGravadas = redondear(opGravadas, 2);
    opExoneradas = redondear(opExoneradas, 2);
    opInafectas = redondear(opInafectas, 2);
    opExportacion = redondear(opExportacion, 2);
    opGratuitas = redondear(opGratuitas, 2);
    totalIgv = redondear(totalIgv, 2);
    totalIgvGratuitas = redondear(totalIgvGratuitas, 2);
    totalDescuentos = redondear(totalDescuentos, 2);

    final totalValorVenta =
        redondear(opGravadas + opExoneradas + opInafectas + opExportacion, 2);
    final importeTotal = redondear(totalValorVenta + totalIgv, 2);

    return Totales(
      opGravadas: opGravadas,
      opExoneradas: opExoneradas,
      opInafectas: opInafectas,
      opExportacion: opExportacion,
      opGratuitas: opGratuitas,
      totalIgv: totalIgv,
      totalIgvGratuitas: totalIgvGratuitas,
      totalDescuentos: totalDescuentos,
      totalValorVenta: totalValorVenta,
      importeTotal: importeTotal,
      totalEnLetras: importeALetras(importeTotal, nombreMoneda: moneda.nombrePlural),
      lineas: lineas,
    );
  }

  /// Convierte un precio con IGV incluido al valor unitario sin IGV.
  ///
  /// Lo usa el formulario cuando el usuario prefiere teclear el precio de
  /// venta al público en lugar del valor neto.
  double valorUnitarioDesdePrecio(double precioConIgv, TipoAfectacionIgv afectacion) {
    if (!afectacion.generaIgv && !afectacion.esGratuitaGravada) return precioConIgv;
    return redondear(precioConIgv / (1 + tasaIgv), 6);
  }
}

/// Instancia por defecto con la tasa de IGV vigente.
const calculadoraTotales = CalculadoraTotales();
