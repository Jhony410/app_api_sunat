// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cliente.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Cliente {

 int? get id; TipoDocumentoIdentidad get tipoDocumento; String get numeroDocumento; String get razonSocialONombres; String? get direccion; String? get telefono; String? get email; DateTime? get creadoEn;
/// Create a copy of Cliente
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClienteCopyWith<Cliente> get copyWith => _$ClienteCopyWithImpl<Cliente>(this as Cliente, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cliente&&(identical(other.id, id) || other.id == id)&&(identical(other.tipoDocumento, tipoDocumento) || other.tipoDocumento == tipoDocumento)&&(identical(other.numeroDocumento, numeroDocumento) || other.numeroDocumento == numeroDocumento)&&(identical(other.razonSocialONombres, razonSocialONombres) || other.razonSocialONombres == razonSocialONombres)&&(identical(other.direccion, direccion) || other.direccion == direccion)&&(identical(other.telefono, telefono) || other.telefono == telefono)&&(identical(other.email, email) || other.email == email)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn));
}


@override
int get hashCode => Object.hash(runtimeType,id,tipoDocumento,numeroDocumento,razonSocialONombres,direccion,telefono,email,creadoEn);

@override
String toString() {
  return 'Cliente(id: $id, tipoDocumento: $tipoDocumento, numeroDocumento: $numeroDocumento, razonSocialONombres: $razonSocialONombres, direccion: $direccion, telefono: $telefono, email: $email, creadoEn: $creadoEn)';
}


}

/// @nodoc
abstract mixin class $ClienteCopyWith<$Res>  {
  factory $ClienteCopyWith(Cliente value, $Res Function(Cliente) _then) = _$ClienteCopyWithImpl;
@useResult
$Res call({
 int? id, TipoDocumentoIdentidad tipoDocumento, String numeroDocumento, String razonSocialONombres, String? direccion, String? telefono, String? email, DateTime? creadoEn
});




}
/// @nodoc
class _$ClienteCopyWithImpl<$Res>
    implements $ClienteCopyWith<$Res> {
  _$ClienteCopyWithImpl(this._self, this._then);

  final Cliente _self;
  final $Res Function(Cliente) _then;

/// Create a copy of Cliente
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tipoDocumento = null,Object? numeroDocumento = null,Object? razonSocialONombres = null,Object? direccion = freezed,Object? telefono = freezed,Object? email = freezed,Object? creadoEn = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tipoDocumento: null == tipoDocumento ? _self.tipoDocumento : tipoDocumento // ignore: cast_nullable_to_non_nullable
as TipoDocumentoIdentidad,numeroDocumento: null == numeroDocumento ? _self.numeroDocumento : numeroDocumento // ignore: cast_nullable_to_non_nullable
as String,razonSocialONombres: null == razonSocialONombres ? _self.razonSocialONombres : razonSocialONombres // ignore: cast_nullable_to_non_nullable
as String,direccion: freezed == direccion ? _self.direccion : direccion // ignore: cast_nullable_to_non_nullable
as String?,telefono: freezed == telefono ? _self.telefono : telefono // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Cliente].
extension ClientePatterns on Cliente {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Cliente value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Cliente() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Cliente value)  $default,){
final _that = this;
switch (_that) {
case _Cliente():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Cliente value)?  $default,){
final _that = this;
switch (_that) {
case _Cliente() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  TipoDocumentoIdentidad tipoDocumento,  String numeroDocumento,  String razonSocialONombres,  String? direccion,  String? telefono,  String? email,  DateTime? creadoEn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Cliente() when $default != null:
return $default(_that.id,_that.tipoDocumento,_that.numeroDocumento,_that.razonSocialONombres,_that.direccion,_that.telefono,_that.email,_that.creadoEn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  TipoDocumentoIdentidad tipoDocumento,  String numeroDocumento,  String razonSocialONombres,  String? direccion,  String? telefono,  String? email,  DateTime? creadoEn)  $default,) {final _that = this;
switch (_that) {
case _Cliente():
return $default(_that.id,_that.tipoDocumento,_that.numeroDocumento,_that.razonSocialONombres,_that.direccion,_that.telefono,_that.email,_that.creadoEn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  TipoDocumentoIdentidad tipoDocumento,  String numeroDocumento,  String razonSocialONombres,  String? direccion,  String? telefono,  String? email,  DateTime? creadoEn)?  $default,) {final _that = this;
switch (_that) {
case _Cliente() when $default != null:
return $default(_that.id,_that.tipoDocumento,_that.numeroDocumento,_that.razonSocialONombres,_that.direccion,_that.telefono,_that.email,_that.creadoEn);case _:
  return null;

}
}

}

/// @nodoc


class _Cliente extends Cliente {
  const _Cliente({this.id, this.tipoDocumento = TipoDocumentoIdentidad.dni, required this.numeroDocumento, required this.razonSocialONombres, this.direccion, this.telefono, this.email, this.creadoEn}): super._();
  

@override final  int? id;
@override@JsonKey() final  TipoDocumentoIdentidad tipoDocumento;
@override final  String numeroDocumento;
@override final  String razonSocialONombres;
@override final  String? direccion;
@override final  String? telefono;
@override final  String? email;
@override final  DateTime? creadoEn;

/// Create a copy of Cliente
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClienteCopyWith<_Cliente> get copyWith => __$ClienteCopyWithImpl<_Cliente>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cliente&&(identical(other.id, id) || other.id == id)&&(identical(other.tipoDocumento, tipoDocumento) || other.tipoDocumento == tipoDocumento)&&(identical(other.numeroDocumento, numeroDocumento) || other.numeroDocumento == numeroDocumento)&&(identical(other.razonSocialONombres, razonSocialONombres) || other.razonSocialONombres == razonSocialONombres)&&(identical(other.direccion, direccion) || other.direccion == direccion)&&(identical(other.telefono, telefono) || other.telefono == telefono)&&(identical(other.email, email) || other.email == email)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn));
}


