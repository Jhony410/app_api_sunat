// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nucleo_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Única instancia de la base de datos durante toda la vida de la app.
///
/// `keepAlive` es obligatorio: si Riverpod la descartara al quedarse sin
/// oyentes, cerraría la conexión SQLite en medio de una operación.

@ProviderFor(appDatabase)
const appDatabaseProvider = AppDatabaseProvider._();

/// Única instancia de la base de datos durante toda la vida de la app.
///
/// `keepAlive` es obligatorio: si Riverpod la descartara al quedarse sin
/// oyentes, cerraría la conexión SQLite en medio de una operación.

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// Única instancia de la base de datos durante toda la vida de la app.
  ///
  /// `keepAlive` es obligatorio: si Riverpod la descartara al quedarse sin
  /// oyentes, cerraría la conexión SQLite en medio de una operación.
  const AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'59cce38d45eeaba199eddd097d8e149d66f9f3e1';
