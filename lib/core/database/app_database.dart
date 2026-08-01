import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

// El código generado en `app_database.g.dart` es un `part` de este archivo, así
// que hereda estos imports: los enums de catálogo tienen que estar visibles aquí
// aunque no se usen directamente en el cuerpo de la clase.
import '../constantes/catalogos_sunat.dart';
import 'convertidores.dart';
import 'tablas.dart';

part 'app_database.g.dart';

/// Base de datos local de la aplicación (SQLite vía Drift).
///
/// Las migraciones se llevan desde el primer día: cada cambio de esquema sube
/// [schemaVersion] y añade su paso en [migration], de modo que una app ya
/// instalada nunca pierda los comprobantes emitidos.
@DriftDatabase(
  tables: [
    EmpresasTabla,
    ClientesTabla,
    ComprobantesTabla,
    ItemsComprobanteTabla,
    CorrelativosTabla,
    AjustesTabla,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_abrirConexion());

  /// Constructor para pruebas: recibe un ejecutor en memoria.
  AppDatabase.paraPruebas(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, desde, hasta) async {
          // Aún no hay migraciones: la versión 1 es la inicial. Cada versión
          // futura añade aquí su bloque `if (desde < N) { ... }`.
        },
        beforeOpen: (details) async {
          // Sin esta directiva SQLite ignora las claves foráneas y el borrado
          // en cascada de los ítems no ocurriría.
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  static QueryExecutor _abrirConexion() =>
      driftDatabase(name: 'app_api_sunat');
}