@override
int get hashCode => Object.hash(runtimeType,id,tipoDocumento,numeroDocumento,razonSocialONombres,direccion,telefono,email,creadoEn);

@override
String toString() {
  return 'Cliente(id: $id, tipoDocumento: $tipoDocumento, numeroDocumento: $numeroDocumento, razonSocialONombres: $razonSocialONombres, direccion: $direccion, telefono: $telefono, email: $email, creadoEn: $creadoEn)';
}


}

/// @nodoc
abstract mixin class _$ClienteCopyWith<$Res> implements $ClienteCopyWith<$Res> {
  factory _$ClienteCopyWith(_Cliente value, $Res Function(_Cliente) _then) = __$ClienteCopyWithImpl;
@override @useResult
$Res call({
 int? id, TipoDocumentoIdentidad tipoDocumento, String numeroDocumento, String razonSocialONombres, String? direccion, String? telefono, String? email, DateTime? creadoEn
});




}
/// @nodoc
class __$ClienteCopyWithImpl<$Res>
    implements _$ClienteCopyWith<$Res> {
  __$ClienteCopyWithImpl(this._self, this._then);

  final _Cliente _self;
  final $Res Function(_Cliente) _then;

/// Create a copy of Cliente
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tipoDocumento = null,Object? numeroDocumento = null,Object? razonSocialONombres = null,Object? direccion = freezed,Object? telefono = freezed,Object? email = freezed,Object? creadoEn = freezed,}) {
  return _then(_Cliente(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tipoDocumento: null == tipoDocumento ? _self.tipoDocumento : tipoDocumento // ignore: cast_nullable_to_non_nullable
as TipoDocumentoIdentidad,numeroDocumento: null == numeroDocumento ? _self.numeroDocumento : numeroDocumento // ignore: cast_nullable_to_non_nullable
as String,razonSocialONombres: null == razonSocialONombres ? _self.razonSocialONombres : razonSocialONombres // ignore: cast_nullable_to_non_nullable
as String,direccion: freezed == direccion ? _self.direccion : direccion // ignore: cast_nullable_to_non_nullable
as String?,telefono: freezed == telefono ? _self.telefono : telefono // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
