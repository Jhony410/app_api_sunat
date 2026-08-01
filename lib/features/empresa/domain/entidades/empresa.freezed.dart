// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'empresa.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Empresa {

 int get id; String get ruc; String get razonSocial; String get nombreComercial;/// Código de ubigeo INEI de 6 dígitos (`cbc:ID` de la dirección fiscal).
 String get ubigeo; String get departamento; String get provincia; String get distrito; String get direccion;/// Ruta local del logo que se imprime en el RIDE.
 String? get logoPath;/// Series habilitadas por tipo de comprobante (ej. `F001`, `B001`).
 List<String> get seriesFactura; List<String> get seriesBoleta;
/// Create a copy of Empresa
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmpresaCopyWith<Empresa> get copyWith => _$EmpresaCopyWithImpl<Empresa>(this as Empresa, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Empresa&&(identical(other.id, id) || other.id == id)&&(identical(other.ruc, ruc) || other.ruc == ruc)&&(identical(other.razonSocial, razonSocial) || other.razonSocial == razonSocial)&&(identical(other.nombreComercial, nombreComercial) || other.nombreComercial == nombreComercial)&&(identical(other.ubigeo, ubigeo) || other.ubigeo == ubigeo)&&(identical(other.departamento, departamento) || other.departamento == departamento)&&(identical(other.provincia, provincia) || other.provincia == provincia)&&(identical(other.distrito, distrito) || other.distrito == distrito)&&(identical(other.direccion, direccion) || other.direccion == direccion)&&(identical(other.logoPath, logoPath) || other.logoPath == logoPath)&&const DeepCollectionEquality().equals(other.seriesFactura, seriesFactura)&&const DeepCollectionEquality().equals(other.seriesBoleta, seriesBoleta));
}


@override
int get hashCode => Object.hash(runtimeType,id,ruc,razonSocial,nombreComercial,ubigeo,departamento,provincia,distrito,direccion,logoPath,const DeepCollectionEquality().hash(seriesFactura),const DeepCollectionEquality().hash(seriesBoleta));

@override
String toString() {
  return 'Empresa(id: $id, ruc: $ruc, razonSocial: $razonSocial, nombreComercial: $nombreComercial, ubigeo: $ubigeo, departamento: $departamento, provincia: $provincia, distrito: $distrito, direccion: $direccion, logoPath: $logoPath, seriesFactura: $seriesFactura, seriesBoleta: $seriesBoleta)';
}


}

