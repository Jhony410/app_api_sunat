// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resumen_comprobante.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResumenComprobante {

 int get id; TipoComprobante get tipo; String get serie; int get correlativo; DateTime get fechaEmision; Moneda get moneda; String get clienteRazonSocial; String get clienteDocumento; EstadoSunat get estadoSunat; double get importeTotal;
/// Create a copy of ResumenComprobante
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumenComprobanteCopyWith<ResumenComprobante> get copyWith => _$ResumenComprobanteCopyWithImpl<ResumenComprobante>(this as ResumenComprobante, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumenComprobante&&(identical(other.id, id) || other.id == id)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.serie, serie) || other.serie == serie)&&(identical(other.correlativo, correlativo) || other.correlativo == correlativo)&&(identical(other.fechaEmision, fechaEmision) || other.fechaEmision == fechaEmision)&&(identical(other.moneda, moneda) || other.moneda == moneda)&&(identical(other.clienteRazonSocial, clienteRazonSocial) || other.clienteRazonSocial == clienteRazonSocial)&&(identical(other.clienteDocumento, clienteDocumento) || other.clienteDocumento == clienteDocumento)&&(identical(other.estadoSunat, estadoSunat) || other.estadoSunat == estadoSunat)&&(identical(other.importeTotal, importeTotal) || other.importeTotal == importeTotal));
}


@override
int get hashCode => Object.hash(runtimeType,id,tipo,serie,correlativo,fechaEmision,moneda,clienteRazonSocial,clienteDocumento,estadoSunat,importeTotal);

@override
String toString() {
  return 'ResumenComprobante(id: $id, tipo: $tipo, serie: $serie, correlativo: $correlativo, fechaEmision: $fechaEmision, moneda: $moneda, clienteRazonSocial: $clienteRazonSocial, clienteDocumento: $clienteDocumento, estadoSunat: $estadoSunat, importeTotal: $importeTotal)';
}


}

