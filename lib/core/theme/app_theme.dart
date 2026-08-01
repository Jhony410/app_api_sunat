// `CupertinoPageTransitionsBuilder` vive en cupertino, no lo reexporta material.
import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Sistema de diseño de la app.
///
/// Se construye sobre Material 3 pero con una identidad propia: acento
/// esmeralda con apoyo índigo sobre neutros cálidos, en lugar del azul
/// institucional por defecto. La retícula de espaciado es de múltiplos de 8
/// (ver [Espaciado]) y las esquinas siguen una escala corta (ver [Radios]).
abstract final class AppTheme {
  /// Color semilla: un esmeralda profundo, distintivo y con buen contraste
  /// tanto en claro como en oscuro.
  static const Color semilla = Color(0xFF0E9F6E);

  /// Acento secundario para gráficos, chips y estados informativos.
  static const Color indigo = Color(0xFF4F46E5);

  /// Neutro cálido de fondo en tema claro (evita el gris azulado de Material).
  static const Color arenaClara = Color(0xFFFBF9F6);
  static const Color arenaClaraSuave = Color(0xFFF3EFE9);

  /// Neutro cálido de fondo en tema oscuro.
  static const Color carbon = Color(0xFF16151A);
  static const Color carbonSuave = Color(0xFF201F26);

  static const String fuenteTitulos = 'Outfit';
  static const String fuenteTexto = 'Inter';

  static ThemeData claro() => _construir(Brightness.light);

  static ThemeData oscuro() => _construir(Brightness.dark);

