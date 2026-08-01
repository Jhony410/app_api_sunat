import 'dart:convert';

import 'package:drift/drift.dart';

import '../constantes/catalogos_sunat.dart';

/// Convertidores entre los tipos del dominio y las columnas de SQLite.
///
/// Los enums de catálogo se persisten por su **código SUNAT** (`'01'`, `'10'`,
/// `'PEN'`…) y no por su índice: el código es el identificador estable del
/// estándar, así que reordenar el `enum` en Dart nunca corrompe datos ya
/// guardados.

class TipoComprobanteConverter extends TypeConverter<TipoComprobante, String>
    with JsonTypeConverter<TipoComprobante, String> {
  const TipoComprobanteConverter();

  @override
  TipoComprobante fromSql(String fromDb) => TipoComprobante.desdeCodigo(fromDb);

  @override
  String toSql(TipoComprobante value) => value.codigo;
}

class TipoDocumentoIdentidadConverter
    extends TypeConverter<TipoDocumentoIdentidad, String>
    with JsonTypeConverter<TipoDocumentoIdentidad, String> {
  const TipoDocumentoIdentidadConverter();

  @override
  TipoDocumentoIdentidad fromSql(String fromDb) =>
      TipoDocumentoIdentidad.desdeCodigo(fromDb);

  @override
  String toSql(TipoDocumentoIdentidad value) => value.codigo;
}

class TipoAfectacionIgvConverter extends TypeConverter<TipoAfectacionIgv, String>
    with JsonTypeConverter<TipoAfectacionIgv, String> {
  const TipoAfectacionIgvConverter();

  @override
  TipoAfectacionIgv fromSql(String fromDb) => TipoAfectacionIgv.desdeCodigo(fromDb);

  @override
  String toSql(TipoAfectacionIgv value) => value.codigo;
}

class MonedaConverter extends TypeConverter<Moneda, String>
    with JsonTypeConverter<Moneda, String> {
  const MonedaConverter();

  @override
  Moneda fromSql(String fromDb) => Moneda.desdeCodigo(fromDb);

  @override
  String toSql(Moneda value) => value.codigo;
}

class UnidadMedidaConverter extends TypeConverter<UnidadMedida, String>
    with JsonTypeConverter<UnidadMedida, String> {
  const UnidadMedidaConverter();

  @override
  UnidadMedida fromSql(String fromDb) => UnidadMedida.desdeCodigo(fromDb);

  @override
  String toSql(UnidadMedida value) => value.codigo;
}

class FormaPagoConverter extends TypeConverter<FormaPago, String>
    with JsonTypeConverter<FormaPago, String> {
  const FormaPagoConverter();

  @override
  FormaPago fromSql(String fromDb) => FormaPago.desdeCodigo(fromDb);

  @override
  String toSql(FormaPago value) => value.codigo;
}

/// El estado no pertenece a ningún catálogo SUNAT, así que se guarda por
/// nombre, que es igual de estable y mucho más legible al inspeccionar la base.
class EstadoSunatConverter extends TypeConverter<EstadoSunat, String>
    with JsonTypeConverter<EstadoSunat, String> {
  const EstadoSunatConverter();

  @override
  EstadoSunat fromSql(String fromDb) => EstadoSunat.desdeNombre(fromDb);

  @override
  String toSql(EstadoSunat value) => value.name;
}

class MotivoNotaCreditoConverter extends TypeConverter<MotivoNotaCredito, String>
    with JsonTypeConverter<MotivoNotaCredito, String> {
  const MotivoNotaCreditoConverter();

  @override
  MotivoNotaCredito fromSql(String fromDb) => MotivoNotaCredito.desdeCodigo(fromDb);

  @override
  String toSql(MotivoNotaCredito value) => value.codigo;
}

/// Guarda una lista de series (`['F001', 'F002']`) como texto JSON.
class ListaTextoConverter extends TypeConverter<List<String>, String>
    with JsonTypeConverter<List<String>, String> {
  const ListaTextoConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.trim().isEmpty) return const [];
    final decodificado = jsonDecode(fromDb);
    if (decodificado is! List) return const [];
    return decodificado.map((e) => e.toString()).toList(growable: false);
  }

  @override
  String toSql(List<String> value) => jsonEncode(value);
}
