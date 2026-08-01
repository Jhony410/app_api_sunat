// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comprobante.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Comprobante {

 int? get id; TipoComprobante get tipo; String get serie; int get correlativo; DateTime get fechaEmision; DateTime? get fechaVencimiento; Moneda get moneda; FormaPago get formaPago;/// Referencia a la agenda de clientes, si el receptor estaba guardado.
 int? get clienteId;/// Copia inmutable de los datos del receptor al momento de emitir.
 Cliente get cliente; List<ItemComprobante> get items; String? get observaciones; EstadoSunat get estadoSunat;/// Último mensaje devuelto por SUNAT o por Lycet (código + descripción).
 String? get mensajeSunat;/// XML UBL 2.1 firmado, tal como se envió.
 String? get xmlGenerado;/// Constancia de Recepción devuelta por SUNAT (XML del CDR).
 String? get cdrRecibido;/// Valor resumen del comprobante; alimenta el código QR del RIDE.
 String? get hashCodigo;/// Ticket de un envío asíncrono (resúmenes y comunicaciones de baja).
 String? get ticket;/// Motivo, sólo en notas de crédito y débito.
 MotivoNotaCredito? get motivoNota;/// Comprobante que modifica la nota, en formato `F001-00000123`.
 String? get documentoAfectado; TipoComprobante? get tipoDocumentoAfectado; DateTime? get creadoEn; DateTime? get actualizadoEn;
/// Create a copy of Comprobante
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComprobanteCopyWith<Comprobante> get copyWith => _$ComprobanteCopyWithImpl<Comprobante>(this as Comprobante, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Comprobante&&(identical(other.id, id) || other.id == id)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.serie, serie) || other.serie == serie)&&(identical(other.correlativo, correlativo) || other.correlativo == correlativo)&&(identical(other.fechaEmision, fechaEmision) || other.fechaEmision == fechaEmision)&&(identical(other.fechaVencimiento, fechaVencimiento) || other.fechaVencimiento == fechaVencimiento)&&(identical(other.moneda, moneda) || other.moneda == moneda)&&(identical(other.formaPago, formaPago) || other.formaPago == formaPago)&&(identical(other.clienteId, clienteId) || other.clienteId == clienteId)&&(identical(other.cliente, cliente) || other.cliente == cliente)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.observaciones, observaciones) || other.observaciones == observaciones)&&(identical(other.estadoSunat, estadoSunat) || other.estadoSunat == estadoSunat)&&(identical(other.mensajeSunat, mensajeSunat) || other.mensajeSunat == mensajeSunat)&&(identical(other.xmlGenerado, xmlGenerado) || other.xmlGenerado == xmlGenerado)&&(identical(other.cdrRecibido, cdrRecibido) || other.cdrRecibido == cdrRecibido)&&(identical(other.hashCodigo, hashCodigo) || other.hashCodigo == hashCodigo)&&(identical(other.ticket, ticket) || other.ticket == ticket)&&(identical(other.motivoNota, motivoNota) || other.motivoNota == motivoNota)&&(identical(other.documentoAfectado, documentoAfectado) || other.documentoAfectado == documentoAfectado)&&(identical(other.tipoDocumentoAfectado, tipoDocumentoAfectado) || other.tipoDocumentoAfectado == tipoDocumentoAfectado)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn)&&(identical(other.actualizadoEn, actualizadoEn) || other.actualizadoEn == actualizadoEn));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,tipo,serie,correlativo,fechaEmision,fechaVencimiento,moneda,formaPago,clienteId,cliente,const DeepCollectionEquality().hash(items),observaciones,estadoSunat,mensajeSunat,xmlGenerado,cdrRecibido,hashCodigo,ticket,motivoNota,documentoAfectado,tipoDocumentoAfectado,creadoEn,actualizadoEn]);

