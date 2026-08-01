import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constantes/catalogos_sunat.dart';

part 'cliente.freezed.dart';

/// Receptor del comprobante. Se guarda en la agenda para reutilizarlo, pero un
/// comprobante puede emitirse a un cliente que no esté guardado.
@freezed
abstract class Cliente with _$Cliente {
  const factory Cliente({
    int? id,
    @Default(TipoDocumentoIdentidad.dni) TipoDocumentoIdentidad tipoDocumento,
    required String numeroDocumento,
    required String razonSocialONombres,
    String? direccion,
    String? telefono,
    String? email,
    DateTime? creadoEn,
  }) = _Cliente;

  const Cliente._();

  /// Cliente genérico para boletas de venta menores a S/ 700 sin identificar.
  factory Cliente.publicoGeneral() => const Cliente(
        tipoDocumento: TipoDocumentoIdentidad.sinDocumento,
        numeroDocumento: '0',
        razonSocialONombres: 'CLIENTES VARIOS',
      );

  /// `DNI 12345678` — etiqueta corta para listas.
  String get documentoFormateado =>
      '${tipoDocumento.etiqueta} ${numeroDocumento.trim()}';

  /// Una factura sólo puede emitirse a un receptor con RUC.
  bool get puedeRecibirFactura => tipoDocumento == TipoDocumentoIdentidad.ruc;

  /// Iniciales para el avatar del listado.
  String get iniciales {
    final palabras = razonSocialONombres
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (palabras.isEmpty) return '?';
    if (palabras.length == 1) return palabras.first.substring(0, 1).toUpperCase();
    return (palabras[0][0] + palabras[1][0]).toUpperCase();
  }
}