/// @nodoc
abstract mixin class $EmpresaCopyWith<$Res>  {
  factory $EmpresaCopyWith(Empresa value, $Res Function(Empresa) _then) = _$EmpresaCopyWithImpl;
@useResult
$Res call({
 int id, String ruc, String razonSocial, String nombreComercial, String ubigeo, String departamento, String provincia, String distrito, String direccion, String? logoPath, List<String> seriesFactura, List<String> seriesBoleta
});




}
/// @nodoc
class _$EmpresaCopyWithImpl<$Res>
    implements $EmpresaCopyWith<$Res> {
  _$EmpresaCopyWithImpl(this._self, this._then);

  final Empresa _self;
  final $Res Function(Empresa) _then;

/// Create a copy of Empresa
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ruc = null,Object? razonSocial = null,Object? nombreComercial = null,Object? ubigeo = null,Object? departamento = null,Object? provincia = null,Object? distrito = null,Object? direccion = null,Object? logoPath = freezed,Object? seriesFactura = null,Object? seriesBoleta = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ruc: null == ruc ? _self.ruc : ruc // ignore: cast_nullable_to_non_nullable
as String,razonSocial: null == razonSocial ? _self.razonSocial : razonSocial // ignore: cast_nullable_to_non_nullable
as String,nombreComercial: null == nombreComercial ? _self.nombreComercial : nombreComercial // ignore: cast_nullable_to_non_nullable
as String,ubigeo: null == ubigeo ? _self.ubigeo : ubigeo // ignore: cast_nullable_to_non_nullable
as String,departamento: null == departamento ? _self.departamento : departamento // ignore: cast_nullable_to_non_nullable
as String,provincia: null == provincia ? _self.provincia : provincia // ignore: cast_nullable_to_non_nullable
as String,distrito: null == distrito ? _self.distrito : distrito // ignore: cast_nullable_to_non_nullable
as String,direccion: null == direccion ? _self.direccion : direccion // ignore: cast_nullable_to_non_nullable
as String,logoPath: freezed == logoPath ? _self.logoPath : logoPath // ignore: cast_nullable_to_non_nullable
as String?,seriesFactura: null == seriesFactura ? _self.seriesFactura : seriesFactura // ignore: cast_nullable_to_non_nullable
as List<String>,seriesBoleta: null == seriesBoleta ? _self.seriesBoleta : seriesBoleta // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Empresa].
extension EmpresaPatterns on Empresa {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Empresa value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Empresa() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Empresa value)  $default,){
final _that = this;
switch (_that) {
case _Empresa():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Empresa value)?  $default,){
final _that = this;
switch (_that) {
case _Empresa() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String ruc,  String razonSocial,  String nombreComercial,  String ubigeo,  String departamento,  String provincia,  String distrito,  String direccion,  String? logoPath,  List<String> seriesFactura,  List<String> seriesBoleta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Empresa() when $default != null:
return $default(_that.id,_that.ruc,_that.razonSocial,_that.nombreComercial,_that.ubigeo,_that.departamento,_that.provincia,_that.distrito,_that.direccion,_that.logoPath,_that.seriesFactura,_that.seriesBoleta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String ruc,  String razonSocial,  String nombreComercial,  String ubigeo,  String departamento,  String provincia,  String distrito,  String direccion,  String? logoPath,  List<String> seriesFactura,  List<String> seriesBoleta)  $default,) {final _that = this;
switch (_that) {
case _Empresa():
return $default(_that.id,_that.ruc,_that.razonSocial,_that.nombreComercial,_that.ubigeo,_that.departamento,_that.provincia,_that.distrito,_that.direccion,_that.logoPath,_that.seriesFactura,_that.seriesBoleta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String ruc,  String razonSocial,  String nombreComercial,  String ubigeo,  String departamento,  String provincia,  String distrito,  String direccion,  String? logoPath,  List<String> seriesFactura,  List<String> seriesBoleta)?  $default,) {final _that = this;
switch (_that) {
case _Empresa() when $default != null:
return $default(_that.id,_that.ruc,_that.razonSocial,_that.nombreComercial,_that.ubigeo,_that.departamento,_that.provincia,_that.distrito,_that.direccion,_that.logoPath,_that.seriesFactura,_that.seriesBoleta);case _:
  return null;

}
}

}

/// @nodoc


class _Empresa extends Empresa {
  const _Empresa({this.id = 1, required this.ruc, required this.razonSocial, this.nombreComercial = '', this.ubigeo = '', this.departamento = '', this.provincia = '', this.distrito = '', this.direccion = '', this.logoPath, final  List<String> seriesFactura = const <String>['F001'], final  List<String> seriesBoleta = const <String>['B001']}): _seriesFactura = seriesFactura,_seriesBoleta = seriesBoleta,super._();
  

@override@JsonKey() final  int id;
@override final  String ruc;
@override final  String razonSocial;
@override@JsonKey() final  String nombreComercial;
/// Código de ubigeo INEI de 6 dígitos (`cbc:ID` de la dirección fiscal).
@override@JsonKey() final  String ubigeo;
@override@JsonKey() final  String departamento;
@override@JsonKey() final  String provincia;
@override@JsonKey() final  String distrito;
@override@JsonKey() final  String direccion;
/// Ruta local del logo que se imprime en el RIDE.
@override final  String? logoPath;
/// Series habilitadas por tipo de comprobante (ej. `F001`, `B001`).
 final  List<String> _seriesFactura;
/// Series habilitadas por tipo de comprobante (ej. `F001`, `B001`).
@override@JsonKey() List<String> get seriesFactura {
  if (_seriesFactura is EqualUnmodifiableListView) return _seriesFactura;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_seriesFactura);
}

 final  List<String> _seriesBoleta;
@override@JsonKey() List<String> get seriesBoleta {
  if (_seriesBoleta is EqualUnmodifiableListView) return _seriesBoleta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_seriesBoleta);
}