@override
String toString() {
  return 'Comprobante(id: $id, tipo: $tipo, serie: $serie, correlativo: $correlativo, fechaEmision: $fechaEmision, fechaVencimiento: $fechaVencimiento, moneda: $moneda, formaPago: $formaPago, clienteId: $clienteId, cliente: $cliente, items: $items, observaciones: $observaciones, estadoSunat: $estadoSunat, mensajeSunat: $mensajeSunat, xmlGenerado: $xmlGenerado, cdrRecibido: $cdrRecibido, hashCodigo: $hashCodigo, ticket: $ticket, motivoNota: $motivoNota, documentoAfectado: $documentoAfectado, tipoDocumentoAfectado: $tipoDocumentoAfectado, creadoEn: $creadoEn, actualizadoEn: $actualizadoEn)';
}


}

/// @nodoc
abstract mixin class $ComprobanteCopyWith<$Res>  {
  factory $ComprobanteCopyWith(Comprobante value, $Res Function(Comprobante) _then) = _$ComprobanteCopyWithImpl;
@useResult
$Res call({
 int? id, TipoComprobante tipo, String serie, int correlativo, DateTime fechaEmision, DateTime? fechaVencimiento, Moneda moneda, FormaPago formaPago, int? clienteId, Cliente cliente, List<ItemComprobante> items, String? observaciones, EstadoSunat estadoSunat, String? mensajeSunat, String? xmlGenerado, String? cdrRecibido, String? hashCodigo, String? ticket, MotivoNotaCredito? motivoNota, String? documentoAfectado, TipoComprobante? tipoDocumentoAfectado, DateTime? creadoEn, DateTime? actualizadoEn
});


$ClienteCopyWith<$Res> get cliente;

}
/// @nodoc
class _$ComprobanteCopyWithImpl<$Res>
    implements $ComprobanteCopyWith<$Res> {
  _$ComprobanteCopyWithImpl(this._self, this._then);

  final Comprobante _self;
  final $Res Function(Comprobante) _then;

/// Create a copy of Comprobante
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tipo = null,Object? serie = null,Object? correlativo = null,Object? fechaEmision = null,Object? fechaVencimiento = freezed,Object? moneda = null,Object? formaPago = null,Object? clienteId = freezed,Object? cliente = null,Object? items = null,Object? observaciones = freezed,Object? estadoSunat = null,Object? mensajeSunat = freezed,Object? xmlGenerado = freezed,Object? cdrRecibido = freezed,Object? hashCodigo = freezed,Object? ticket = freezed,Object? motivoNota = freezed,Object? documentoAfectado = freezed,Object? tipoDocumentoAfectado = freezed,Object? creadoEn = freezed,Object? actualizadoEn = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as TipoComprobante,serie: null == serie ? _self.serie : serie // ignore: cast_nullable_to_non_nullable
as String,correlativo: null == correlativo ? _self.correlativo : correlativo // ignore: cast_nullable_to_non_nullable
as int,fechaEmision: null == fechaEmision ? _self.fechaEmision : fechaEmision // ignore: cast_nullable_to_non_nullable
as DateTime,fechaVencimiento: freezed == fechaVencimiento ? _self.fechaVencimiento : fechaVencimiento // ignore: cast_nullable_to_non_nullable
as DateTime?,moneda: null == moneda ? _self.moneda : moneda // ignore: cast_nullable_to_non_nullable
as Moneda,formaPago: null == formaPago ? _self.formaPago : formaPago // ignore: cast_nullable_to_non_nullable
as FormaPago,clienteId: freezed == clienteId ? _self.clienteId : clienteId // ignore: cast_nullable_to_non_nullable
as int?,cliente: null == cliente ? _self.cliente : cliente // ignore: cast_nullable_to_non_nullable
as Cliente,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ItemComprobante>,observaciones: freezed == observaciones ? _self.observaciones : observaciones // ignore: cast_nullable_to_non_nullable
as String?,estadoSunat: null == estadoSunat ? _self.estadoSunat : estadoSunat // ignore: cast_nullable_to_non_nullable
as EstadoSunat,mensajeSunat: freezed == mensajeSunat ? _self.mensajeSunat : mensajeSunat // ignore: cast_nullable_to_non_nullable
as String?,xmlGenerado: freezed == xmlGenerado ? _self.xmlGenerado : xmlGenerado // ignore: cast_nullable_to_non_nullable
as String?,cdrRecibido: freezed == cdrRecibido ? _self.cdrRecibido : cdrRecibido // ignore: cast_nullable_to_non_nullable
as String?,hashCodigo: freezed == hashCodigo ? _self.hashCodigo : hashCodigo // ignore: cast_nullable_to_non_nullable
as String?,ticket: freezed == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as String?,motivoNota: freezed == motivoNota ? _self.motivoNota : motivoNota // ignore: cast_nullable_to_non_nullable
as MotivoNotaCredito?,documentoAfectado: freezed == documentoAfectado ? _self.documentoAfectado : documentoAfectado // ignore: cast_nullable_to_non_nullable
as String?,tipoDocumentoAfectado: freezed == tipoDocumentoAfectado ? _self.tipoDocumentoAfectado : tipoDocumentoAfectado // ignore: cast_nullable_to_non_nullable
as TipoComprobante?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,actualizadoEn: freezed == actualizadoEn ? _self.actualizadoEn : actualizadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Comprobante
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClienteCopyWith<$Res> get cliente {
  
  return $ClienteCopyWith<$Res>(_self.cliente, (value) {
    return _then(_self.copyWith(cliente: value));
  });
}
}


