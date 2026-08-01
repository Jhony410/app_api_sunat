import 'dart:math' as math;

/// Redondeo monetario "mitad hacia arriba" (half-up), que es el que aplica
/// SUNAT para los importes de los comprobantes.
///
/// El redondeo de Dart (`num.round()`) usa "mitad lejos del cero", lo que
/// coincide para positivos, pero opera sobre el `double` crudo: `1.005` no es
/// exactamente 1.005 en binario, así que `(1.005 * 100).round()` devuelve 100
/// en lugar de 101. Para evitarlo se corrige el valor escalado con un épsilon
/// relativo antes de redondear.
double redondear(double valor, [int decimales = 2]) {
  if (valor.isNaN || valor.isInfinite) return 0;
  final factor = math.pow(10, decimales).toDouble();
  final escalado = valor * factor;
  // Acerca el escalado al entero más próximo cuando la diferencia proviene de
  // error de representación binaria y no de un decimal real.
  final corregido = escalado.abs() < 1e-9
      ? escalado
      : escalado + escalado.sign * escalado.abs() * 1e-12;
  return corregido.roundToDouble() / factor;
}

/// Compara dos importes con la tolerancia de un céntimo que acepta SUNAT.
bool importesEquivalentes(double a, double b, {double tolerancia = 0.01}) =>
    (a - b).abs() <= tolerancia + 1e-9;
