import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../../../core/utils/formatos.dart';
import '../entidades/comprobante.dart';

/// Valor resumen (`DigestValue`) que acompaña al comprobante.
///
/// En emisión real este valor lo produce la firma digital del XML y llega
/// desde Lycet. En modo Simulación no hay certificado, así que se calcula
/// localmente un SHA-1 en Base64 sobre los datos del comprobante: tiene el
/// mismo formato que el real y hace que el QR sea verificable contra el propio
/// documento, pero **no** es una firma válida ante SUNAT.
String generarHashSimulado(Comprobante comprobante, {required String rucEmisor}) {
  final t = comprobante.totales;

  final cadena = [
    rucEmisor,
    comprobante.tipo.codigo,
    comprobante.serie,
    comprobante.correlativo,
    formatearFechaSunat(comprobante.fechaEmision),
    comprobante.cliente.tipoDocumento.codigo,
    comprobante.cliente.numeroDocumento,
    importeParaSunat(t.totalValorVenta),
    importeParaSunat(t.totalIgv),
    importeParaSunat(t.importeTotal),
    for (final linea in t.lineas)
      '${linea.orden}:${importeParaSunat(linea.valorVenta)}:${importeParaSunat(linea.igv)}',
  ].join('|');

  return base64.encode(sha1.convert(utf8.encode(cadena)).bytes);
}
