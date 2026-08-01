// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrador_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Comprobante que se está capturando en la pantalla "Nuevo comprobante".
///
/// Vive sólo mientras la pantalla está abierta: es un `@riverpod` sin
/// `keepAlive`, así que al salir se descarta y la siguiente emisión empieza
/// limpia. El correlativo real no se asigna aquí, sino al guardar.

@ProviderFor(BorradorComprobante)
const borradorComprobanteProvider = BorradorComprobanteProvider._();

/// Comprobante que se está capturando en la pantalla "Nuevo comprobante".
///
/// Vive sólo mientras la pantalla está abierta: es un `@riverpod` sin
/// `keepAlive`, así que al salir se descarta y la siguiente emisión empieza
/// limpia. El correlativo real no se asigna aquí, sino al guardar.
final class BorradorComprobanteProvider
    extends $NotifierProvider<BorradorComprobante, Comprobante> {
  /// Comprobante que se está capturando en la pantalla "Nuevo comprobante".
  ///
  /// Vive sólo mientras la pantalla está abierta: es un `@riverpod` sin
  /// `keepAlive`, así que al salir se descarta y la siguiente emisión empieza
  /// limpia. El correlativo real no se asigna aquí, sino al guardar.
  const BorradorComprobanteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'borradorComprobanteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$borradorComprobanteHash();

  @$internal
  @override
  BorradorComprobante create() => BorradorComprobante();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Comprobante value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Comprobante>(value),
    );
  }
}

String _$borradorComprobanteHash() =>
    r'619a46dd319e7e3340fc9f62cb3951f945d22e81';

/// Comprobante que se está capturando en la pantalla "Nuevo comprobante".
///
/// Vive sólo mientras la pantalla está abierta: es un `@riverpod` sin
/// `keepAlive`, así que al salir se descarta y la siguiente emisión empieza
/// limpia. El correlativo real no se asigna aquí, sino al guardar.

abstract class _$BorradorComprobante extends $Notifier<Comprobante> {
  Comprobante build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Comprobante, Comprobante>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Comprobante, Comprobante>,
              Comprobante,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Totales del borrador, recalculados en vivo con cada cambio.

@ProviderFor(totalesBorrador)
const totalesBorradorProvider = TotalesBorradorProvider._();

/// Totales del borrador, recalculados en vivo con cada cambio.

final class TotalesBorradorProvider
    extends $FunctionalProvider<Totales, Totales, Totales>
    with $Provider<Totales> {
  /// Totales del borrador, recalculados en vivo con cada cambio.
  const TotalesBorradorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalesBorradorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalesBorradorHash();

  @$internal
  @override
  $ProviderElement<Totales> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Totales create(Ref ref) {
    return totalesBorrador(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Totales value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Totales>(value),
    );
  }
}

String _$totalesBorradorHash() => r'fb8b6c6b9c0d94a9f1d792b73ac4b239a7d1dd46';
