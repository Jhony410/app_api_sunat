// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comprobantes_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(comprobanteRepositorio)
const comprobanteRepositorioProvider = ComprobanteRepositorioProvider._();

final class ComprobanteRepositorioProvider
    extends
        $FunctionalProvider<
          ComprobanteRepositorio,
          ComprobanteRepositorio,
          ComprobanteRepositorio
        >
    with $Provider<ComprobanteRepositorio> {
  const ComprobanteRepositorioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'comprobanteRepositorioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$comprobanteRepositorioHash();

  @$internal
  @override
  $ProviderElement<ComprobanteRepositorio> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ComprobanteRepositorio create(Ref ref) {
    return comprobanteRepositorio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ComprobanteRepositorio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ComprobanteRepositorio>(value),
    );
  }
}

String _$comprobanteRepositorioHash() =>
    r'dca08f24939229b0ac4ebe0802b7eabb96aee6b0';

/// Filtros activos del historial.

@ProviderFor(FiltroHistorial)
const filtroHistorialProvider = FiltroHistorialProvider._();

/// Filtros activos del historial.
final class FiltroHistorialProvider
    extends $NotifierProvider<FiltroHistorial, FiltroComprobantes> {
  /// Filtros activos del historial.
  const FiltroHistorialProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filtroHistorialProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filtroHistorialHash();

  @$internal
  @override
  FiltroHistorial create() => FiltroHistorial();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FiltroComprobantes value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FiltroComprobantes>(value),
    );
  }
}

String _$filtroHistorialHash() => r'9f708630ef430a1c91a89d42d4b09dbdc33a126f';

/// Filtros activos del historial.

