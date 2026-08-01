// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ajustes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Ajustes {

 ModoOperacion get modoOperacion; String get lycetUrl; String get lycetToken; String get proveedorConsulta; String get tokenConsulta; ThemeMode get temaApp;
/// Create a copy of Ajustes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AjustesCopyWith<Ajustes> get copyWith => _$AjustesCopyWithImpl<Ajustes>(this as Ajustes, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ajustes&&(identical(other.modoOperacion, modoOperacion) || other.modoOperacion == modoOperacion)&&(identical(other.lycetUrl, lycetUrl) || other.lycetUrl == lycetUrl)&&(identical(other.lycetToken, lycetToken) || other.lycetToken == lycetToken)&&(identical(other.proveedorConsulta, proveedorConsulta) || other.proveedorConsulta == proveedorConsulta)&&(identical(other.tokenConsulta, tokenConsulta) || other.tokenConsulta == tokenConsulta)&&(identical(other.temaApp, temaApp) || other.temaApp == temaApp));
}


@override
int get hashCode => Object.hash(runtimeType,modoOperacion,lycetUrl,lycetToken,proveedorConsulta,tokenConsulta,temaApp);

@override
String toString() {
  return 'Ajustes(modoOperacion: $modoOperacion, lycetUrl: $lycetUrl, lycetToken: $lycetToken, proveedorConsulta: $proveedorConsulta, tokenConsulta: $tokenConsulta, temaApp: $temaApp)';
}


}

/// @nodoc
abstract mixin class $AjustesCopyWith<$Res>  {
  factory $AjustesCopyWith(Ajustes value, $Res Function(Ajustes) _then) = _$AjustesCopyWithImpl;
@useResult
$Res call({
 ModoOperacion modoOperacion, String lycetUrl, String lycetToken, String proveedorConsulta, String tokenConsulta, ThemeMode temaApp
});




}
/// @nodoc
class _$AjustesCopyWithImpl<$Res>
    implements $AjustesCopyWith<$Res> {
  _$AjustesCopyWithImpl(this._self, this._then);

  final Ajustes _self;
  final $Res Function(Ajustes) _then;

/// Create a copy of Ajustes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? modoOperacion = null,Object? lycetUrl = null,Object? lycetToken = null,Object? proveedorConsulta = null,Object? tokenConsulta = null,Object? temaApp = null,}) {
  return _then(_self.copyWith(
modoOperacion: null == modoOperacion ? _self.modoOperacion : modoOperacion // ignore: cast_nullable_to_non_nullable
as ModoOperacion,lycetUrl: null == lycetUrl ? _self.lycetUrl : lycetUrl // ignore: cast_nullable_to_non_nullable
as String,lycetToken: null == lycetToken ? _self.lycetToken : lycetToken // ignore: cast_nullable_to_non_nullable
as String,proveedorConsulta: null == proveedorConsulta ? _self.proveedorConsulta : proveedorConsulta // ignore: cast_nullable_to_non_nullable
as String,tokenConsulta: null == tokenConsulta ? _self.tokenConsulta : tokenConsulta // ignore: cast_nullable_to_non_nullable
as String,temaApp: null == temaApp ? _self.temaApp : temaApp // ignore: cast_nullable_to_non_nullable
as ThemeMode,
  ));
}

}


