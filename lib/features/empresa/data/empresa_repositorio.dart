import 'package:drift/drift.dart';

import '../../../core/constantes/catalogos_sunat.dart';
import '../../../core/database/app_database.dart';
import '../domain/entidades/empresa.dart';

/// Acceso a los datos del emisor.
///
/// Sólo existe una empresa emisora, así que todas las operaciones trabajan
/// sobre la fila con `id = 1`.
class EmpresaRepositorio {
  EmpresaRepositorio(this._db);

  final AppDatabase _db;

  static const int _idEmpresa = 1;

  /// Emite la empresa configurada, o `null` mientras no se complete el
  /// onboarding. Se actualiza sola cuando cambian los datos.
  Stream<Empresa?> observar() {
    final consulta = _db.select(_db.empresasTabla)
      ..where((e) => e.id.equals(_idEmpresa));
    return consulta.watchSingleOrNull().map(_aEntidad);
  }

  Future<Empresa?> obtener() async {
    final consulta = _db.select(_db.empresasTabla)
      ..where((e) => e.id.equals(_idEmpresa));
    return _aEntidad(await consulta.getSingleOrNull());
  }

  /// Guarda (crea o reemplaza) los datos del emisor y deja registradas sus
  /// series en la tabla de correlativos.
  Future<void> guardar(Empresa empresa) async {
    await _db.transaction(() async {
      await _db.into(_db.empresasTabla).insertOnConflictUpdate(
            EmpresasTablaCompanion.insert(
              id: const Value(_idEmpresa),
              ruc: empresa.ruc.trim(),
              razonSocial: empresa.razonSocial.trim(),
              nombreComercial: Value(empresa.nombreComercial.trim()),
              ubigeo: Value(empresa.ubigeo.trim()),
              departamento: Value(empresa.departamento.trim()),
              provincia: Value(empresa.provincia.trim()),
              distrito: Value(empresa.distrito.trim()),
              direccion: Value(empresa.direccion.trim()),
              logoPath: Value(empresa.logoPath),
              seriesFactura: Value(empresa.seriesFactura),
              seriesBoleta: Value(empresa.seriesBoleta),
            ),
          );

      await _registrarSeries(empresa.seriesFactura, TipoComprobante.factura);
      await _registrarSeries(empresa.seriesBoleta, TipoComprobante.boleta);
    });
  }

  /// Da de alta las series nuevas con correlativo 0.
  ///
  /// Usa `insertOrIgnore` a propósito: si la serie ya existe hay que respetar
  /// su último correlativo, nunca reiniciarlo.
  Future<void> _registrarSeries(List<String> series, TipoComprobante tipo) async {
    for (final serie in series) {
      final limpia = serie.trim().toUpperCase();
      if (limpia.isEmpty) continue;
      await _db.into(_db.correlativosTabla).insert(
            CorrelativosTablaCompanion.insert(serie: limpia, tipo: tipo),
            mode: InsertMode.insertOrIgnore,
          );
    }
  }

  Empresa? _aEntidad(EmpresaRow? fila) {
    if (fila == null) return null;
    return Empresa(
      id: fila.id,
      ruc: fila.ruc,
      razonSocial: fila.razonSocial,
      nombreComercial: fila.nombreComercial,
      ubigeo: fila.ubigeo,
      departamento: fila.departamento,
      provincia: fila.provincia,
      distrito: fila.distrito,
      direccion: fila.direccion,
      logoPath: fila.logoPath,
      seriesFactura: fila.seriesFactura,
      seriesBoleta: fila.seriesBoleta,
    );
  }
}
