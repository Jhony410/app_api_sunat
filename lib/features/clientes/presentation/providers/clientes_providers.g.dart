// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clientes_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(clienteRepositorio)
const clienteRepositorioProvider = ClienteRepositorioProvider._();

final class ClienteRepositorioProvider
    extends
        $FunctionalProvider<
          ClienteRepositorio,
          ClienteRepositorio,
          ClienteRepositorio
        >
    with $Provider<ClienteRepositorio> {
  const ClienteRepositorioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clienteRepositorioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clienteRepositorioHash();

  @$internal
  @override
  $ProviderElement<ClienteRepositorio> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ClienteRepositorio create(Ref ref) {
    return clienteRepositorio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClienteRepositorio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClienteRepositorio>(value),
    );
  }
}

String _$clienteRepositorioHash() =>
    r'a38b357a0c0f67d08a7cfc625338ab05b7888879';

/// Texto del buscador de la pantalla de clientes.

@ProviderFor(BusquedaClientes)
const busquedaClientesProvider = BusquedaClientesProvider._();

/// Texto del buscador de la pantalla de clientes.
final class BusquedaClientesProvider
    extends $NotifierProvider<BusquedaClientes, String> {
  /// Texto del buscador de la pantalla de clientes.
  const BusquedaClientesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'busquedaClientesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$busquedaClientesHash();

  @$internal
  @override
  BusquedaClientes create() => BusquedaClientes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$busquedaClientesHash() => r'8ca254f4551748480f04716b3c935847a8e29f9d';

/// Texto del buscador de la pantalla de clientes.

abstract class _$BusquedaClientes extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Clientes que coinciden con la búsqueda activa.

@ProviderFor(clientes)
const clientesProvider = ClientesProvider._();

/// Clientes que coinciden con la búsqueda activa.

final class ClientesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Cliente>>,
          List<Cliente>,
          Stream<List<Cliente>>
        >
    with $FutureModifier<List<Cliente>>, $StreamProvider<List<Cliente>> {
  /// Clientes que coinciden con la búsqueda activa.
  const ClientesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientesHash();

  @$internal
  @override
  $StreamProviderElement<List<Cliente>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Cliente>> create(Ref ref) {
    return clientes(ref);
  }
}

String _$clientesHash() => r'b4f5ecaf92f9814b55ac54ad80a5acb315f1c5ad';

@ProviderFor(totalClientes)
const totalClientesProvider = TotalClientesProvider._();

final class TotalClientesProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  const TotalClientesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalClientesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalClientesHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return totalClientes(ref);
  }
}

String _$totalClientesHash() => r'a498a31e026a51afbf483f1e852ce32c02e7f7bd';

@ProviderFor(ControladorClientes)
const controladorClientesProvider = ControladorClientesProvider._();

final class ControladorClientesProvider
    extends $NotifierProvider<ControladorClientes, void> {
  const ControladorClientesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controladorClientesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$controladorClientesHash();

  @$internal
  @override
  ControladorClientes create() => ControladorClientes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$controladorClientesHash() =>
    r'8ab874b62a6df5cd29844128902562e8386fa338';

abstract class _$ControladorClientes extends $Notifier<void> {
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
