import '../constantes/catalogos_sunat.dart';

/// Validaciones de los números de documento de identidad peruanos.
///
/// Se usan tanto en los formularios como antes de consultar las APIs de
/// RUC/DNI, para no gastar una llamada de red con un número imposible.

/// Verifica el dígito de control (módulo 11) de un RUC de 11 dígitos.
bool rucEsValido(String ruc) {
  final limpio = ruc.trim();
  if (!RegExp(r'^\d{11}$').hasMatch(limpio)) return false;

  // Los dos primeros dígitos indican el tipo de contribuyente.
  const prefijosValidos = {'10', '15', '16', '17', '20'};
  if (!prefijosValidos.contains(limpio.substring(0, 2))) return false;

  const factores = [5, 4, 3, 2, 7, 6, 5, 4, 3, 2];
  var suma = 0;
  for (var i = 0; i < 10; i++) {
    suma += int.parse(limpio[i]) * factores[i];
  }

  final resto = suma % 11;
  var digito = 11 - resto;
  if (digito == 10) digito = 0;
  if (digito == 11) digito = 1;

  return digito == int.parse(limpio[10]);
}

/// Un DNI válido son exactamente 8 dígitos.
///
/// RENIEC no publica el algoritmo del dígito verificador, así que sólo se
/// valida el formato.
bool dniEsValido(String dni) => RegExp(r'^\d{8}$').hasMatch(dni.trim());

/// Valida el número según el tipo de documento seleccionado.
bool documentoEsValido(TipoDocumentoIdentidad tipo, String numero) {
  final limpio = numero.trim();
  return switch (tipo) {
    TipoDocumentoIdentidad.ruc => rucEsValido(limpio),
    TipoDocumentoIdentidad.dni => dniEsValido(limpio),
    TipoDocumentoIdentidad.sinDocumento => limpio.isEmpty || limpio == '0',
    // Carnet de extranjería y pasaporte son alfanuméricos y sin dígito de control.
    _ => limpio.isNotEmpty && limpio.length <= tipo.longitudMaxima,
  };
}

/// Mensaje de error listo para mostrar en un formulario, o `null` si es válido.
String? mensajeErrorDocumento(TipoDocumentoIdentidad tipo, String? numero) {
  final limpio = (numero ?? '').trim();

  if (limpio.isEmpty) {
    return tipo == TipoDocumentoIdentidad.sinDocumento
        ? null
        : 'Ingresa el número de ${tipo.etiqueta}';
  }

  if (documentoEsValido(tipo, limpio)) return null;

  return switch (tipo) {
    TipoDocumentoIdentidad.ruc => 'El RUC debe tener 11 dígitos y un dígito verificador válido',
    TipoDocumentoIdentidad.dni => 'El DNI debe tener 8 dígitos',
    _ => 'Número de ${tipo.etiqueta} inválido',
  };
}

/// Valida el formato de una serie: una letra seguida de tres dígitos (F001, B001).
bool serieEsValida(String serie, TipoComprobante tipo) {
  final limpia = serie.trim().toUpperCase();
  if (!RegExp(r'^[A-Z]\d{3}$').hasMatch(limpia)) return false;
  return limpia.startsWith(tipo.prefijoSerie);
}
