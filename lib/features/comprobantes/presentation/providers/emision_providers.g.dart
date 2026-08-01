// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emision_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Servicio de emisión con la pasarela que corresponda al modo de operación.
///
/// En Fase 1 nunca hay pasarela, así que todo se emite en modo Simulación.
/// En Fase 3 este provider devuelve la pasarela de Lycet cuando está
/// configurada.

@ProviderFor(servicioEmision)
const servicioEmisionProvider = ServicioEmisionProvider._();

/// Servicio de emisión con la pasarela que corresponda al modo de operación.
///
/// En Fase 1 nunca hay pasarela, así que todo se emite en modo Simulación.
/// En Fase 3 este provider devuelve la pasarela de Lycet cuando está
/// configurada.

final class ServicioEmisionProvider
    extends
        $FunctionalProvider<ServicioEmision, ServicioEmision, ServicioEmision>
    with $Provider<ServicioEmision> {
  /// Servicio de emisión con la pasarela que corresponda al modo de operación.
  ///
  /// En Fase 1 nunca hay pasarela, así que todo se emite en modo Simulación.
  /// En Fase 3 este provider devuelve la pasarela de Lycet cuando está
  /// configurada.
  const ServicioEmisionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'servicioEmisionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$servicioEmisionHash();

  @$internal
  @override
  $ProviderElement<ServicioEmision> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ServicioEmision create(Ref ref) {
    return servicioEmision(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServicioEmision value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServicioEmision>(value),
    );
  }
}

String _$servicioEmisionHash() => r'cb33f064121ad417b0343ed13433b7ea6cf994d9';

/// Acciones de emisión. El estado `AsyncValue` refleja el progreso para poder
/// bloquear el botón y mostrar el indicador de carga.

@ProviderFor(ControladorEmision)
const controladorEmisionProvider = ControladorEmisionProvider._();

/// Acciones de emisión. El estado `AsyncValue` refleja el progreso para poder
/// bloquear el botón y mostrar el indicador de carga.
final class ControladorEmisionProvider
    extends $AsyncNotifierProvider<ControladorEmision, EmisionCompletada?> {
  /// Acciones de emisión. El estado `AsyncValue` refleja el progreso para poder
  /// bloquear el botón y mostrar el indicador de carga.
  const ControladorEmisionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controladorEmisionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$controladorEmisionHash();

  @$internal
  @override
  ControladorEmision create() => ControladorEmision();
}

String _$controladorEmisionHash() =>
    r'36452b60c7da8ceb2ace59227071e4dfb7f10ee8';

/// Acciones de emisión. El estado `AsyncValue` refleja el progreso para poder
/// bloquear el botón y mostrar el indicador de carga.

abstract class _$ControladorEmision extends $AsyncNotifier<EmisionCompletada?> {
  FutureOr<EmisionCompletada?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<EmisionCompletada?>, EmisionCompletada?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<EmisionCompletada?>, EmisionCompletada?>,
              AsyncValue<EmisionCompletada?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