/// Adds pattern-matching-related methods to [Ajustes].
extension AjustesPatterns on Ajustes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Ajustes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Ajustes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Ajustes value)  $default,){
final _that = this;
switch (_that) {
case _Ajustes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Ajustes value)?  $default,){
final _that = this;
switch (_that) {
case _Ajustes() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ModoOperacion modoOperacion,  String lycetUrl,  String lycetToken,  String proveedorConsulta,  String tokenConsulta,  ThemeMode temaApp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ajustes() when $default != null:
return $default(_that.modoOperacion,_that.lycetUrl,_that.lycetToken,_that.proveedorConsulta,_that.tokenConsulta,_that.temaApp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ModoOperacion modoOperacion,  String lycetUrl,  String lycetToken,  String proveedorConsulta,  String tokenConsulta,  ThemeMode temaApp)  $default,) {final _that = this;
switch (_that) {
case _Ajustes():
return $default(_that.modoOperacion,_that.lycetUrl,_that.lycetToken,_that.proveedorConsulta,_that.tokenConsulta,_that.temaApp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ModoOperacion modoOperacion,  String lycetUrl,  String lycetToken,  String proveedorConsulta,  String tokenConsulta,  ThemeMode temaApp)?  $default,) {final _that = this;
switch (_that) {
case _Ajustes() when $default != null:
return $default(_that.modoOperacion,_that.lycetUrl,_that.lycetToken,_that.proveedorConsulta,_that.tokenConsulta,_that.temaApp);case _:
  return null;

}
}

}

/// @nodoc


class _Ajustes extends Ajustes {
  const _Ajustes({this.modoOperacion = ModoOperacion.simulacion, this.lycetUrl = '', this.lycetToken = '', this.proveedorConsulta = 'decolecta', this.tokenConsulta = '', this.temaApp = ThemeMode.system}): super._();
  

@override@JsonKey() final  ModoOperacion modoOperacion;
@override@JsonKey() final  String lycetUrl;
@override@JsonKey() final  String lycetToken;
@override@JsonKey() final  String proveedorConsulta;
@override@JsonKey() final  String tokenConsulta;
@override@JsonKey() final  ThemeMode temaApp;

/// Create a copy of Ajustes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AjustesCopyWith<_Ajustes> get copyWith => __$AjustesCopyWithImpl<_Ajustes>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ajustes&&(identical(other.modoOperacion, modoOperacion) || other.modoOperacion == modoOperacion)&&(identical(other.lycetUrl, lycetUrl) || other.lycetUrl == lycetUrl)&&(identical(other.lycetToken, lycetToken) || other.lycetToken == lycetToken)&&(identical(other.proveedorConsulta, proveedorConsulta) || other.proveedorConsulta == proveedorConsulta)&&(identical(other.tokenConsulta, tokenConsulta) || other.tokenConsulta == tokenConsulta)&&(identical(other.temaApp, temaApp) || other.temaApp == temaApp));
}


@override
int get hashCode => Object.hash(runtimeType,modoOperacion,lycetUrl,lycetToken,proveedorConsulta,tokenConsulta,temaApp);

@override
String toString() {
  return 'Ajustes(modoOperacion: $modoOperacion, lycetUrl: $lycetUrl, lycetToken: $lycetToken, proveedorConsulta: $proveedorConsulta, tokenConsulta: $tokenConsulta, temaApp: $temaApp)';
}


}

/// @nodoc
abstract mixin class _$AjustesCopyWith<$Res> implements $AjustesCopyWith<$Res> {
  factory _$AjustesCopyWith(_Ajustes value, $Res Function(_Ajustes) _then) = __$AjustesCopyWithImpl;
@override @useResult
$Res call({
 ModoOperacion modoOperacion, String lycetUrl, String lycetToken, String proveedorConsulta, String tokenConsulta, ThemeMode temaApp
});




}
/// @nodoc
class __$AjustesCopyWithImpl<$Res>
    implements _$AjustesCopyWith<$Res> {
  __$AjustesCopyWithImpl(this._self, this._then);

  final _Ajustes _self;
  final $Res Function(_Ajustes) _then;

/// Create a copy of Ajustes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? modoOperacion = null,Object? lycetUrl = null,Object? lycetToken = null,Object? proveedorConsulta = null,Object? tokenConsulta = null,Object? temaApp = null,}) {
  return _then(_Ajustes(
modoOperacion: null == modoOperacion ? _self.modoOperacion : modoOperacion // ignore: cast_nullable_to_non_nullable
as ModoOperacion,lycetUrl: null == lycetUrl ? _self.lycetUrl : lycetUrl // ignore: cast_nullable_to_non_nullable
as String,lycetToken: null == lycetToken ? _self.lycetToken : lycetToken // ignore: cast_nullable_to_non_nullable
as String,proveedorConsulta: null == proveedorConsulta ? _self.proveedorConsulta : proveedorConsulta // ignore: cast_nullable_to_non_nullable
as String,tokenConsulta: null == tokenConsulta ? _self.tokenConsulta : tokenConsulta // ignore: cast_nullable_to_non_nullable
as String,temaApp: null == temaApp ? _self.temaApp : temaApp // ignore: cast_nullable_to_non_nullable
as ThemeMode,
  ));
}


}

// dart format on