/// Adds pattern-matching-related methods to [Comprobante].
extension ComprobantePatterns on Comprobante {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Comprobante value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Comprobante() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Comprobante value)  $default,){
final _that = this;
switch (_that) {
case _Comprobante():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Comprobante value)?  $default,){
final _that = this;
switch (_that) {
case _Comprobante() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  TipoComprobante tipo,  String serie,  int correlativo,  DateTime fechaEmision,  DateTime? fechaVencimiento,  Moneda moneda,  FormaPago formaPago,  int? clienteId,  Cliente cliente,  List<ItemComprobante> items,  String? observaciones,  EstadoSunat estadoSunat,  String? mensajeSunat,  String? xmlGenerado,  String? cdrRecibido,  String? hashCodigo,  String? ticket,  MotivoNotaCredito? motivoNota,  String? documentoAfectado,  TipoComprobante? tipoDocumentoAfectado,  DateTime? creadoEn,  DateTime? actualizadoEn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Comprobante() when $default != null:
return $default(_that.id,_that.tipo,_that.serie,_that.correlativo,_that.fechaEmision,_that.fechaVencimiento,_that.moneda,_that.formaPago,_that.clienteId,_that.cliente,_that.items,_that.observaciones,_that.estadoSunat,_that.mensajeSunat,_that.xmlGenerado,_that.cdrRecibido,_that.hashCodigo,_that.ticket,_that.motivoNota,_that.documentoAfectado,_that.tipoDocumentoAfectado,_that.creadoEn,_that.actualizadoEn);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  TipoComprobante tipo,  String serie,  int correlativo,  DateTime fechaEmision,  DateTime? fechaVencimiento,  Moneda moneda,  FormaPago formaPago,  int? clienteId,  Cliente cliente,  List<ItemComprobante> items,  String? observaciones,  EstadoSunat estadoSunat,  String? mensajeSunat,  String? xmlGenerado,  String? cdrRecibido,  String? hashCodigo,  String? ticket,  MotivoNotaCredito? motivoNota,  String? documentoAfectado,  TipoComprobante? tipoDocumentoAfectado,  DateTime? creadoEn,  DateTime? actualizadoEn)  $default,) {final _that = this;
switch (_that) {
case _Comprobante():
return $default(_that.id,_that.tipo,_that.serie,_that.correlativo,_that.fechaEmision,_that.fechaVencimiento,_that.moneda,_that.formaPago,_that.clienteId,_that.cliente,_that.items,_that.observaciones,_that.estadoSunat,_that.mensajeSunat,_that.xmlGenerado,_that.cdrRecibido,_that.hashCodigo,_that.ticket,_that.motivoNota,_that.documentoAfectado,_that.tipoDocumentoAfectado,_that.creadoEn,_that.actualizadoEn);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  TipoComprobante tipo,  String serie,  int correlativo,  DateTime fechaEmision,  DateTime? fechaVencimiento,  Moneda moneda,  FormaPago formaPago,  int? clienteId,  Cliente cliente,  List<ItemComprobante> items,  String? observaciones,  EstadoSunat estadoSunat,  String? mensajeSunat,  String? xmlGenerado,  String? cdrRecibido,  String? hashCodigo,  String? ticket,  MotivoNotaCredito? motivoNota,  String? documentoAfectado,  TipoComprobante? tipoDocumentoAfectado,  DateTime? creadoEn,  DateTime? actualizadoEn)?  $default,) {final _that = this;
switch (_that) {
case _Comprobante() when $default != null:
return $default(_that.id,_that.tipo,_that.serie,_that.correlativo,_that.fechaEmision,_that.fechaVencimiento,_that.moneda,_that.formaPago,_that.clienteId,_that.cliente,_that.items,_that.observaciones,_that.estadoSunat,_that.mensajeSunat,_that.xmlGenerado,_that.cdrRecibido,_that.hashCodigo,_that.ticket,_that.motivoNota,_that.documentoAfectado,_that.tipoDocumentoAfectado,_that.creadoEn,_that.actualizadoEn);case _:
  return null;

}
}

}

