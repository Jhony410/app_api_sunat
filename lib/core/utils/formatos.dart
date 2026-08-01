import 'package:intl/intl.dart';

import '../constantes/catalogos_sunat.dart';

/// Formateo de moneda, fechas y números con la convención peruana (es_PE).
///
/// `initializeDateFormatting('es_PE')` se invoca una sola vez en `main()`.

const String kLocalePeru = 'es_PE';

/// Locale del que se toman los **símbolos numéricos**, que no es el de la app.
///
/// `intl` no trae datos numéricos de `es_PE` y degrada silenciosamente a los de
/// España: coma decimal, punto de millares y símbolo detrás del importe
/// (`1.234,50 S/`). Perú escribe `S/ 1,234.50` —punto decimal, coma de
/// millares y símbolo delante—, que es justo la convención de `en_US`. Se usan
/// sus separadores y el símbolo se antepone a mano.
///
/// Las fechas sí pueden pedirse en [kLocalePeru]: sus patrones son explícitos y
/// los nombres de mes salen del castellano genérico, que es el correcto.
const String _localeNumerico = 'en_US';

/// `S/ 1,234.50` — el símbolo depende de la moneda del comprobante.
String formatearMoneda(double valor, {Moneda moneda = Moneda.soles}) =>
    '${moneda.simbolo} ${formatearImporte(valor)}';

/// `1,234.50` sin símbolo, para las columnas numéricas de las tablas.
String formatearImporte(double valor, {int decimales = 2}) =>
    NumberFormat.decimalPatternDigits(
      locale: _localeNumerico,
      decimalDigits: decimales,
    ).format(valor);

/// Cantidad sin ceros decimales sobrantes: `3`, `1.5`, `0.25`.
String formatearCantidad(double valor) {
  if (valor == valor.roundToDouble()) {
    return NumberFormat.decimalPattern(_localeNumerico).format(valor.round());
  }
  return NumberFormat.decimalPatternDigits(
    locale: _localeNumerico,
    decimalDigits: 3,
  )
      .format(valor)
      .replaceFirst(RegExp(r'0+$'), '')
      .replaceFirst(RegExp(r'\.$'), '');
}

/// `31/07/2026`
String formatearFecha(DateTime fecha) =>
    DateFormat('dd/MM/yyyy', kLocalePeru).format(fecha);

/// `31 de julio de 2026`
String formatearFechaLarga(DateTime fecha) =>
    DateFormat("d 'de' MMMM 'de' y", kLocalePeru).format(fecha);

/// `31/07/2026 14:05`
String formatearFechaHora(DateTime fecha) =>
    DateFormat('dd/MM/yyyy HH:mm', kLocalePeru).format(fecha);

/// `2026-07-31` — formato ISO exigido por SUNAT en `cbc:IssueDate`.
String formatearFechaSunat(DateTime fecha) =>
    DateFormat('yyyy-MM-dd').format(fecha);

/// `14:05:00` — formato exigido por SUNAT en `cbc:IssueTime`.
String formatearHoraSunat(DateTime fecha) => DateFormat('HH:mm:ss').format(fecha);

/// `F001-00000123` — identificador completo del comprobante.
String formatearNumeroComprobante(String serie, int correlativo) =>
    '$serie-${correlativo.toString().padLeft(8, '0')}';

/// Importe con punto decimal y sin separador de miles, tal como viaja al XML
/// y a la API de Lycet. Nunca debe usar la configuración regional.
String importeParaSunat(double valor, {int decimales = 2}) =>
    valor.toStringAsFixed(decimales);
