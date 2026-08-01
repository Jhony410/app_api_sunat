// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ajustes_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ajustesRepositorio)
const ajustesRepositorioProvider = AjustesRepositorioProvider._();

final class AjustesRepositorioProvider
    extends
        $FunctionalProvider<
          AjustesRepositorio,
          AjustesRepositorio,
          AjustesRepositorio
        >
    with $Provider<AjustesRepositorio> {
  const AjustesRepositorioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ajustesRepositorioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ajustesRepositorioHash();

  @$internal
  @override
  $ProviderElement<AjustesRepositorio> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AjustesRepositorio create(Ref ref) {
    return ajustesRepositorio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AjustesRepositorio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AjustesRepositorio>(value),
    );
  }
}

String _$ajustesRepositorioHash() =>
    r'04439e9caab3c172d1fb2841ab84c34055c12a07';

/// Configuración vigente. Se re-emite sola cuando cambia cualquier ajuste.

@ProviderFor(ajustes)
const ajustesProvider = AjustesProvider._();

/// Configuración vigente. Se re-emite sola cuando cambia cualquier ajuste.

final class AjustesProvider
    extends $FunctionalProvider<AsyncValue<Ajustes>, Ajustes, Stream<Ajustes>>
    with $FutureModifier<Ajustes>, $StreamProvider<Ajustes> {
  /// Configuración vigente. Se re-emite sola cuando cambia cualquier ajuste.
  const AjustesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ajustesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ajustesHash();

  @$internal
  @override
  $StreamProviderElement<Ajustes> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Ajustes> create(Ref ref) {
    return ajustes(ref);
  }
}

String _$ajustesHash() => r'b927c156b4a52aab8eab8fb2fe9a0d5216a158af';

/// Tema elegido por el usuario, con `system` mientras carga la configuración.

@ProviderFor(modoTema)
const modoTemaProvider = ModoTemaProvider._();

/// Tema elegido por el usuario, con `system` mientras carga la configuración.

final class ModoTemaProvider
    extends $FunctionalProvider<ThemeMode, ThemeMode, ThemeMode>
    with $Provider<ThemeMode> {
  /// Tema elegido por el usuario, con `system` mientras carga la configuración.
  const ModoTemaProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'modoTemaProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$modoTemaHash();

  @$internal
  @override
  $ProviderElement<ThemeMode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeMode create(Ref ref) {
    return modoTema(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$modoTemaHash() => r'42164cd034db9ebf105d5d697683d59bf1b672c3';

/// Acciones sobre la configuración.

@ProviderFor(ControladorAjustes)
const controladorAjustesProvider = ControladorAjustesProvider._();

/// Acciones sobre la configuración.
final class ControladorAjustesProvider
    extends $NotifierProvider<ControladorAjustes, void> {
  /// Acciones sobre la configuración.
  const ControladorAjustesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controladorAjustesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$controladorAjustesHash();

  @$internal
  @override
  ControladorAjustes create() => ControladorAjustes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$controladorAjustesHash() =>
    r'b3cd94eafcc57af3d660d7655730be320a1840ce';

/// Acciones sobre la configuración.

abstract class _$ControladorAjustes extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
