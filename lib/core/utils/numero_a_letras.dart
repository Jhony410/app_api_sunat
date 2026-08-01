/// Conversión de importes a su representación en letras, tal como debe figurar
/// en `cbc:Note languageLocaleID="1000"` del XML y en el RIDE.
///
/// Ejemplo: `965.00` → `NOVECIENTOS SESENTA Y CINCO CON 00/100 SOLES`.
library;

import 'redondeo.dart';

const List<String> _unidades = [
  '',
  'UNO',
  'DOS',
  'TRES',
  'CUATRO',
  'CINCO',
  'SEIS',
  'SIETE',
  'OCHO',
  'NUEVE',
  'DIEZ',
  'ONCE',
  'DOCE',
  'TRECE',
  'CATORCE',
  'QUINCE',
  'DIECISÉIS',
  'DIECISIETE',
  'DIECIOCHO',
  'DIECINUEVE',
  'VEINTE',
  'VEINTIUNO',
  'VEINTIDÓS',
  'VEINTITRÉS',
  'VEINTICUATRO',
  'VEINTICINCO',
  'VEINTISÉIS',
  'VEINTISIETE',
  'VEINTIOCHO',
  'VEINTINUEVE',
];

const List<String> _decenas = [
  '',
  '',
  'VEINTE',
  'TREINTA',
  'CUARENTA',
  'CINCUENTA',
  'SESENTA',
  'SETENTA',
  'OCHENTA',
  'NOVENTA',
];

const List<String> _centenas = [
  '',
  'CIENTO',
  'DOSCIENTOS',
  'TRESCIENTOS',
  'CUATROCIENTOS',
  'QUINIENTOS',
  'SEISCIENTOS',
  'SETECIENTOS',
  'OCHOCIENTOS',
  'NOVECIENTOS',
];

/// Convierte un grupo de 0 a 999 a letras.
///
/// [apocope] aplica la forma corta que exige el español cuando el grupo va
/// seguido de "MIL" o "MILLONES": *veintiún mil*, *un millón*.
String _grupoALetras(int n, {bool apocope = false}) {
  if (n == 0) return '';
  if (n == 100) return 'CIEN';

  final centena = n ~/ 100;
  final resto = n % 100;

  final partes = <String>[];
  if (centena > 0) partes.add(_centenas[centena]);

  if (resto > 0) {
    if (resto < 30) {
      var palabra = _unidades[resto];
      if (apocope && resto == 1) palabra = 'UN';
      if (apocope && resto == 21) palabra = 'VEINTIÚN';
      partes.add(palabra);
    } else {
      final decena = resto ~/ 10;
      final unidad = resto % 10;
      if (unidad == 0) {
        partes.add(_decenas[decena]);
      } else {
        final palabraUnidad = apocope && unidad == 1 ? 'UN' : _unidades[unidad];
        partes.add('${_decenas[decena]} Y $palabraUnidad');
      }
    }
  }

  return partes.join(' ');
}

/// Convierte un entero no negativo a letras mayúsculas en español.
String enteroALetras(int numero) {
  if (numero == 0) return 'CERO';
  if (numero < 0) return 'MENOS ${enteroALetras(-numero)}';

  final millones = numero ~/ 1000000;
  final miles = (numero % 1000000) ~/ 1000;
  final resto = numero % 1000;

  final partes = <String>[];

  if (millones > 0) {
    final texto = _grupoALetras(millones, apocope: true);
    partes.add(millones == 1 ? 'UN MILLÓN' : '$texto MILLONES');
  }

  if (miles > 0) {
    // "MIL" nunca se dice "UN MIL".
    partes.add(miles == 1 ? 'MIL' : '${_grupoALetras(miles, apocope: true)} MIL');
  }

  if (resto > 0) partes.add(_grupoALetras(resto));

  return partes.join(' ');
}

/// Devuelve el importe en letras con el formato que exige SUNAT.
///
/// Los céntimos se expresan como fracción de 100 y el nombre de la moneda va
/// en plural: `MIL DOSCIENTOS CON 50/100 SOLES`.
String importeALetras(double importe, {required String nombreMoneda}) {
  final redondeado = redondear(importe.abs(), 2);
  final entera = redondeado.truncate();
  // Se recalcula sobre el valor ya redondeado para no arrastrar el error binario.
  final centimos = redondear((redondeado - entera) * 100, 0).round();

  // Si el redondeo de los céntimos llega a 100, el acarreo va a la parte entera.
  final parteEntera = centimos == 100 ? entera + 1 : entera;
  final parteDecimal = centimos == 100 ? 0 : centimos;

  final letras = enteroALetras(parteEntera);
  final signo = importe < 0 ? 'MENOS ' : '';
  return '$signo$letras CON ${parteDecimal.toString().padLeft(2, '0')}/100 $nombreMoneda';
}
