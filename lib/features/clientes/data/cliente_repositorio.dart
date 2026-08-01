import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/entidades/cliente.dart';

/// Agenda de clientes frecuentes.
class ClienteRepositorio {
  ClienteRepositorio(this._db);

  final AppDatabase _db;

  /// Lista completa ordenada alfabéticamente, filtrable por texto libre.
  Stream<List<Cliente>> observar({String texto = ''}) {
    final patron = '%${texto.trim().toLowerCase()}%';
    final consulta = _db.select(_db.clientesTabla)
      ..orderBy([(c) => OrderingTerm.asc(c.razonSocialONombres)]);

    if (texto.trim().isNotEmpty) {
      consulta.where(
        (c) =>
            c.razonSocialONombres.lower().like(patron) |
            c.numeroDocumento.like(patron),
      );
    }

    return consulta.watch().map((filas) => filas.map(_aEntidad).toList());
  }

  Future<Cliente?> obtenerPorId(int id) async {
    final consulta = _db.select(_db.clientesTabla)..where((c) => c.id.equals(id));
    final fila = await consulta.getSingleOrNull();
    return fila == null ? null : _aEntidad(fila);
  }

  /// Busca por documento para no duplicar fichas al consultar RUC/DNI.
  Future<Cliente?> buscarPorDocumento(String numeroDocumento) async {
    final consulta = _db.select(_db.clientesTabla)
      ..where((c) => c.numeroDocumento.equals(numeroDocumento.trim()));
    final fila = await consulta.getSingleOrNull();
    return fila == null ? null : _aEntidad(fila);
  }

  /// Crea o actualiza la ficha y devuelve su id.
  ///
  /// Si ya existe un cliente con el mismo tipo y número de documento, se
  /// actualiza en lugar de fallar por la restricción de unicidad.
  Future<int> guardar(Cliente cliente) async {
    final companion = ClientesTablaCompanion.insert(
      id: cliente.id == null ? const Value.absent() : Value(cliente.id!),
      tipoDocumento: cliente.tipoDocumento,
      numeroDocumento: cliente.numeroDocumento.trim(),
      razonSocialONombres: cliente.razonSocialONombres.trim(),
      direccion: Value(cliente.direccion?.trim()),
      telefono: Value(cliente.telefono?.trim()),
      email: Value(cliente.email?.trim()),
    );

    if (cliente.id != null) {
      await _db.update(_db.clientesTabla).replace(companion);
      return cliente.id!;
    }

    final existente = await buscarPorDocumento(cliente.numeroDocumento);
    if (existente != null) {
      final actualizado = companion.copyWith(id: Value(existente.id!));
      await _db.update(_db.clientesTabla).replace(actualizado);
      return existente.id!;
    }

    return _db.into(_db.clientesTabla).insert(companion);
  }

  /// Elimina la ficha. Los comprobantes ya emitidos conservan su copia de los
  /// datos del receptor, así que no se pierde información fiscal.
  Future<void> eliminar(int id) async {
    await (_db.delete(_db.clientesTabla)..where((c) => c.id.equals(id))).go();
  }

  Future<int> contar() async {
    final consulta = _db.selectOnly(_db.clientesTabla)
      ..addColumns([_db.clientesTabla.id.count()]);
    final fila = await consulta.getSingle();
    return fila.read(_db.clientesTabla.id.count()) ?? 0;
  }

  Cliente _aEntidad(ClienteRow fila) => Cliente(
        id: fila.id,
        tipoDocumento: fila.tipoDocumento,
        numeroDocumento: fila.numeroDocumento,
        razonSocialONombres: fila.razonSocialONombres,
        direccion: fila.direccion,
        telefono: fila.telefono,
        email: fila.email,
        creadoEn: fila.creadoEn,
      );
}
