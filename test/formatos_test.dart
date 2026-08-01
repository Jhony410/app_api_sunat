import 'package:app_api_sunat/core/constantes/catalogos_sunat.dart';
import 'package:app_api_sunat/core/utils/formatos.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Formato de importes y fechas.
///
/// Existe por una regresión concreta: `intl` no tiene datos numéricos de
/// `es_PE` y degradaba a los de España, de modo que la app y el RIDE imprimían
/// `1.234,50 S/` donde Perú escribe `S/ 1,234.50`.
void main() {
  setUpAll(() => initializeDateFormatting(kLocalePeru));

  group('importes', () {
    test('usan punto decimal y coma de millares', () {
      expect(formatearImporte(1234.5), '1,234.50');
      expect(formatearImporte(1000000), '1,000,000.00');
      expect(formatearImporte(0.5), '0.50');
    });

    test('el símbolo de la moneda va delante', () {
      expect(formatearMoneda(1234.5), 'S/ 1,234.50');
      expect(formatearMoneda(1234.5, moneda: Moneda.dolares), r'US$ 1,234.50');
      expect(formatearMoneda(0), 'S/ 0.00');
    });

    test('las cantidades no arrastran ceros decimales', () {
      expect(formatearCantidad(3), '3');
      expect(formatearCantidad(1.5), '1.5');
      expect(formatearCantidad(0.25), '0.25');
      expect(formatearCantidad(1234), '1,234');
    });
  });

  group('lo que viaja a SUNAT', () {
    test('no depende de la configuración regional', () {
      // Punto decimal y sin separador de millares, siempre.
      expect(importeParaSunat(1234.5), '1234.50');
      expect(importeParaSunat(0), '0.00');
    });

    test('la fecha va en ISO y el número de comprobante con ocho dígitos', () {
      expect(formatearFechaSunat(DateTime(2026, 8, 1)), '2026-08-01');
      expect(formatearNumeroComprobante('F001', 123), 'F001-00000123');
    });
  });

  group('fechas en pantalla', () {
    test('se escriben como se leen en Perú', () {
      expect(formatearFecha(DateTime(2026, 8, 1)), '01/08/2026');
      expect(formatearFechaLarga(DateTime(2026, 8, 1)), '1 de agosto de 2026');
    });
  });
}
