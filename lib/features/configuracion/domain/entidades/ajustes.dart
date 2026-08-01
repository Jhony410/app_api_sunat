import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/database/tablas.dart';

part 'ajustes.freezed.dart';

/// Valores por defecto inyectados en tiempo de compilación.
///
/// Se definen con `--dart-define-from-file=env.json` (ver `env.example.json`).
/// Nunca se escriben credenciales en el código: si la variable no existe, el
/// valor queda vacío y la app funciona igual en modo Simulación.
abstract final class ValoresPorDefecto {
  static const lycetUrl = String.fromEnvironment('LYCET_URL');
  static const lycetToken = String.fromEnvironment('LYCET_TOKEN');
  static const proveedorConsulta =
      String.fromEnvironment('PROVEEDOR_CONSULTA', defaultValue: 'decolecta');
  static const tokenConsulta = String.fromEnvironment('TOKEN_CONSULTA');
}

/// Preferencias y configuración editables desde la app.
@freezed
abstract class Ajustes with _$Ajustes {
  const factory Ajustes({
    @Default(ModoOperacion.simulacion) ModoOperacion modoOperacion,
    @Default('') String lycetUrl,
    @Default('') String lycetToken,
    @Default('decolecta') String proveedorConsulta,
    @Default('') String tokenConsulta,
    @Default(ThemeMode.system) ThemeMode temaApp,
  }) = _Ajustes;

  const Ajustes._();

  /// Reconstruye los ajustes desde la tabla clave/valor, cayendo en los valores
  /// de compilación cuando la clave todavía no se guardó.
  factory Ajustes.desdeMapa(Map<String, String> mapa) {
    String leer(String clave, String porDefecto) {
      final valor = mapa[clave];
      return (valor == null || valor.isEmpty) ? porDefecto : valor;
    }

    return Ajustes(
      modoOperacion: ModoOperacion.desdeNombre(mapa[ClavesAjuste.modoOperacion]),
      lycetUrl: leer(ClavesAjuste.lycetUrl, ValoresPorDefecto.lycetUrl),
      lycetToken: leer(ClavesAjuste.lycetToken, ValoresPorDefecto.lycetToken),
      proveedorConsulta:
          leer(ClavesAjuste.proveedorConsulta, ValoresPorDefecto.proveedorConsulta),
      tokenConsulta: leer(ClavesAjuste.tokenConsulta, ValoresPorDefecto.tokenConsulta),
      temaApp: switch (mapa[ClavesAjuste.temaApp]) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      },
    );
  }

  /// La emisión real necesita, como mínimo, la URL de Lycet configurada.
  bool get puedeEmitirEnReal =>
      modoOperacion == ModoOperacion.real && lycetUrl.trim().isNotEmpty;

  /// La consulta RUC/DNI necesita un token del proveedor.
  bool get puedeConsultarDocumentos => tokenConsulta.trim().isNotEmpty;
}
