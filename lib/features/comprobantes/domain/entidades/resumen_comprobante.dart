import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../../core/utils/formatos.dart';

part 'resumen_comprobante.freezed.dart';

/// Proyección ligera de un comprobante para el historial y el dashboard.
///
/// Evita cargar los ítems de cada documento sólo para pintar una lista; el
/// importe viene de la columna denormalizada de la cabecera.
@freezed
abstract class ResumenComprobante with _$ResumenComprobante {
  const factory ResumenComprobante({
    required int id,
    required TipoComprobante tipo,
    required String serie,
    required int correlativo,
    required DateTime fechaEmision,
    required Moneda moneda,
    required String clienteRazonSocial,
    required String clienteDocumento,
    required EstadoSunat estadoSunat,
    required double importeTotal,
  }) = _ResumenComprobante;

  const ResumenComprobante._();

  String get numeroCompleto => formatearNumeroComprobante(serie, correlativo);
}

/// Criterios de búsqueda del historial. Todos los campos son opcionales y se
/// combinan con `AND`.
@freezed
abstract class FiltroComprobantes with _$FiltroComprobantes {
  const factory FiltroComprobantes({
    /// Busca en serie-correlativo, razón social y documento del cliente.
    @Default('') String texto,
    TipoComprobante? tipo,
    EstadoSunat? estado,
    DateTime? desde,
    DateTime? hasta,
    int? clienteId,
  }) = _FiltroComprobantes;

  const FiltroComprobantes._();

  /// `true` si no hay ningún criterio activo (se muestra todo el historial).
  bool get estaVacio =>
      texto.trim().isEmpty &&
      tipo == null &&
      estado == null &&
      desde == null &&
      hasta == null &&
      clienteId == null;

  /// Cantidad de filtros activos, para el contador del botón de filtros.
  int get filtrosActivos => [
        texto.trim().isNotEmpty,
        tipo != null,
        estado != null,
        desde != null || hasta != null,
        clienteId != null,
      ].where((activo) => activo).length;
}
