// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empresa_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(empresaRepositorio)
const empresaRepositorioProvider = EmpresaRepositorioProvider._();

final class EmpresaRepositorioProvider
    extends
        $FunctionalProvider<
          EmpresaRepositorio,
          EmpresaRepositorio,
          EmpresaRepositorio
        >
    with $Provider<EmpresaRepositorio> {
  const EmpresaRepositorioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'empresaRepositorioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$empresaRepositorioHash();

  @$internal
  @override
  $ProviderElement<EmpresaRepositorio> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EmpresaRepositorio create(Ref ref) {
    return empresaRepositorio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmpresaRepositorio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmpresaRepositorio>(value),
    );
  }
}

String _$empresaRepositorioHash() =>
    r'4e50fae734e96f787de9b80b291bb370328ed0ea';

/// Empresa emisora configurada, o `null` si aún no se completó el onboarding.

@ProviderFor(empresa)
const empresaProvider = EmpresaProvider._();

/// Empresa emisora configurada, o `null` si aún no se completó el onboarding.

final class EmpresaProvider
    extends
        $FunctionalProvider<AsyncValue<Empresa?>, Empresa?, Stream<Empresa?>>
    with $FutureModifier<Empresa?>, $StreamProvider<Empresa?> {
  /// Empresa emisora configurada, o `null` si aún no se completó el onboarding.
  const EmpresaProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'empresaProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$empresaHash();

  @$internal
  @override
  $StreamProviderElement<Empresa?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Empresa?> create(Ref ref) {
    return empresa(ref);
  }
}

String _$empresaHash() => r'61bcf75b70ba168ea18a4515fa59ed5bece08a82';

/// `true` mientras falte configurar el emisor: el router lo usa para forzar
/// el onboarding antes de dejar entrar a cualquier otra pantalla.

@ProviderFor(requiereConfiguracionInicial)
const requiereConfiguracionInicialProvider =
    RequiereConfiguracionInicialProvider._();

/// `true` mientras falte configurar el emisor: el router lo usa para forzar
/// el onboarding antes de dejar entrar a cualquier otra pantalla.

final class RequiereConfiguracionInicialProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// `true` mientras falte configurar el emisor: el router lo usa para forzar
  /// el onboarding antes de dejar entrar a cualquier otra pantalla.
  const RequiereConfiguracionInicialProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requiereConfiguracionInicialProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requiereConfiguracionInicialHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return requiereConfiguracionInicial(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$requiereConfiguracionInicialHash() =>
    r'171966c287aceac37ed27082ce4cd805db51267a';

@ProviderFor(ControladorEmpresa)
const controladorEmpresaProvider = ControladorEmpresaProvider._();

final class ControladorEmpresaProvider
    extends $NotifierProvider<ControladorEmpresa, void> {
  const ControladorEmpresaProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controladorEmpresaProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$controladorEmpresaHash();

  @$internal
  @override
  ControladorEmpresa create() => ControladorEmpresa();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$controladorEmpresaHash() =>
    r'f984854ab46233286683f68559536e6a4633859d';

abstract class _$ControladorEmpresa extends $Notifier<void> {
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