abstract class _$FiltroHistorial extends $Notifier<FiltroComprobantes> {
  FiltroComprobantes build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FiltroComprobantes, FiltroComprobantes>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FiltroComprobantes, FiltroComprobantes>,
              FiltroComprobantes,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Historial que corresponde a los filtros activos.

@ProviderFor(historialComprobantes)
const historialComprobantesProvider = HistorialComprobantesProvider._();

/// Historial que corresponde a los filtros activos.

final class HistorialComprobantesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ResumenComprobante>>,
          List<ResumenComprobante>,
          Stream<List<ResumenComprobante>>
        >
    with
        $FutureModifier<List<ResumenComprobante>>,
        $StreamProvider<List<ResumenComprobante>> {
  /// Historial que corresponde a los filtros activos.
  const HistorialComprobantesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historialComprobantesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historialComprobantesHash();

  @$internal
  @override
  $StreamProviderElement<List<ResumenComprobante>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ResumenComprobante>> create(Ref ref) {
    return historialComprobantes(ref);
  }
}

String _$historialComprobantesHash() =>
    r'42e0bdb1dd0098c5e937393ca7f89bcda7d95542';

/// Un comprobante concreto con todos sus ítems.

@ProviderFor(comprobantePorId)
const comprobantePorIdProvider = ComprobantePorIdFamily._();

/// Un comprobante concreto con todos sus ítems.

final class ComprobantePorIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Comprobante?>,
          Comprobante?,
          Stream<Comprobante?>
        >
    with $FutureModifier<Comprobante?>, $StreamProvider<Comprobante?> {
  /// Un comprobante concreto con todos sus ítems.
  const ComprobantePorIdProvider._({
    required ComprobantePorIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'comprobantePorIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$comprobantePorIdHash();

  @override
  String toString() {
    return r'comprobantePorIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Comprobante?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Comprobante?> create(Ref ref) {
    final argument = this.argument as int;
    return comprobantePorId(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ComprobantePorIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$comprobantePorIdHash() => r'bf4a1d6bfd3b35d8d939c45f9051e4a1c6070d4f';

/// Un comprobante concreto con todos sus ítems.

final class ComprobantePorIdFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Comprobante?>, int> {
  const ComprobantePorIdFamily._()
    : super(
        retry: null,
        name: r'comprobantePorIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Un comprobante concreto con todos sus ítems.

  ComprobantePorIdProvider call(int id) =>
      ComprobantePorIdProvider._(argument: id, from: this);

  @override
  String toString() => r'comprobantePorIdProvider';
}

/// Próximo número que tomaría la serie indicada (sólo informativo).

@ProviderFor(proximoCorrelativo)
const proximoCorrelativoProvider = ProximoCorrelativoFamily._();

/// Próximo número que tomaría la serie indicada (sólo informativo).

final class ProximoCorrelativoProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Próximo número que tomaría la serie indicada (sólo informativo).
  const ProximoCorrelativoProvider._({
    required ProximoCorrelativoFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'proximoCorrelativoProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$proximoCorrelativoHash();

  @override
  String toString() {
    return r'proximoCorrelativoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    final argument = this.argument as String;
    return proximoCorrelativo(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProximoCorrelativoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$proximoCorrelativoHash() =>
    r'fd3ca04a791aa5eaed4101fa8e56734ab303d6a8';

/// Próximo número que tomaría la serie indicada (sólo informativo).

final class ProximoCorrelativoFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<int>, String> {
  const ProximoCorrelativoFamily._()
    : super(
        retry: null,
        name: r'proximoCorrelativoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Próximo número que tomaría la serie indicada (sólo informativo).

  ProximoCorrelativoProvider call(String serie) =>
      ProximoCorrelativoProvider._(argument: serie, from: this);

  @override
  String toString() => r'proximoCorrelativoProvider';
}

/// Cifras del mes en curso para el dashboard.

@ProviderFor(resumenDelMes)
const resumenDelMesProvider = ResumenDelMesProvider._();

/// Cifras del mes en curso para el dashboard.

final class ResumenDelMesProvider
    extends
        $FunctionalProvider<
          AsyncValue<ResumenPeriodo>,
          ResumenPeriodo,
          Stream<ResumenPeriodo>
        >
    with $FutureModifier<ResumenPeriodo>, $StreamProvider<ResumenPeriodo> {
  /// Cifras del mes en curso para el dashboard.
  const ResumenDelMesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resumenDelMesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resumenDelMesHash();

  @$internal
  @override
  $StreamProviderElement<ResumenPeriodo> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ResumenPeriodo> create(Ref ref) {
    return resumenDelMes(ref);
  }
}

String _$resumenDelMesHash() => r'f013a3b507bc459e8fadf8718746b907d71402e0';

/// Cifras del día de hoy para el dashboard.

@ProviderFor(resumenDelDia)
const resumenDelDiaProvider = ResumenDelDiaProvider._();

/// Cifras del día de hoy para el dashboard.

final class ResumenDelDiaProvider
    extends
        $FunctionalProvider<
          AsyncValue<ResumenPeriodo>,
          ResumenPeriodo,
          Stream<ResumenPeriodo>
        >
    with $FutureModifier<ResumenPeriodo>, $StreamProvider<ResumenPeriodo> {
  /// Cifras del día de hoy para el dashboard.
  const ResumenDelDiaProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resumenDelDiaProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resumenDelDiaHash();

  @$internal
  @override
  $StreamProviderElement<ResumenPeriodo> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ResumenPeriodo> create(Ref ref) {
    return resumenDelDia(ref);
  }
}

String _$resumenDelDiaHash() => r'77930aa87b5606457a9a711cd68da590b35df68c';

/// Importe emitido en los últimos 14 días, para el gráfico del dashboard.

@ProviderFor(importeUltimosDias)
const importeUltimosDiasProvider = ImporteUltimosDiasFamily._();

/// Importe emitido en los últimos 14 días, para el gráfico del dashboard.

final class ImporteUltimosDiasProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<DateTime, double>>,
          Map<DateTime, double>,
          Stream<Map<DateTime, double>>
        >
    with
        $FutureModifier<Map<DateTime, double>>,
        $StreamProvider<Map<DateTime, double>> {
  /// Importe emitido en los últimos 14 días, para el gráfico del dashboard.
  const ImporteUltimosDiasProvider._({
    required ImporteUltimosDiasFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'importeUltimosDiasProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$importeUltimosDiasHash();

  @override
  String toString() {
    return r'importeUltimosDiasProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Map<DateTime, double>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Map<DateTime, double>> create(Ref ref) {
    final argument = this.argument as int;
    return importeUltimosDias(ref, dias: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ImporteUltimosDiasProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$importeUltimosDiasHash() =>
    r'9dfdadf22097b5a74951b23f85916751a1d2da3a';

/// Importe emitido en los últimos 14 días, para el gráfico del dashboard.

final class ImporteUltimosDiasFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Map<DateTime, double>>, int> {
  const ImporteUltimosDiasFamily._()
    : super(
        retry: null,
        name: r'importeUltimosDiasProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Importe emitido en los últimos 14 días, para el gráfico del dashboard.

  ImporteUltimosDiasProvider call({int dias = 14}) =>
      ImporteUltimosDiasProvider._(argument: dias, from: this);

  @override
  String toString() => r'importeUltimosDiasProvider';
}
