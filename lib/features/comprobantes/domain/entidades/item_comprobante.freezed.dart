// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_comprobante.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ItemComprobante {

 int? get id; int? get comprobanteId;/// Código interno del producto o servicio (`cac:SellersItemIdentification`).
 String get codigo; String get descripcion; UnidadMedida get unidadMedida; double get cantidad;/// Valor unitario **sin IGV**. Es el dato canónico que se persiste.
 double get valorUnitario; TipoAfectacionIgv get tipoAfectacionIgv;/// Descuento en importe (no porcentaje) aplicado a la línea completa.
 double get descuento;/// Orden de la línea dentro del comprobante (`cbc:ID`, empieza en 1).
 int get orden;
/// Create a copy of ItemComprobante
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemComprobanteCopyWith<ItemComprobante> get copyWith => _$ItemComprobanteCopyWithImpl<ItemComprobante>(this as ItemComprobante, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemComprobante&&(identical(other.id, id) || other.id == id)&&(identical(other.comprobanteId, comprobanteId) || other.comprobanteId == comprobanteId)&&(identical(other.codigo, codigo) || other.codigo == codigo)&&(identical(other.descripcion, descripcion) || other.descripcion == descripcion)&&(identical(other.unidadMedida, unidadMedida) || other.unidadMedida == unidadMedida)&&(identical(other.cantidad, cantidad) || other.cantidad == cantidad)&&(identical(other.valorUnitario, valorUnitario) || other.valorUnitario == valorUnitario)&&(identical(other.tipoAfectacionIgv, tipoAfectacionIgv) || other.tipoAfectacionIgv == tipoAfectacionIgv)&&(identical(other.descuento, descuento) || other.descuento == descuento)&&(identical(other.orden, orden) || other.orden == orden));
}


@override
int get hashCode => Object.hash(runtimeType,id,comprobanteId,codigo,descripcion,unidadMedida,cantidad,valorUnitario,tipoAfectacionIgv,descuento,orden);

@override
String toString() {
  return 'ItemComprobante(id: $id, comprobanteId: $comprobanteId, codigo: $codigo, descripcion: $descripcion, unidadMedida: $unidadMedida, cantidad: $cantidad, valorUnitario: $valorUnitario, tipoAfectacionIgv: $tipoAfectacionIgv, descuento: $descuento, orden: $orden)';
}


}