/// Create a copy of Empresa
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmpresaCopyWith<_Empresa> get copyWith => __$EmpresaCopyWithImpl<_Empresa>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Empresa&&(identical(other.id, id) || other.id == id)&&(identical(other.ruc, ruc) || other.ruc == ruc)&&(identical(other.razonSocial, razonSocial) || other.razonSocial == razonSocial)&&(identical(other.nombreComercial, nombreComercial) || other.nombreComercial == nombreComercial)&&(identical(other.ubigeo, ubigeo) || other.ubigeo == ubigeo)&&(identical(other.departamento, departamento) || other.departamento == departamento)&&(identical(other.provincia, provincia) || other.provincia == provincia)&&(identical(other.distrito, distrito) || other.distrito == distrito)&&(identical(other.direccion, direccion) || other.direccion == direccion)&&(identical(other.logoPath, logoPath) || other.logoPath == logoPath)&&const DeepCollectionEquality().equals(other._seriesFactura, _seriesFactura)&&const DeepCollectionEquality().equals(other._seriesBoleta, _seriesBoleta));
}


@override
int get hashCode => Object.hash(runtimeType,id,ruc,razonSocial,nombreComercial,ubigeo,departamento,provincia,distrito,direccion,logoPath,const DeepCollectionEquality().hash(_seriesFactura),const DeepCollectionEquality().hash(_seriesBoleta));

@override
String toString() {
  return 'Empresa(id: $id, ruc: $ruc, razonSocial: $razonSocial, nombreComercial: $nombreComercial, ubigeo: $ubigeo, departamento: $departamento, provincia: $provincia, distrito: $distrito, direccion: $direccion, logoPath: $logoPath, seriesFactura: $seriesFactura, seriesBoleta: $seriesBoleta)';
}


}

/// @nodoc
abstract mixin class _$EmpresaCopyWith<$Res> implements $EmpresaCopyWith<$Res> {
  factory _$EmpresaCopyWith(_Empresa value, $Res Function(_Empresa) _then) = __$EmpresaCopyWithImpl;
@override @useResult
$Res call({
 int id, String ruc, String razonSocial, String nombreComercial, String ubigeo, String departamento, String provincia, String distrito, String direccion, String? logoPath, List<String> seriesFactura, List<String> seriesBoleta
});




}
/// @nodoc
class __$EmpresaCopyWithImpl<$Res>
    implements _$EmpresaCopyWith<$Res> {
  __$EmpresaCopyWithImpl(this._self, this._then);

  final _Empresa _self;
  final $Res Function(_Empresa) _then;

/// Create a copy of Empresa
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ruc = null,Object? razonSocial = null,Object? nombreComercial = null,Object? ubigeo = null,Object? departamento = null,Object? provincia = null,Object? distrito = null,Object? direccion = null,Object? logoPath = freezed,Object? seriesFactura = null,Object? seriesBoleta = null,}) {
  return _then(_Empresa(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ruc: null == ruc ? _self.ruc : ruc // ignore: cast_nullable_to_non_nullable
as String,razonSocial: null == razonSocial ? _self.razonSocial : razonSocial // ignore: cast_nullable_to_non_nullable
as String,nombreComercial: null == nombreComercial ? _self.nombreComercial : nombreComercial // ignore: cast_nullable_to_non_nullable
as String,ubigeo: null == ubigeo ? _self.ubigeo : ubigeo // ignore: cast_nullable_to_non_nullable
as String,departamento: null == departamento ? _self.departamento : departamento // ignore: cast_nullable_to_non_nullable
as String,provincia: null == provincia ? _self.provincia : provincia // ignore: cast_nullable_to_non_nullable
as String,distrito: null == distrito ? _self.distrito : distrito // ignore: cast_nullable_to_non_nullable
as String,direccion: null == direccion ? _self.direccion : direccion // ignore: cast_nullable_to_non_nullable
as String,logoPath: freezed == logoPath ? _self.logoPath : logoPath // ignore: cast_nullable_to_non_nullable
as String?,seriesFactura: null == seriesFactura ? _self._seriesFactura : seriesFactura // ignore: cast_nullable_to_non_nullable
as List<String>,seriesBoleta: null == seriesBoleta ? _self._seriesBoleta : seriesBoleta // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