/// @nodoc
abstract mixin class $ResumenComprobanteCopyWith<$Res>  {
  factory $ResumenComprobanteCopyWith(ResumenComprobante value, $Res Function(ResumenComprobante) _then) = _$ResumenComprobanteCopyWithImpl;
@useResult
$Res call({
 int id, TipoComprobante tipo, String serie, int correlativo, DateTime fechaEmision, Moneda moneda, String clienteRazonSocial, String clienteDocumento, EstadoSunat estadoSunat, double importeTotal
});




}
/// @nodoc
class _$ResumenComprobanteCopyWithImpl<$Res>
    implements $ResumenComprobanteCopyWith<$Res> {
  _$ResumenComprobanteCopyWithImpl(this._self, this._then);

  final ResumenComprobante _self;
  final $Res Function(ResumenComprobante) _then;

/// Create a copy of ResumenComprobante
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tipo = null,Object? serie = null,Object? correlativo = null,Object? fechaEmision = null,Object? moneda = null,Object? clienteRazonSocial = null,Object? clienteDocumento = null,Object? estadoSunat = null,Object? importeTotal = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as TipoComprobante,serie: null == serie ? _self.serie : serie // ignore: cast_nullable_to_non_nullable
as String,correlativo: null == correlativo ? _self.correlativo : correlativo // ignore: cast_nullable_to_non_nullable
as int,fechaEmision: null == fechaEmision ? _self.fechaEmision : fechaEmision // ignore: cast_nullable_to_non_nullable
as DateTime,moneda: null == moneda ? _self.moneda : moneda // ignore: cast_nullable_to_non_nullable
as Moneda,clienteRazonSocial: null == clienteRazonSocial ? _self.clienteRazonSocial : clienteRazonSocial // ignore: cast_nullable_to_non_nullable
as String,clienteDocumento: null == clienteDocumento ? _self.clienteDocumento : clienteDocumento // ignore: cast_nullable_to_non_nullable
as String,estadoSunat: null == estadoSunat ? _self.estadoSunat : estadoSunat // ignore: cast_nullable_to_non_nullable
as EstadoSunat,importeTotal: null == importeTotal ? _self.importeTotal : importeTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ResumenComprobante].
extension ResumenComprobantePatterns on ResumenComprobante {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumenComprobante value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumenComprobante() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumenComprobante value)  $default,){
final _that = this;
switch (_that) {
case _ResumenComprobante():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumenComprobante value)?  $default,){
final _that = this;
switch (_that) {
case _ResumenComprobante() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  TipoComprobante tipo,  String serie,  int correlativo,  DateTime fechaEmision,  Moneda moneda,  String clienteRazonSocial,  String clienteDocumento,  EstadoSunat estadoSunat,  double importeTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumenComprobante() when $default != null:
return $default(_that.id,_that.tipo,_that.serie,_that.correlativo,_that.fechaEmision,_that.moneda,_that.clienteRazonSocial,_that.clienteDocumento,_that.estadoSunat,_that.importeTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  TipoComprobante tipo,  String serie,  int correlativo,  DateTime fechaEmision,  Moneda moneda,  String clienteRazonSocial,  String clienteDocumento,  EstadoSunat estadoSunat,  double importeTotal)  $default,) {final _that = this;
switch (_that) {
case _ResumenComprobante():
return $default(_that.id,_that.tipo,_that.serie,_that.correlativo,_that.fechaEmision,_that.moneda,_that.clienteRazonSocial,_that.clienteDocumento,_that.estadoSunat,_that.importeTotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  TipoComprobante tipo,  String serie,  int correlativo,  DateTime fechaEmision,  Moneda moneda,  String clienteRazonSocial,  String clienteDocumento,  EstadoSunat estadoSunat,  double importeTotal)?  $default,) {final _that = this;
switch (_that) {
case _ResumenComprobante() when $default != null:
return $default(_that.id,_that.tipo,_that.serie,_that.correlativo,_that.fechaEmision,_that.moneda,_that.clienteRazonSocial,_that.clienteDocumento,_that.estadoSunat,_that.importeTotal);case _:
  return null;

}
}

}

/// @nodoc


class _ResumenComprobante extends ResumenComprobante {
  const _ResumenComprobante({required this.id, required this.tipo, required this.serie, required this.correlativo, required this.fechaEmision, required this.moneda, required this.clienteRazonSocial, required this.clienteDocumento, required this.estadoSunat, required this.importeTotal}): super._();
  

@override final  int id;
@override final  TipoComprobante tipo;
@override final  String serie;
@override final  int correlativo;
@override final  DateTime fechaEmision;
@override final  Moneda moneda;
@override final  String clienteRazonSocial;
@override final  String clienteDocumento;
@override final  EstadoSunat estadoSunat;
@override final  double importeTotal;

/// Create a copy of ResumenComprobante
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumenComprobanteCopyWith<_ResumenComprobante> get copyWith => __$ResumenComprobanteCopyWithImpl<_ResumenComprobante>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumenComprobante&&(identical(other.id, id) || other.id == id)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.serie, serie) || other.serie == serie)&&(identical(other.correlativo, correlativo) || other.correlativo == correlativo)&&(identical(other.fechaEmision, fechaEmision) || other.fechaEmision == fechaEmision)&&(identical(other.moneda, moneda) || other.moneda == moneda)&&(identical(other.clienteRazonSocial, clienteRazonSocial) || other.clienteRazonSocial == clienteRazonSocial)&&(identical(other.clienteDocumento, clienteDocumento) || other.clienteDocumento == clienteDocumento)&&(identical(other.estadoSunat, estadoSunat) || other.estadoSunat == estadoSunat)&&(identical(other.importeTotal, importeTotal) || other.importeTotal == importeTotal));
}


@override
int get hashCode => Object.hash(runtimeType,id,tipo,serie,correlativo,fechaEmision,moneda,clienteRazonSocial,clienteDocumento,estadoSunat,importeTotal);

@override
String toString() {
  return 'ResumenComprobante(id: $id, tipo: $tipo, serie: $serie, correlativo: $correlativo, fechaEmision: $fechaEmision, moneda: $moneda, clienteRazonSocial: $clienteRazonSocial, clienteDocumento: $clienteDocumento, estadoSunat: $estadoSunat, importeTotal: $importeTotal)';
}


}

