import 'package:app_api_sunat/core/constantes/catalogos_sunat.dart';
import 'package:app_api_sunat/features/comprobantes/domain/entidades/item_comprobante.dart';
import 'package:app_api_sunat/features/comprobantes/domain/servicios/calculadora_totales.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pruebas del motor de cálculo fiscal.
///
/// Es la única fuente de verdad de todo importe que la app muestra, imprime o
/// envía, así que cada regla del Anexo VIII que implementa tiene aquí su caso.
void main() {
  ItemComprobante item({
    required double cantidad,
    required double valorUnitario,
    TipoAfectacionIgv afectacion = TipoAfectacionIgv.gravado,
    double descuento = 0,
    int orden = 1,
  }) =>
      ItemComprobante(
        descripcion: 'Ítem de prueba',
        cantidad: cantidad,
        valorUnitario: valorUnitario,
        tipoAfectacionIgv: afectacion,
        descuento: descuento,
        orden: orden,
      );

  group('IGV', () {
    test('grava la base de la línea al 18 %', () {
      final totales = calculadoraTotales.calcular([
        item(cantidad: 3, valorUnitario: 10),
      ]);

      expect(totales.opGravadas, 30.00);
      expect(totales.totalIgv, 5.40);
      expect(totales.importeTotal, 35.40);
    });

    test('se calcula por línea sobre la base ya redondeada, no sobre la suma', () {
      // Tres líneas de 0.85: cada una redondea su IGV a 0.15 (0.153 real), de
      // modo que el total es 0.45. Sumar primero daría 2.55 × 0.18 = 0.46, y
      // el comprobante no cuadraría con la validación de SUNAT.
      final totales = calculadoraTotales.calcular([
        for (var i = 1; i <= 3; i++)
          item(cantidad: 1, valorUnitario: 0.85, orden: i),
      ]);

      expect(totales.totalValorVenta, 2.55);
      expect(totales.totalIgv, 0.45);
      expect(totales.importeTotal, 3.00);
    });

    test('no se aplica a operaciones exoneradas ni inafectas', () {
      final totales = calculadoraTotales.calcular([
        item(
          cantidad: 1,
          valorUnitario: 100,
          afectacion: TipoAfectacionIgv.exonerado,
        ),
        item(
          cantidad: 1,
          valorUnitario: 50,
          afectacion: TipoAfectacionIgv.inafecto,
          orden: 2,
        ),
      ]);

      expect(totales.opExoneradas, 100.00);
      expect(totales.opInafectas, 50.00);
      expect(totales.totalIgv, 0);
      expect(totales.importeTotal, 150.00);
    });

    test('la exportación va a su propia casilla y sin IGV', () {
      final totales = calculadoraTotales.calcular([
        item(
          cantidad: 2,
          valorUnitario: 120,
          afectacion: TipoAfectacionIgv.exportacion,
        ),
      ]);

      expect(totales.opExportacion, 240.00);
      expect(totales.totalIgv, 0);
      expect(totales.importeTotal, 240.00);
    });
  });

  group('entregas gratuitas', () {
    test('informan su IGV pero no suman al importe total', () {
      final totales = calculadoraTotales.calcular([
        item(
          cantidad: 2,
          valorUnitario: 5,
          afectacion: TipoAfectacionIgv.gravadoBonificacion,
        ),
      ]);

      expect(totales.opGratuitas, 10.00);
      expect(totales.totalIgvGratuitas, 1.80);
      expect(totales.totalIgv, 0);
      expect(totales.importeTotal, 0);
      expect(totales.esTotalmenteGratuito, isTrue);
    });

    test('declaran valor unitario cero y precio de referencia con código 02', () {
      final linea = calculadoraTotales.calcularLinea(
        item(
          cantidad: 1,
          valorUnitario: 40,
          afectacion: TipoAfectacionIgv.gravadoBonificacion,
        ),
      );

      expect(linea.valorVenta, 0);
      expect(linea.valorReferencial, 40.00);
      expect(linea.valorUnitarioDeclarado, 0);
      expect(linea.codigoTipoPrecio, '02');
      expect(linea.totalLinea, 0);
    });
  });

  group('descuentos', () {
    test('reducen la base imponible antes de calcular el IGV', () {
      final totales = calculadoraTotales.calcular([
        item(cantidad: 1, valorUnitario: 100, descuento: 20),
      ]);

      expect(totales.totalDescuentos, 20.00);
      expect(totales.opGravadas, 80.00);
      expect(totales.totalIgv, 14.40);
      expect(totales.importeTotal, 94.40);
    });

    test('nunca dejan la base en negativo', () {
      final linea = calculadoraTotales.calcularLinea(
        item(cantidad: 1, valorUnitario: 10, descuento: 15),
      );

      expect(linea.descuento, 10.00);
      expect(linea.valorVenta, 0);
      expect(linea.igv, 0);
    });
  });

  group('entradas inválidas', () {
    test('las cantidades y los valores negativos se tratan como cero', () {
      final linea = calculadoraTotales.calcularLinea(
        item(cantidad: -2, valorUnitario: -5),
      );

      expect(linea.cantidad, 0);
      expect(linea.valorUnitario, 0);
      expect(linea.totalLinea, 0);
    });

    test('un comprobante sin ítems da todos los importes en cero', () {
      final totales = calculadoraTotales.calcular(const []);

      expect(totales.importeTotal, 0);
      expect(totales.lineas, isEmpty);
    });
  });

  group('conversión desde el precio al público', () {
    test('descuenta el IGV cuando la operación está gravada', () {
      expect(
        calculadoraTotales.valorUnitarioDesdePrecio(
          118,
          TipoAfectacionIgv.gravado,
        ),
        100.00,
      );
    });

    test('deja el precio intacto cuando no hay IGV que descontar', () {
      expect(
        calculadoraTotales.valorUnitarioDesdePrecio(
          118,
          TipoAfectacionIgv.exonerado,
        ),
        118.00,
      );
    });
  });

  test('el importe en letras acompaña siempre a los totales', () {
    final totales = calculadoraTotales.calcular(
      [item(cantidad: 1, valorUnitario: 100)],
      moneda: Moneda.soles,
    );

    expect(totales.importeTotal, 118.00);
    expect(totales.totalEnLetras, 'CIENTO DIECIOCHO CON 00/100 SOLES');
  });

  test('la tasa de IGV es inyectable para sobrevivir a un cambio normativo', () {
    const calculadora = CalculadoraTotales(tasaIgv: 0.10);
    final totales = calculadora.calcular([item(cantidad: 1, valorUnitario: 200)]);

    expect(totales.totalIgv, 20.00);
    expect(totales.importeTotal, 220.00);
  });
}