  static ThemeData _construir(Brightness brillo) {
    final esClaro = brillo == Brightness.light;

    final esquema = ColorScheme.fromSeed(
      seedColor: semilla,
      brightness: brillo,
      // Se fuerzan los neutros cálidos: `fromSeed` los derivaría fríos.
      surface: esClaro ? arenaClara : carbon,
      surfaceContainerLowest: esClaro ? Colors.white : const Color(0xFF121116),
      surfaceContainerLow: esClaro ? const Color(0xFFF8F5F1) : const Color(0xFF1B1A20),
      surfaceContainer: esClaro ? arenaClaraSuave : carbonSuave,
      surfaceContainerHigh: esClaro ? const Color(0xFFEDE8E1) : const Color(0xFF2A2831),
      surfaceContainerHighest: esClaro ? const Color(0xFFE6E0D8) : const Color(0xFF34313D),
      tertiary: indigo,
    );

    final textos = _tipografia(esquema);

    return ThemeData(
      useMaterial3: true,
      colorScheme: esquema,
      scaffoldBackgroundColor: esquema.surface,
      textTheme: textos,
      fontFamily: fuenteTexto,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,

      appBarTheme: AppBarTheme(
        backgroundColor: esquema.surface,
        surfaceTintColor: Colors.transparent,
        foregroundColor: esquema.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        titleTextStyle: textos.titleLarge,
        systemOverlayStyle:
            esClaro ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: esquema.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radios.medio),
          side: BorderSide(color: esquema.outlineVariant.withValues(alpha: 0.5)),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: esquema.surfaceContainerLow,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Espaciado.md,
          vertical: Espaciado.md,
        ),
        border: _borde(esquema.outlineVariant),
        enabledBorder: _borde(esquema.outlineVariant),
        focusedBorder: _borde(esquema.primary, ancho: 1.6),
        errorBorder: _borde(esquema.error),
        focusedErrorBorder: _borde(esquema.error, ancho: 1.6),
        floatingLabelStyle: TextStyle(color: esquema.primary),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          // 48 dp de alto: el mínimo cómodo para tocar con el pulgar.
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: Espaciado.lg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radios.chico),
          ),
          textStyle: textos.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: Espaciado.lg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radios.chico),
          ),
          side: BorderSide(color: esquema.outline),
          textStyle: textos.labelLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 44),
          textStyle: textos.labelLarge,
        ),
      ),

      chipTheme: ChipThemeData(
        side: BorderSide(color: esquema.outlineVariant),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radios.completo),
        ),
        labelStyle: textos.labelMedium,
        padding: const EdgeInsets.symmetric(horizontal: Espaciado.sm, vertical: 6),
      ),

      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radios.medio),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Espaciado.md,
          vertical: Espaciado.xs,
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: esquema.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radios.grande),
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: esquema.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(Radios.grande)),
        ),
        showDragHandle: true,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: esquema.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        indicatorColor: esquema.primaryContainer,
        elevation: 0,
        height: 68,
        labelTextStyle: WidgetStatePropertyAll(textos.labelSmall),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radios.chico),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: esquema.outlineVariant.withValues(alpha: 0.6),
        space: 1,
        thickness: 1,
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
        },
      ),
    );
  }

  static OutlineInputBorder _borde(Color color, {double ancho = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radios.chico),
        borderSide: BorderSide(color: color, width: ancho),
      );

  /// Escala tipográfica: Outfit (geométrica) manda en títulos y cifras, Inter
  /// (humanista) en todo el texto que se lee de corrido.
  static TextTheme _tipografia(ColorScheme esquema) {
    final base = ThemeData(brightness: esquema.brightness).textTheme;

    TextStyle titulo(TextStyle? estilo, double tamano, FontWeight peso) =>
        (estilo ?? const TextStyle()).copyWith(
          fontFamily: fuenteTitulos,
          fontSize: tamano,
          fontWeight: peso,
          letterSpacing: -0.4,
          color: esquema.onSurface,
        );

    TextStyle texto(TextStyle? estilo, double tamano, FontWeight peso,
            {Color? color}) =>
        (estilo ?? const TextStyle()).copyWith(
          fontFamily: fuenteTexto,
          fontSize: tamano,
          fontWeight: peso,
          height: 1.45,
          color: color ?? esquema.onSurface,
        );

    return base.copyWith(
      displayLarge: titulo(base.displayLarge, 44, FontWeight.w700),
      displayMedium: titulo(base.displayMedium, 36, FontWeight.w700),
      displaySmall: titulo(base.displaySmall, 30, FontWeight.w600),
      headlineLarge: titulo(base.headlineLarge, 28, FontWeight.w600),
      headlineMedium: titulo(base.headlineMedium, 24, FontWeight.w600),
      headlineSmall: titulo(base.headlineSmall, 20, FontWeight.w600),
      titleLarge: titulo(base.titleLarge, 19, FontWeight.w600),
      titleMedium: titulo(base.titleMedium, 16, FontWeight.w600),
      titleSmall: titulo(base.titleSmall, 14, FontWeight.w600),
      bodyLarge: texto(base.bodyLarge, 15.5, FontWeight.w400),
      bodyMedium: texto(base.bodyMedium, 14, FontWeight.w400),
      bodySmall: texto(base.bodySmall, 12.5, FontWeight.w400,
          color: esquema.onSurfaceVariant),
      labelLarge: texto(base.labelLarge, 14.5, FontWeight.w600),
      labelMedium: texto(base.labelMedium, 12.5, FontWeight.w500),
      labelSmall: texto(base.labelSmall, 11.5, FontWeight.w500),
    );
  }
}

/// Retícula de espaciado en múltiplos de 8 (con dos medios pasos de 4 y 12).
abstract final class Espaciado {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

/// Escala de radios de esquina.
abstract final class Radios {
  static const double chico = 12;
  static const double medio = 16;
  static const double grande = 24;
  static const double completo = 999;
}

/// Colores semánticos que no vienen en el `ColorScheme` de Material.
///
/// Se resuelven contra el brillo actual para mantener el contraste en ambos temas.
abstract final class ColoresEstado {
  static Color exito(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF057A55)
          : const Color(0xFF31C48D);

  static Color advertencia(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF9F580A)
          : const Color(0xFFE3A008);

  static Color informacion(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF4F46E5)
          : const Color(0xFF8B85F0);

  static Color neutro(BuildContext context) =>
      Theme.of(context).colorScheme.onSurfaceVariant;
}