/// @nodoc
abstract mixin class $ItemComprobanteCopyWith<$Res>  {
  factory $ItemComprobanteCopyWith(ItemComprobante value, $Res Function(ItemComprobante) _then) = _$ItemComprobanteCopyWithImpl;
@useResult
$Res call({
 int? id, int? comprobanteId, String codigo, String descripcion, UnidadMedida unidadMedida, double cantidad, double valorUnitario, TipoAfectacionIgv tipoAfectacionIgv, double descuento, int orden
});




}
/// @nodoc
class _$ItemComprobanteCopyWithImpl<$Res>
    implements $ItemComprobanteCopyWith<$Res> {
  _$ItemComprobanteCopyWithImpl(this._self, this._then);

  final ItemComprobante _self;
  final $Res Function(ItemComprobante) _then;

/// Create a copy of ItemComprobante
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? comprobanteId = freezed,Object? codigo = null,Object? descripcion = null,Object? unidadMedida = null,Object? cantidad = null,Object? valorUnitario = null,Object? tipoAfectacionIgv = null,Object? descuento = null,Object? orden = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,comprobanteId: freezed == comprobanteId ? _self.comprobanteId : comprobanteId // ignore: cast_nullable_to_non_nullable
as int?,codigo: null == codigo ? _self.codigo : codigo // ignore: cast_nullable_to_non_nullable
as String,descripcion: null == descripcion ? _self.descripcion : descripcion // ignore: cast_nullable_to_non_nullable
as String,unidadMedida: null == unidadMedida ? _self.unidadMedida : unidadMedida // ignore: cast_nullable_to_non_nullable
as UnidadMedida,cantidad: null == cantidad ? _self.cantidad : cantidad // ignore: cast_nullable_to_non_nullable
as double,valorUnitario: null == valorUnitario ? _self.valorUnitario : valorUnitario // ignore: cast_nullable_to_non_nullable
as double,tipoAfectacionIgv: null == tipoAfectacionIgv ? _self.tipoAfectacionIgv : tipoAfectacionIgv // ignore: cast_nullable_to_non_nullable
as TipoAfectacionIgv,descuento: null == descuento ? _self.descuento : descuento // ignore: cast_nullable_to_non_nullable
as double,orden: null == orden ? _self.orden : orden // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ItemComprobante].
extension ItemComprobantePatterns on ItemComprobante {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemComprobante value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemComprobante() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemComprobante value)  $default,){
final _that = this;
switch (_that) {
case _ItemComprobante():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemComprobante value)?  $default,){
final _that = this;
switch (_that) {
case _ItemComprobante() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int? comprobanteId,  String codigo,  String descripcion,  UnidadMedida unidadMedida,  double cantidad,  double valorUnitario,  TipoAfectacionIgv tipoAfectacionIgv,  double descuento,  int orden)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemComprobante() when $default != null:
return $default(_that.id,_that.comprobanteId,_that.codigo,_that.descripcion,_that.unidadMedida,_that.cantidad,_that.valorUnitario,_that.tipoAfectacionIgv,_that.descuento,_that.orden);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int? comprobanteId,  String codigo,  String descripcion,  UnidadMedida unidadMedida,  double cantidad,  double valorUnitario,  TipoAfectacionIgv tipoAfectacionIgv,  double descuento,  int orden)  $default,) {final _that = this;
switch (_that) {
case _ItemComprobante():
return $default(_that.id,_that.comprobanteId,_that.codigo,_that.descripcion,_that.unidadMedida,_that.cantidad,_that.valorUnitario,_that.tipoAfectacionIgv,_that.descuento,_that.orden);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int? comprobanteId,  String codigo,  String descripcion,  UnidadMedida unidadMedida,  double cantidad,  double valorUnitario,  TipoAfectacionIgv tipoAfectacionIgv,  double descuento,  int orden)?  $default,) {final _that = this;
switch (_that) {
case _ItemComprobante() when $default != null:
return $default(_that.id,_that.comprobanteId,_that.codigo,_that.descripcion,_that.unidadMedida,_that.cantidad,_that.valorUnitario,_that.tipoAfectacionIgv,_that.descuento,_that.orden);case _:
  return null;

}
}

}

/// @nodoc


class _ItemComprobante extends ItemComprobante {
  const _ItemComprobante({this.id, this.comprobanteId, this.codigo = '', required this.descripcion, this.unidadMedida = UnidadMedida.unidad, this.cantidad = 1.0, this.valorUnitario = 0.0, this.tipoAfectacionIgv = TipoAfectacionIgv.gravado, this.descuento = 0.0, this.orden = 0}): super._();
  

@override final  int? id;
@override final  int? comprobanteId;
/// Código interno del producto o servicio (`cac:SellersItemIdentification`).
@override@JsonKey() final  String codigo;
@override final  String descripcion;
@override@JsonKey() final  UnidadMedida unidadMedida;
@override@JsonKey() final  double cantidad;
/// Valor unitario **sin IGV**. Es el dato canónico que se persiste.
@override@JsonKey() final  double valorUnitario;
@override@JsonKey() final  TipoAfectacionIgv tipoAfectacionIgv;
/// Descuento en importe (no porcentaje) aplicado a la línea completa.
@override@JsonKey() final  double descuento;
/// Orden de la línea dentro del comprobante (`cbc:ID`, empieza en 1).
@override@JsonKey() final  int orden;

/// Create a copy of ItemComprobante
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemComprobanteCopyWith<_ItemComprobante> get copyWith => __$ItemComprobanteCopyWithImpl<_ItemComprobante>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemComprobante&&(identical(other.id, id) || other.id == id)&&(identical(other.comprobanteId, comprobanteId) || other.comprobanteId == comprobanteId)&&(identical(other.codigo, codigo) || other.codigo == codigo)&&(identical(other.descripcion, descripcion) || other.descripcion == descripcion)&&(identical(other.unidadMedida, unidadMedida) || other.unidadMedida == unidadMedida)&&(identical(other.cantidad, cantidad) || other.cantidad == cantidad)&&(identical(other.valorUnitario, valorUnitario) || other.valorUnitario == valorUnitario)&&(identical(other.tipoAfectacionIgv, tipoAfectacionIgv) || other.tipoAfectacionIgv == tipoAfectacionIgv)&&(identical(other.descuento, descuento) || other.descuento == descuento)&&(identical(other.orden, orden) || other.orden == orden));
}


