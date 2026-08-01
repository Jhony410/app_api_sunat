import '../../../core/database/app_database.dart';
import '../../../core/database/tablas.dart';
import '../domain/entidades/ajustes.dart';

/// Configuración de la app en formato clave/valor.
///
/// La URL y el token de Lycet se guardan aquí porque el usuario los edita
/// desde la pantalla de Configuración. Los valores por compilación
/// (`--dart-define`) sólo actúan como valor inicial.
class AjustesRepositorio {
  AjustesRepositorio(this._db);

  final AppDatabase _db;

  Stream<Ajustes> observar() {
    return _db.select(_db.ajustesTabla).watch().map(_aEntidad);
  }

  Future<Ajustes> obtener() async {
    return _aEntidad(await _db.select(_db.ajustesTabla).get());
  }

  Future<void> guardarValor(String clave, String valor) async {
    await _db.into(_db.ajustesTabla).insertOnConflictUpdate(
          AjustesTablaCompanion.insert(clave: clave, valor: valor),
        );
  }

  Future<void> guardar(Ajustes ajustes) async {
    await _db.transaction(() async {
      await guardarValor(ClavesAjuste.modoOperacion, ajustes.modoOperacion.name);
      await guardarValor(ClavesAjuste.lycetUrl, ajustes.lycetUrl);
      await guardarValor(ClavesAjuste.lycetToken, ajustes.lycetToken);
      await guardarValor(ClavesAjuste.proveedorConsulta, ajustes.proveedorConsulta);
      await guardarValor(ClavesAjuste.tokenConsulta, ajustes.tokenConsulta);
    });
  }

  Ajustes _aEntidad(List<AjusteRow> filas) {
    final mapa = {for (final fila in filas) fila.clave: fila.valor};
    return Ajustes.desdeMapa(mapa);
  }
}