/// @nodoc


class _Comprobante extends Comprobante {
  const _Comprobante({this.id, this.tipo = TipoComprobante.factura, required this.serie, required this.correlativo, required this.fechaEmision, this.fechaVencimiento, this.moneda = Moneda.soles, this.formaPago = FormaPago.contado, this.clienteId, required this.cliente, final  List<ItemComprobante> items = const <ItemComprobante>[], this.observaciones, this.estadoSunat = EstadoSunat.simulado, this.mensajeSunat, this.xmlGenerado, this.cdrRecibido, this.hashCodigo, this.ticket, this.motivoNota, this.documentoAfectado, this.tipoDocumentoAfectado, this.creadoEn, this.actualizadoEn}): _items = items,super._();
  

@override final  int? id;
@override@JsonKey() final  TipoComprobante tipo;
@override final  String serie;
@override final  int correlativo;
@override final  DateTime fechaEmision;
@override final  DateTime? fechaVencimiento;
@override@JsonKey() final  Moneda moneda;
@override@JsonKey() final  FormaPago formaPago;
/// Referencia a la agenda de clientes, si el receptor estaba guardado.
@override final  int? clienteId;
/// Copia inmutable de los datos del receptor al momento de emitir.
@override final  Cliente cliente;
 final  List<ItemComprobante> _items;
@override@JsonKey() List<ItemComprobante> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? observaciones;
@override@JsonKey() final  EstadoSunat estadoSunat;
/// Último mensaje devuelto por SUNAT o por Lycet (código + descripción).
@override final  String? mensajeSunat;
/// XML UBL 2.1 firmado, tal como se envió.
@override final  String? xmlGenerado;
/// Constancia de Recepción devuelta por SUNAT (XML del CDR).
@override final  String? cdrRecibido;
/// Valor resumen del comprobante; alimenta el código QR del RIDE.
@override final  String? hashCodigo;
/// Ticket de un envío asíncrono (resúmenes y comunicaciones de baja).
@override final  String? ticket;
/// Motivo, sólo en notas de crédito y débito.
@override final  MotivoNotaCredito? motivoNota;
/// Comprobante que modifica la nota, en formato `F001-00000123`.
@override final  String? documentoAfectado;
@override final  TipoComprobante? tipoDocumentoAfectado;
@override final  DateTime? creadoEn;
@override final  DateTime? actualizadoEn;

/// Create a copy of Comprobante
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComprobanteCopyWith<_Comprobante> get copyWith => __$ComprobanteCopyWithImpl<_Comprobante>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Comprobante&&(identical(other.id, id) || other.id == id)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.serie, serie) || other.serie == serie)&&(identical(other.correlativo, correlativo) || other.correlativo == correlativo)&&(identical(other.fechaEmision, fechaEmision) || other.fechaEmision == fechaEmision)&&(identical(other.fechaVencimiento, fechaVencimiento) || other.fechaVencimiento == fechaVencimiento)&&(identical(other.moneda, moneda) || other.moneda == moneda)&&(identical(other.formaPago, formaPago) || other.formaPago == formaPago)&&(identical(other.clienteId, clienteId) || other.clienteId == clienteId)&&(identical(other.cliente, cliente) || other.cliente == cliente)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.observaciones, observaciones) || other.observaciones == observaciones)&&(identical(other.estadoSunat, estadoSunat) || other.estadoSunat == estadoSunat)&&(identical(other.mensajeSunat, mensajeSunat) || other.mensajeSunat == mensajeSunat)&&(identical(other.xmlGenerado, xmlGenerado) || other.xmlGenerado == xmlGenerado)&&(identical(other.cdrRecibido, cdrRecibido) || other.cdrRecibido == cdrRecibido)&&(identical(other.hashCodigo, hashCodigo) || other.hashCodigo == hashCodigo)&&(identical(other.ticket, ticket) || other.ticket == ticket)&&(identical(other.motivoNota, motivoNota) || other.motivoNota == motivoNota)&&(identical(other.documentoAfectado, documentoAfectado) || other.documentoAfectado == documentoAfectado)&&(identical(other.tipoDocumentoAfectado, tipoDocumentoAfectado) || other.tipoDocumentoAfectado == tipoDocumentoAfectado)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn)&&(identical(other.actualizadoEn, actualizadoEn) || other.actualizadoEn == actualizadoEn));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,tipo,serie,correlativo,fechaEmision,fechaVencimiento,moneda,formaPago,clienteId,cliente,const DeepCollectionEquality().hash(_items),observaciones,estadoSunat,mensajeSunat,xmlGenerado,cdrRecibido,hashCodigo,ticket,motivoNota,documentoAfectado,tipoDocumentoAfectado,creadoEn,actualizadoEn]);