@override
int get hashCode => Object.hash(runtimeType,id,comprobanteId,codigo,descripcion,unidadMedida,cantidad,valorUnitario,tipoAfectacionIgv,descuento,orden);

@override
String toString() {
  return 'ItemComprobante(id: $id, comprobanteId: $comprobanteId, codigo: $codigo, descripcion: $descripcion, unidadMedida: $unidadMedida, cantidad: $cantidad, valorUnitario: $valorUnitario, tipoAfectacionIgv: $tipoAfectacionIgv, descuento: $descuento, orden: $orden)';
}


}

/// @nodoc
abstract mixin class _$ItemComprobanteCopyWith<$Res> implements $ItemComprobanteCopyWith<$Res> {
  factory _$ItemComprobanteCopyWith(_ItemComprobante value, $Res Function(_ItemComprobante) _then) = __$ItemComprobanteCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? comprobanteId, String codigo, String descripcion, UnidadMedida unidadMedida, double cantidad, double valorUnitario, TipoAfectacionIgv tipoAfectacionIgv, double descuento, int orden
});




}
/// @nodoc
class __$ItemComprobanteCopyWithImpl<$Res>
    implements _$ItemComprobanteCopyWith<$Res> {
  __$ItemComprobanteCopyWithImpl(this._self, this._then);

  final _ItemComprobante _self;
  final $Res Function(_ItemComprobante) _then;

/// Create a copy of ItemComprobante
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? comprobanteId = freezed,Object? codigo = null,Object? descripcion = null,Object? unidadMedida = null,Object? cantidad = null,Object? valorUnitario = null,Object? tipoAfectacionIgv = null,Object? descuento = null,Object? orden = null,}) {
  return _then(_ItemComprobante(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,comprobanteId: freezed == comprobanteId ? _self.comprobanteId : comprobanteId // ignore: cast_nullable_to_non_nullable
as int?,codigo: null == codigo ? _self.codigo : codigo // ignore: cast_nullable_to_non_nullable
as String,descripcion: null == descripcion ? _self.descripcion : descripcion // ignore: cast_nullable_to_non_nullable
as String,unidadMedida: null == unidadMedida ? _self.unidadMedida : unidadMedida // ignore: cast_nullable_to_non_nullable
as UnidadMedida,cantidad: null == cantidad ? _self.cantidad : cantidad // ignore: cast_nullable_to_non_nullable
as double,valorUnitario: null == valorUnitario ? _self.valorUnitario : valorUnitario // ignore: cast_nullable_to_non_nullable
as double,tipoAfectacionIgv: null == tipoAfectacionIgv ? _self.tipoAfectacionIgv : tipoAfectacionIgv // ignore: cast_nullable_to_non_nullable
as TipoAfectacionIgv,descuento: null == descuento ? _self.descuento : descuento // ignore: cast_nullable_to_non_nullable
as double,orden: null == orden ? _self.orden : orden // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
