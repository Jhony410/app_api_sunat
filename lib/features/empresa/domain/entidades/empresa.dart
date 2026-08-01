import 'package:freezed_annotation/freezed_annotation.dart';

part 'empresa.freezed.dart';

/// Datos del emisor. Sólo existe un registro (id = 1) y se captura en el
/// onboarding la primera vez que se abre la app.
@freezed
abstract class Empresa with _$Empresa {
  const factory Empresa({
    @Default(1) int id,
    required String ruc,
    required String razonSocial,
    @Default('') String nombreComercial,

    /// Código de ubigeo INEI de 6 dígitos (`cbc:ID` de la dirección fiscal).
    @Default('') String ubigeo,
    @Default('') String departamento,
    @Default('') String provincia,
    @Default('') String distrito,
    @Default('') String direccion,

    /// Ruta local del logo que se imprime en el RIDE.
    String? logoPath,

    /// Series habilitadas por tipo de comprobante (ej. `F001`, `B001`).
    @Default(<String>['F001']) List<String> seriesFactura,
    @Default(<String>['B001']) List<String> seriesBoleta,
  }) = _Empresa;

  const Empresa._();

  /// Nombre a mostrar: prioriza el nombre comercial cuando existe.
  String get nombreParaMostrar =>
      nombreComercial.trim().isEmpty ? razonSocial : nombreComercial;

  /// Dirección completa en una línea, tal como se imprime en el RIDE.
  String get direccionCompleta {
    final partes = [direccion, distrito, provincia, departamento]
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty);
    return partes.join(' - ');
  }

  /// La configuración está completa cuando se puede emitir un comprobante.
  bool get estaConfigurada =>
      ruc.trim().length == 11 && razonSocial.trim().isNotEmpty && direccion.trim().isNotEmpty;
}
