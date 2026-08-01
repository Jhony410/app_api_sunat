import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/app_database.dart';

part 'nucleo_providers.g.dart';

/// Única instancia de la base de datos durante toda la vida de la app.
///
/// `keepAlive` es obligatorio: si Riverpod la descartara al quedarse sin
/// oyentes, cerraría la conexión SQLite en medio de una operación.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}
