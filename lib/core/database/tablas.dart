import 'package:drift/drift.dart';

import 'convertidores.dart';

/// Esquema relacional de la app.
///
/// La cabecera del comprobante y sus ítems viven en tablas separadas con
/// integridad referencial; los totales **no** se guardan porque se derivan
/// siempre de los ítems (ver `CalculadoraTotales`).

/// Datos del emisor. Tiene una sola fila, con `id = 1`.
@DataClassName('EmpresaRow')
class EmpresasTabla extends Table {
  @override
  String get tableName => 'empresas';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get ruc => text().withLength(min: 11, max: 11)();
  TextColumn get razonSocial => text()();
  TextColumn get nombreComercial => text().withDefault(const Constant(''))();
  TextColumn get ubigeo => text().withDefault(const Constant(''))();
  TextColumn get departamento => text().withDefault(const Constant(''))();
  TextColumn get provincia => text().withDefault(const Constant(''))();
  TextColumn get distrito => text().withDefault(const Constant(''))();
  TextColumn get direccion => text().withDefault(const Constant(''))();
  TextColumn get logoPath => text().nullable()();
  TextColumn get seriesFactura =>
      text().map(const ListaTextoConverter()).withDefault(const Constant('["F001"]'))();
  TextColumn get seriesBoleta =>
      text().map(const ListaTextoConverter()).withDefault(const Constant('["B001"]'))();
}

/// Agenda de clientes frecuentes.
@DataClassName('ClienteRow')
class ClientesTabla extends Table {
  @override
  String get tableName => 'clientes';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get tipoDocumento => text().map(const TipoDocumentoIdentidadConverter())();
  TextColumn get numeroDocumento => text()();
  TextColumn get razonSocialONombres => text()();
  TextColumn get direccion => text().nullable()();
  TextColumn get telefono => text().nullable()();
  TextColumn get email => text().nullable()();
  DateTimeColumn get creadoEn => dateTime().withDefault(currentDateAndTime)();

  /// No tiene sentido tener dos fichas con el mismo documento.
  @override
  List<Set<Column>> get uniqueKeys => [
        {tipoDocumento, numeroDocumento},
      ];
}

/// Cabecera del comprobante.
///
/// Los datos del receptor se copian aquí (`cliente*`) además de guardar el
/// `clienteId`: un comprobante emitido es un documento histórico y no debe
/// cambiar si luego se corrige la ficha del cliente.
@DataClassName('ComprobanteRow')
class ComprobantesTabla extends Table {
  @override
  String get tableName => 'comprobantes';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get tipo => text().map(const TipoComprobanteConverter())();
  TextColumn get serie => text().withLength(min: 4, max: 4)();
  IntColumn get correlativo => integer()();
  DateTimeColumn get fechaEmision => dateTime()();
  DateTimeColumn get fechaVencimiento => dateTime().nullable()();
  TextColumn get moneda => text().map(const MonedaConverter())();
  TextColumn get formaPago => text().map(const FormaPagoConverter())();

  IntColumn get clienteId =>
      integer().nullable().references(ClientesTabla, #id, onDelete: KeyAction.setNull)();
  TextColumn get clienteTipoDocumento =>
      text().map(const TipoDocumentoIdentidadConverter())();
  TextColumn get clienteNumeroDocumento => text()();
  TextColumn get clienteRazonSocial => text()();
  TextColumn get clienteDireccion => text().nullable()();
  TextColumn get clienteTelefono => text().nullable()();
  TextColumn get clienteEmail => text().nullable()();

  TextColumn get observaciones => text().nullable()();
  TextColumn get estadoSunat => text().map(const EstadoSunatConverter())();
  TextColumn get mensajeSunat => text().nullable()();
  TextColumn get xmlGenerado => text().nullable()();
  TextColumn get cdrRecibido => text().nullable()();
  TextColumn get hashCodigo => text().nullable()();
  TextColumn get ticket => text().nullable()();

  TextColumn get motivoNota => text().map(const MotivoNotaCreditoConverter()).nullable()();
  TextColumn get documentoAfectado => text().nullable()();
  TextColumn get tipoDocumentoAfectado =>
      text().map(const TipoComprobanteConverter()).nullable()();

  /// Importe total denormalizado. Existe sólo para poder filtrar y sumar en SQL
  /// sin cargar los ítems; la verdad sigue siendo el cálculo sobre los ítems.
  RealColumn get importeTotal => real().withDefault(const Constant(0))();

  DateTimeColumn get creadoEn => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get actualizadoEn => dateTime().withDefault(currentDateAndTime)();

  /// Serie + correlativo identifican unívocamente un comprobante del emisor.
  @override
  List<Set<Column>> get uniqueKeys => [
        {serie, correlativo},
      ];
}

/// Líneas del comprobante.
@DataClassName('ItemComprobanteRow')
class ItemsComprobanteTabla extends Table {
  @override
  String get tableName => 'items_comprobante';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get comprobanteId =>
      integer().references(ComprobantesTabla, #id, onDelete: KeyAction.cascade)();
  IntColumn get orden => integer()();
  TextColumn get codigo => text().withDefault(const Constant(''))();
  TextColumn get descripcion => text()();
  TextColumn get unidadMedida => text().map(const UnidadMedidaConverter())();
  RealColumn get cantidad => real()();
  RealColumn get valorUnitario => real()();
  TextColumn get tipoAfectacionIgv => text().map(const TipoAfectacionIgvConverter())();
  RealColumn get descuento => real().withDefault(const Constant(0))();
}

/// Último correlativo emitido por serie.
///
/// Se lleva aparte de la tabla de comprobantes para poder reservar el número
/// dentro de la misma transacción en que se guarda el documento, y así no
/// repetir ni saltar correlativos aunque se emita desde varias pantallas.
@DataClassName('CorrelativoRow')
class CorrelativosTabla extends Table {
  @override
  String get tableName => 'correlativos';

  TextColumn get serie => text().withLength(min: 4, max: 4)();
  TextColumn get tipo => text().map(const TipoComprobanteConverter())();
  IntColumn get ultimoCorrelativo => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {serie};
}

/// Preferencias y configuración de la app en formato clave/valor.
///
/// Aquí viven la URL y el token de Lycet, el modo de operación
/// (simulación/real) y el tema elegido.
@DataClassName('AjusteRow')
class AjustesTabla extends Table {
  @override
  String get tableName => 'ajustes';

  TextColumn get clave => text()();
  TextColumn get valor => text()();

  @override
  Set<Column> get primaryKey => {clave};
}

/// Claves conocidas de la tabla de ajustes.
abstract final class ClavesAjuste {
  static const modoOperacion = 'modo_operacion';
  static const lycetUrl = 'lycet_url';
  static const lycetToken = 'lycet_token';
  static const temaApp = 'tema_app';
  static const proveedorConsulta = 'proveedor_consulta';
  static const tokenConsulta = 'token_consulta';
}

/// Modo en que la app emite los comprobantes.
enum ModoOperacion {
  /// Todo local: el comprobante se guarda y se imprime, pero no viaja a SUNAT.
  simulacion('Simulación'),

  /// Se envía al ambiente BETA de SUNAT a través de Lycet.
  real('Emisión real (BETA)');

  const ModoOperacion(this.etiqueta);

  final String etiqueta;

  static ModoOperacion desdeNombre(String? nombre) => ModoOperacion.values.firstWhere(
        (m) => m.name == nombre,
        orElse: () => ModoOperacion.simulacion,
      );
}
