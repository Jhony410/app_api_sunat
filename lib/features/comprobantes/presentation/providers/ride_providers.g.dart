// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(generadorRide)
const generadorRideProvider = GeneradorRideProvider._();

final class GeneradorRideProvider
    extends $FunctionalProvider<GeneradorRide, GeneradorRide, GeneradorRide>
    with $Provider<GeneradorRide> {
  const GeneradorRideProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generadorRideProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$generadorRideHash();

  @$internal
  @override
  $ProviderElement<GeneradorRide> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GeneradorRide create(Ref ref) {
    return generadorRide(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GeneradorRide value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GeneradorRide>(value),
    );
  }
}

String _$generadorRideHash() => r'9d8603ab96c4e58f90f5ef0c9d7ed72379d9ca54';

/// Acciones sobre la representación impresa: previsualizar, imprimir,
/// compartir y guardar el PDF.

@ProviderFor(ControladorRide)
const controladorRideProvider = ControladorRideProvider._();

/// Acciones sobre la representación impresa: previsualizar, imprimir,
/// compartir y guardar el PDF.
final class ControladorRideProvider
    extends $NotifierProvider<ControladorRide, void> {
  /// Acciones sobre la representación impresa: previsualizar, imprimir,
  /// compartir y guardar el PDF.
  const ControladorRideProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controladorRideProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$controladorRideHash();

  @$internal
  @override
  ControladorRide create() => ControladorRide();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$controladorRideHash() => r'03cb55389475489dd2b1c162477685a5892be33d';

/// Acciones sobre la representación impresa: previsualizar, imprimir,
/// compartir y guardar el PDF.

abstract class _$ControladorRide extends $Notifier<void> {
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