@override
String toString() {
  return 'Comprobante(id: $id, tipo: $tipo, serie: $serie, correlativo: $correlativo, fechaEmision: $fechaEmision, fechaVencimiento: $fechaVencimiento, moneda: $moneda, formaPago: $formaPago, clienteId: $clienteId, cliente: $cliente, items: $items, observaciones: $observaciones, estadoSunat: $estadoSunat, mensajeSunat: $mensajeSunat, xmlGenerado: $xmlGenerado, cdrRecibido: $cdrRecibido, hashCodigo: $hashCodigo, ticket: $ticket, motivoNota: $motivoNota, documentoAfectado: $documentoAfectado, tipoDocumentoAfectado: $tipoDocumentoAfectado, creadoEn: $creadoEn, actualizadoEn: $actualizadoEn)';
}


}

/// @nodoc
abstract mixin class _$ComprobanteCopyWith<$Res> implements $ComprobanteCopyWith<$Res> {
  factory _$ComprobanteCopyWith(_Comprobante value, $Res Function(_Comprobante) _then) = __$ComprobanteCopyWithImpl;
@override @useResult
$Res call({
 int? id, TipoComprobante tipo, String serie, int correlativo, DateTime fechaEmision, DateTime? fechaVencimiento, Moneda moneda, FormaPago formaPago, int? clienteId, Cliente cliente, List<ItemComprobante> items, String? observaciones, EstadoSunat estadoSunat, String? mensajeSunat, String? xmlGenerado, String? cdrRecibido, String? hashCodigo, String? ticket, MotivoNotaCredito? motivoNota, String? documentoAfectado, TipoComprobante? tipoDocumentoAfectado, DateTime? creadoEn, DateTime? actualizadoEn
});


@override $ClienteCopyWith<$Res> get cliente;

}
/// @nodoc
class __$ComprobanteCopyWithImpl<$Res>
    implements _$ComprobanteCopyWith<$Res> {
  __$ComprobanteCopyWithImpl(this._self, this._then);

  final _Comprobante _self;
  final $Res Function(_Comprobante) _then;

/// Create a copy of Comprobante
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tipo = null,Object? serie = null,Object? correlativo = null,Object? fechaEmision = null,Object? fechaVencimiento = freezed,Object? moneda = null,Object? formaPago = null,Object? clienteId = freezed,Object? cliente = null,Object? items = null,Object? observaciones = freezed,Object? estadoSunat = null,Object? mensajeSunat = freezed,Object? xmlGenerado = freezed,Object? cdrRecibido = freezed,Object? hashCodigo = freezed,Object? ticket = freezed,Object? motivoNota = freezed,Object? documentoAfectado = freezed,Object? tipoDocumentoAfectado = freezed,Object? creadoEn = freezed,Object? actualizadoEn = freezed,}) {
  return _then(_Comprobante(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as TipoComprobante,serie: null == serie ? _self.serie : serie // ignore: cast_nullable_to_non_nullable
as String,correlativo: null == correlativo ? _self.correlativo : correlativo // ignore: cast_nullable_to_non_nullable
as int,fechaEmision: null == fechaEmision ? _self.fechaEmision : fechaEmision // ignore: cast_nullable_to_non_nullable
as DateTime,fechaVencimiento: freezed == fechaVencimiento ? _self.fechaVencimiento : fechaVencimiento // ignore: cast_nullable_to_non_nullable
as DateTime?,moneda: null == moneda ? _self.moneda : moneda // ignore: cast_nullable_to_non_nullable
as Moneda,formaPago: null == formaPago ? _self.formaPago : formaPago // ignore: cast_nullable_to_non_nullable
as FormaPago,clienteId: freezed == clienteId ? _self.clienteId : clienteId // ignore: cast_nullable_to_non_nullable
as int?,cliente: null == cliente ? _self.cliente : cliente // ignore: cast_nullable_to_non_nullable
as Cliente,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ItemComprobante>,observaciones: freezed == observaciones ? _self.observaciones : observaciones // ignore: cast_nullable_to_non_nullable
as String?,estadoSunat: null == estadoSunat ? _self.estadoSunat : estadoSunat // ignore: cast_nullable_to_non_nullable
as EstadoSunat,mensajeSunat: freezed == mensajeSunat ? _self.mensajeSunat : mensajeSunat // ignore: cast_nullable_to_non_nullable
as String?,xmlGenerado: freezed == xmlGenerado ? _self.xmlGenerado : xmlGenerado // ignore: cast_nullable_to_non_nullable
as String?,cdrRecibido: freezed == cdrRecibido ? _self.cdrRecibido : cdrRecibido // ignore: cast_nullable_to_non_nullable
as String?,hashCodigo: freezed == hashCodigo ? _self.hashCodigo : hashCodigo // ignore: cast_nullable_to_non_nullable
as String?,ticket: freezed == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as String?,motivoNota: freezed == motivoNota ? _self.motivoNota : motivoNota // ignore: cast_nullable_to_non_nullable
as MotivoNotaCredito?,documentoAfectado: freezed == documentoAfectado ? _self.documentoAfectado : documentoAfectado // ignore: cast_nullable_to_non_nullable
as String?,tipoDocumentoAfectado: freezed == tipoDocumentoAfectado ? _self.tipoDocumentoAfectado : tipoDocumentoAfectado // ignore: cast_nullable_to_non_nullable
as TipoComprobante?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,actualizadoEn: freezed == actualizadoEn ? _self.actualizadoEn : actualizadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Comprobante
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClienteCopyWith<$Res> get cliente {
  
  return $ClienteCopyWith<$Res>(_self.cliente, (value) {
    return _then(_self.copyWith(cliente: value));
  });
}
}

// dart format on
