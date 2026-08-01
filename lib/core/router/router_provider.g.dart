// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Enrutador de la app.
///
/// Las cuatro secciones principales viven dentro de un `ShellRoute` con barra
/// de navegación inferior; el resto de pantallas se apila por encima. Mientras
/// falte configurar la empresa, cualquier ruta redirige al onboarding.

@ProviderFor(router)
const routerProvider = RouterProvider._();

/// Enrutador de la app.
///
/// Las cuatro secciones principales viven dentro de un `ShellRoute` con barra
/// de navegación inferior; el resto de pantallas se apila por encima. Mientras
/// falte configurar la empresa, cualquier ruta redirige al onboarding.

final class RouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// Enrutador de la app.
  ///
  /// Las cuatro secciones principales viven dentro de un `ShellRoute` con barra
  /// de navegación inferior; el resto de pantallas se apila por encima. Mientras
  /// falte configurar la empresa, cualquier ruta redirige al onboarding.
  const RouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return router(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$routerHash() => r'ee6a02e89599122e79dd06a59aca5476cd6f1a4c';