/// @nodoc
abstract mixin class _$ResumenComprobanteCopyWith<$Res> implements $ResumenComprobanteCopyWith<$Res> {
  factory _$ResumenComprobanteCopyWith(_ResumenComprobante value, $Res Function(_ResumenComprobante) _then) = __$ResumenComprobanteCopyWithImpl;
@override @useResult
$Res call({
 int id, TipoComprobante tipo, String serie, int correlativo, DateTime fechaEmision, Moneda moneda, String clienteRazonSocial, String clienteDocumento, EstadoSunat estadoSunat, double importeTotal
});




}
/// @nodoc
class __$ResumenComprobanteCopyWithImpl<$Res>
    implements _$ResumenComprobanteCopyWith<$Res> {
  __$ResumenComprobanteCopyWithImpl(this._self, this._then);

  final _ResumenComprobante _self;
  final $Res Function(_ResumenComprobante) _then;

/// Create a copy of ResumenComprobante
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tipo = null,Object? serie = null,Object? correlativo = null,Object? fechaEmision = null,Object? moneda = null,Object? clienteRazonSocial = null,Object? clienteDocumento = null,Object? estadoSunat = null,Object? importeTotal = null,}) {
  return _then(_ResumenComprobante(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as TipoComprobante,serie: null == serie ? _self.serie : serie // ignore: cast_nullable_to_non_nullable
as String,correlativo: null == correlativo ? _self.correlativo : correlativo // ignore: cast_nullable_to_non_nullable
as int,fechaEmision: null == fechaEmision ? _self.fechaEmision : fechaEmision // ignore: cast_nullable_to_non_nullable
as DateTime,moneda: null == moneda ? _self.moneda : moneda // ignore: cast_nullable_to_non_nullable
as Moneda,clienteRazonSocial: null == clienteRazonSocial ? _self.clienteRazonSocial : clienteRazonSocial // ignore: cast_nullable_to_non_nullable
as String,clienteDocumento: null == clienteDocumento ? _self.clienteDocumento : clienteDocumento // ignore: cast_nullable_to_non_nullable
as String,estadoSunat: null == estadoSunat ? _self.estadoSunat : estadoSunat // ignore: cast_nullable_to_non_nullable
as EstadoSunat,importeTotal: null == importeTotal ? _self.importeTotal : importeTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$FiltroComprobantes {

/// Busca en serie-correlativo, razón social y documento del cliente.
 String get texto; TipoComprobante? get tipo; EstadoSunat? get estado; DateTime? get desde; DateTime? get hasta; int? get clienteId;
/// Create a copy of FiltroComprobantes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FiltroComprobantesCopyWith<FiltroComprobantes> get copyWith => _$FiltroComprobantesCopyWithImpl<FiltroComprobantes>(this as FiltroComprobantes, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FiltroComprobantes&&(identical(other.texto, texto) || other.texto == texto)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.estado, estado) || other.estado == estado)&&(identical(other.desde, desde) || other.desde == desde)&&(identical(other.hasta, hasta) || other.hasta == hasta)&&(identical(other.clienteId, clienteId) || other.clienteId == clienteId));
}


@override
int get hashCode => Object.hash(runtimeType,texto,tipo,estado,desde,hasta,clienteId);

@override
String toString() {
  return 'FiltroComprobantes(texto: $texto, tipo: $tipo, estado: $estado, desde: $desde, hasta: $hasta, clienteId: $clienteId)';
}


}

/// @nodoc
abstract mixin class $FiltroComprobantesCopyWith<$Res>  {
  factory $FiltroComprobantesCopyWith(FiltroComprobantes value, $Res Function(FiltroComprobantes) _then) = _$FiltroComprobantesCopyWithImpl;
@useResult
$Res call({
 String texto, TipoComprobante? tipo, EstadoSunat? estado, DateTime? desde, DateTime? hasta, int? clienteId
});




}
/// @nodoc
class _$FiltroComprobantesCopyWithImpl<$Res>
    implements $FiltroComprobantesCopyWith<$Res> {
  _$FiltroComprobantesCopyWithImpl(this._self, this._then);

  final FiltroComprobantes _self;
  final $Res Function(FiltroComprobantes) _then;

/// Create a copy of FiltroComprobantes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? texto = null,Object? tipo = freezed,Object? estado = freezed,Object? desde = freezed,Object? hasta = freezed,Object? clienteId = freezed,}) {
  return _then(_self.copyWith(
texto: null == texto ? _self.texto : texto // ignore: cast_nullable_to_non_nullable
as String,tipo: freezed == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as TipoComprobante?,estado: freezed == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as EstadoSunat?,desde: freezed == desde ? _self.desde : desde // ignore: cast_nullable_to_non_nullable
as DateTime?,hasta: freezed == hasta ? _self.hasta : hasta // ignore: cast_nullable_to_non_nullable
as DateTime?,clienteId: freezed == clienteId ? _self.clienteId : clienteId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [FiltroComprobantes].
extension FiltroComprobantesPatterns on FiltroComprobantes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FiltroComprobantes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FiltroComprobantes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FiltroComprobantes value)  $default,){
final _that = this;
switch (_that) {
case _FiltroComprobantes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FiltroComprobantes value)?  $default,){
final _that = this;
switch (_that) {
case _FiltroComprobantes() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String texto,  TipoComprobante? tipo,  EstadoSunat? estado,  DateTime? desde,  DateTime? hasta,  int? clienteId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FiltroComprobantes() when $default != null:
return $default(_that.texto,_that.tipo,_that.estado,_that.desde,_that.hasta,_that.clienteId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String texto,  TipoComprobante? tipo,  EstadoSunat? estado,  DateTime? desde,  DateTime? hasta,  int? clienteId)  $default,) {final _that = this;
switch (_that) {
case _FiltroComprobantes():
return $default(_that.texto,_that.tipo,_that.estado,_that.desde,_that.hasta,_that.clienteId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String texto,  TipoComprobante? tipo,  EstadoSunat? estado,  DateTime? desde,  DateTime? hasta,  int? clienteId)?  $default,) {final _that = this;
switch (_that) {
case _FiltroComprobantes() when $default != null:
return $default(_that.texto,_that.tipo,_that.estado,_that.desde,_that.hasta,_that.clienteId);case _:
  return null;

}
}

}

/// @nodoc


class _FiltroComprobantes extends FiltroComprobantes {
  const _FiltroComprobantes({this.texto = '', this.tipo, this.estado, this.desde, this.hasta, this.clienteId}): super._();
  

/// Busca en serie-correlativo, razón social y documento del cliente.
@override@JsonKey() final  String texto;
@override final  TipoComprobante? tipo;
@override final  EstadoSunat? estado;
@override final  DateTime? desde;
@override final  DateTime? hasta;
@override final  int? clienteId;

/// Create a copy of FiltroComprobantes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FiltroComprobantesCopyWith<_FiltroComprobantes> get copyWith => __$FiltroComprobantesCopyWithImpl<_FiltroComprobantes>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FiltroComprobantes&&(identical(other.texto, texto) || other.texto == texto)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.estado, estado) || other.estado == estado)&&(identical(other.desde, desde) || other.desde == desde)&&(identical(other.hasta, hasta) || other.hasta == hasta)&&(identical(other.clienteId, clienteId) || other.clienteId == clienteId));
}


@override
int get hashCode => Object.hash(runtimeType,texto,tipo,estado,desde,hasta,clienteId);

@override
String toString() {
  return 'FiltroComprobantes(texto: $texto, tipo: $tipo, estado: $estado, desde: $desde, hasta: $hasta, clienteId: $clienteId)';
}


}

/// @nodoc
abstract mixin class _$FiltroComprobantesCopyWith<$Res> implements $FiltroComprobantesCopyWith<$Res> {
  factory _$FiltroComprobantesCopyWith(_FiltroComprobantes value, $Res Function(_FiltroComprobantes) _then) = __$FiltroComprobantesCopyWithImpl;
@override @useResult
$Res call({
 String texto, TipoComprobante? tipo, EstadoSunat? estado, DateTime? desde, DateTime? hasta, int? clienteId
});




}
/// @nodoc
class __$FiltroComprobantesCopyWithImpl<$Res>
    implements _$FiltroComprobantesCopyWith<$Res> {
  __$FiltroComprobantesCopyWithImpl(this._self, this._then);

  final _FiltroComprobantes _self;
  final $Res Function(_FiltroComprobantes) _then;

/// Create a copy of FiltroComprobantes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? texto = null,Object? tipo = freezed,Object? estado = freezed,Object? desde = freezed,Object? hasta = freezed,Object? clienteId = freezed,}) {
  return _then(_FiltroComprobantes(
texto: null == texto ? _self.texto : texto // ignore: cast_nullable_to_non_nullable
as String,tipo: freezed == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as TipoComprobante?,estado: freezed == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as EstadoSunat?,desde: freezed == desde ? _self.desde : desde // ignore: cast_nullable_to_non_nullable
as DateTime?,hasta: freezed == hasta ? _self.hasta : hasta // ignore: cast_nullable_to_non_nullable
as DateTime?,clienteId: freezed == clienteId ? _self.clienteId : clienteId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
