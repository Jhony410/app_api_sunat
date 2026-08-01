// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'totales.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LineaCalculada {

 int get orden; TipoAfectacionIgv get afectacion; double get cantidad;/// Valor unitario sin IGV tal como lo capturó el usuario.
 double get valorUnitario;/// `cantidad × valorUnitario`, antes de aplicar el descuento.
 double get valorBruto; double get descuento;/// Base imponible de la línea (`cbc:LineExtensionAmount`).
/// Vale 0 en las entregas gratuitas.
 double get valorVenta;/// Valor referencial de las entregas gratuitas. Vale 0 en el resto.
 double get valorReferencial;/// IGV de la línea. En las gratuitas se informa pero no se cobra.
 double get igv;/// Precio unitario con IGV incluido (`cac:AlternativeConditionPrice`).
 double get precioUnitario;/// Importe que ve el usuario en la fila: base + IGV. Vale 0 si es gratuita.
 double get totalLinea;
/// Create a copy of LineaCalculada
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineaCalculadaCopyWith<LineaCalculada> get copyWith => _$LineaCalculadaCopyWithImpl<LineaCalculada>(this as LineaCalculada, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineaCalculada&&(identical(other.orden, orden) || other.orden == orden)&&(identical(other.afectacion, afectacion) || other.afectacion == afectacion)&&(identical(other.cantidad, cantidad) || other.cantidad == cantidad)&&(identical(other.valorUnitario, valorUnitario) || other.valorUnitario == valorUnitario)&&(identical(other.valorBruto, valorBruto) || other.valorBruto == valorBruto)&&(identical(other.descuento, descuento) || other.descuento == descuento)&&(identical(other.valorVenta, valorVenta) || other.valorVenta == valorVenta)&&(identical(other.valorReferencial, valorReferencial) || other.valorReferencial == valorReferencial)&&(identical(other.igv, igv) || other.igv == igv)&&(identical(other.precioUnitario, precioUnitario) || other.precioUnitario == precioUnitario)&&(identical(other.totalLinea, totalLinea) || other.totalLinea == totalLinea));
}


@override
int get hashCode => Object.hash(runtimeType,orden,afectacion,cantidad,valorUnitario,valorBruto,descuento,valorVenta,valorReferencial,igv,precioUnitario,totalLinea);

@override
String toString() {
  return 'LineaCalculada(orden: $orden, afectacion: $afectacion, cantidad: $cantidad, valorUnitario: $valorUnitario, valorBruto: $valorBruto, descuento: $descuento, valorVenta: $valorVenta, valorReferencial: $valorReferencial, igv: $igv, precioUnitario: $precioUnitario, totalLinea: $totalLinea)';
}


}

/// @nodoc
abstract mixin class $LineaCalculadaCopyWith<$Res>  {
  factory $LineaCalculadaCopyWith(LineaCalculada value, $Res Function(LineaCalculada) _then) = _$LineaCalculadaCopyWithImpl;
@useResult
$Res call({
 int orden, TipoAfectacionIgv afectacion, double cantidad, double valorUnitario, double valorBruto, double descuento, double valorVenta, double valorReferencial, double igv, double precioUnitario, double totalLinea
});




}
/// @nodoc
class _$LineaCalculadaCopyWithImpl<$Res>
    implements $LineaCalculadaCopyWith<$Res> {
  _$LineaCalculadaCopyWithImpl(this._self, this._then);

  final LineaCalculada _self;
  final $Res Function(LineaCalculada) _then;

/// Create a copy of LineaCalculada
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orden = null,Object? afectacion = null,Object? cantidad = null,Object? valorUnitario = null,Object? valorBruto = null,Object? descuento = null,Object? valorVenta = null,Object? valorReferencial = null,Object? igv = null,Object? precioUnitario = null,Object? totalLinea = null,}) {
  return _then(_self.copyWith(
orden: null == orden ? _self.orden : orden // ignore: cast_nullable_to_non_nullable
as int,afectacion: null == afectacion ? _self.afectacion : afectacion // ignore: cast_nullable_to_non_nullable
as TipoAfectacionIgv,cantidad: null == cantidad ? _self.cantidad : cantidad // ignore: cast_nullable_to_non_nullable
as double,valorUnitario: null == valorUnitario ? _self.valorUnitario : valorUnitario // ignore: cast_nullable_to_non_nullable
as double,valorBruto: null == valorBruto ? _self.valorBruto : valorBruto // ignore: cast_nullable_to_non_nullable
as double,descuento: null == descuento ? _self.descuento : descuento // ignore: cast_nullable_to_non_nullable
as double,valorVenta: null == valorVenta ? _self.valorVenta : valorVenta // ignore: cast_nullable_to_non_nullable
as double,valorReferencial: null == valorReferencial ? _self.valorReferencial : valorReferencial // ignore: cast_nullable_to_non_nullable
as double,igv: null == igv ? _self.igv : igv // ignore: cast_nullable_to_non_nullable
as double,precioUnitario: null == precioUnitario ? _self.precioUnitario : precioUnitario // ignore: cast_nullable_to_non_nullable
as double,totalLinea: null == totalLinea ? _self.totalLinea : totalLinea // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LineaCalculada].
extension LineaCalculadaPatterns on LineaCalculada {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LineaCalculada value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LineaCalculada() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LineaCalculada value)  $default,){
final _that = this;
switch (_that) {
case _LineaCalculada():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LineaCalculada value)?  $default,){
final _that = this;
switch (_that) {
case _LineaCalculada() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int orden,  TipoAfectacionIgv afectacion,  double cantidad,  double valorUnitario,  double valorBruto,  double descuento,  double valorVenta,  double valorReferencial,  double igv,  double precioUnitario,  double totalLinea)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LineaCalculada() when $default != null:
return $default(_that.orden,_that.afectacion,_that.cantidad,_that.valorUnitario,_that.valorBruto,_that.descuento,_that.valorVenta,_that.valorReferencial,_that.igv,_that.precioUnitario,_that.totalLinea);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int orden,  TipoAfectacionIgv afectacion,  double cantidad,  double valorUnitario,  double valorBruto,  double descuento,  double valorVenta,  double valorReferencial,  double igv,  double precioUnitario,  double totalLinea)  $default,) {final _that = this;
switch (_that) {
case _LineaCalculada():
return $default(_that.orden,_that.afectacion,_that.cantidad,_that.valorUnitario,_that.valorBruto,_that.descuento,_that.valorVenta,_that.valorReferencial,_that.igv,_that.precioUnitario,_that.totalLinea);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int orden,  TipoAfectacionIgv afectacion,  double cantidad,  double valorUnitario,  double valorBruto,  double descuento,  double valorVenta,  double valorReferencial,  double igv,  double precioUnitario,  double totalLinea)?  $default,) {final _that = this;
switch (_that) {
case _LineaCalculada() when $default != null:
return $default(_that.orden,_that.afectacion,_that.cantidad,_that.valorUnitario,_that.valorBruto,_that.descuento,_that.valorVenta,_that.valorReferencial,_that.igv,_that.precioUnitario,_that.totalLinea);case _:
  return null;

}
}

}

/// @nodoc


class _LineaCalculada extends LineaCalculada {
  const _LineaCalculada({required this.orden, required this.afectacion, required this.cantidad, required this.valorUnitario, required this.valorBruto, required this.descuento, required this.valorVenta, required this.valorReferencial, required this.igv, required this.precioUnitario, required this.totalLinea}): super._();
  

@override final  int orden;
@override final  TipoAfectacionIgv afectacion;
@override final  double cantidad;
/// Valor unitario sin IGV tal como lo capturó el usuario.
@override final  double valorUnitario;
/// `cantidad × valorUnitario`, antes de aplicar el descuento.
@override final  double valorBruto;
@override final  double descuento;
/// Base imponible de la línea (`cbc:LineExtensionAmount`).
/// Vale 0 en las entregas gratuitas.
@override final  double valorVenta;
/// Valor referencial de las entregas gratuitas. Vale 0 en el resto.
@override final  double valorReferencial;
/// IGV de la línea. En las gratuitas se informa pero no se cobra.
@override final  double igv;
/// Precio unitario con IGV incluido (`cac:AlternativeConditionPrice`).
@override final  double precioUnitario;
/// Importe que ve el usuario en la fila: base + IGV. Vale 0 si es gratuita.
@override final  double totalLinea;

/// Create a copy of LineaCalculada
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LineaCalculadaCopyWith<_LineaCalculada> get copyWith => __$LineaCalculadaCopyWithImpl<_LineaCalculada>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LineaCalculada&&(identical(other.orden, orden) || other.orden == orden)&&(identical(other.afectacion, afectacion) || other.afectacion == afectacion)&&(identical(other.cantidad, cantidad) || other.cantidad == cantidad)&&(identical(other.valorUnitario, valorUnitario) || other.valorUnitario == valorUnitario)&&(identical(other.valorBruto, valorBruto) || other.valorBruto == valorBruto)&&(identical(other.descuento, descuento) || other.descuento == descuento)&&(identical(other.valorVenta, valorVenta) || other.valorVenta == valorVenta)&&(identical(other.valorReferencial, valorReferencial) || other.valorReferencial == valorReferencial)&&(identical(other.igv, igv) || other.igv == igv)&&(identical(other.precioUnitario, precioUnitario) || other.precioUnitario == precioUnitario)&&(identical(other.totalLinea, totalLinea) || other.totalLinea == totalLinea));
}


@override
int get hashCode => Object.hash(runtimeType,orden,afectacion,cantidad,valorUnitario,valorBruto,descuento,valorVenta,valorReferencial,igv,precioUnitario,totalLinea);

@override
String toString() {
  return 'LineaCalculada(orden: $orden, afectacion: $afectacion, cantidad: $cantidad, valorUnitario: $valorUnitario, valorBruto: $valorBruto, descuento: $descuento, valorVenta: $valorVenta, valorReferencial: $valorReferencial, igv: $igv, precioUnitario: $precioUnitario, totalLinea: $totalLinea)';
}


}

/// @nodoc
abstract mixin class _$LineaCalculadaCopyWith<$Res> implements $LineaCalculadaCopyWith<$Res> {
  factory _$LineaCalculadaCopyWith(_LineaCalculada value, $Res Function(_LineaCalculada) _then) = __$LineaCalculadaCopyWithImpl;
@override @useResult
$Res call({
 int orden, TipoAfectacionIgv afectacion, double cantidad, double valorUnitario, double valorBruto, double descuento, double valorVenta, double valorReferencial, double igv, double precioUnitario, double totalLinea
});




}
/// @nodoc
class __$LineaCalculadaCopyWithImpl<$Res>
    implements _$LineaCalculadaCopyWith<$Res> {
  __$LineaCalculadaCopyWithImpl(this._self, this._then);

  final _LineaCalculada _self;
  final $Res Function(_LineaCalculada) _then;

/// Create a copy of LineaCalculada
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orden = null,Object? afectacion = null,Object? cantidad = null,Object? valorUnitario = null,Object? valorBruto = null,Object? descuento = null,Object? valorVenta = null,Object? valorReferencial = null,Object? igv = null,Object? precioUnitario = null,Object? totalLinea = null,}) {
  return _then(_LineaCalculada(
orden: null == orden ? _self.orden : orden // ignore: cast_nullable_to_non_nullable
as int,afectacion: null == afectacion ? _self.afectacion : afectacion // ignore: cast_nullable_to_non_nullable
as TipoAfectacionIgv,cantidad: null == cantidad ? _self.cantidad : cantidad // ignore: cast_nullable_to_non_nullable
as double,valorUnitario: null == valorUnitario ? _self.valorUnitario : valorUnitario // ignore: cast_nullable_to_non_nullable
as double,valorBruto: null == valorBruto ? _self.valorBruto : valorBruto // ignore: cast_nullable_to_non_nullable
as double,descuento: null == descuento ? _self.descuento : descuento // ignore: cast_nullable_to_non_nullable
as double,valorVenta: null == valorVenta ? _self.valorVenta : valorVenta // ignore: cast_nullable_to_non_nullable
as double,valorReferencial: null == valorReferencial ? _self.valorReferencial : valorReferencial // ignore: cast_nullable_to_non_nullable
as double,igv: null == igv ? _self.igv : igv // ignore: cast_nullable_to_non_nullable
as double,precioUnitario: null == precioUnitario ? _self.precioUnitario : precioUnitario // ignore: cast_nullable_to_non_nullable
as double,totalLinea: null == totalLinea ? _self.totalLinea : totalLinea // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$Totales {

 double get opGravadas; double get opExoneradas; double get opInafectas; double get opExportacion; double get opGratuitas; double get totalIgv;/// IGV informativo de las entregas gratuitas (no forma parte del total).
 double get totalIgvGratuitas; double get totalDescuentos;/// Suma de las bases imponibles onerosas (`cbc:LineExtensionAmount`).
 double get totalValorVenta;/// Importe a pagar (`cbc:PayableAmount`).
 double get importeTotal; String get totalEnLetras; List<LineaCalculada> get lineas;
/// Create a copy of Totales
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TotalesCopyWith<Totales> get copyWith => _$TotalesCopyWithImpl<Totales>(this as Totales, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Totales&&(identical(other.opGravadas, opGravadas) || other.opGravadas == opGravadas)&&(identical(other.opExoneradas, opExoneradas) || other.opExoneradas == opExoneradas)&&(identical(other.opInafectas, opInafectas) || other.opInafectas == opInafectas)&&(identical(other.opExportacion, opExportacion) || other.opExportacion == opExportacion)&&(identical(other.opGratuitas, opGratuitas) || other.opGratuitas == opGratuitas)&&(identical(other.totalIgv, totalIgv) || other.totalIgv == totalIgv)&&(identical(other.totalIgvGratuitas, totalIgvGratuitas) || other.totalIgvGratuitas == totalIgvGratuitas)&&(identical(other.totalDescuentos, totalDescuentos) || other.totalDescuentos == totalDescuentos)&&(identical(other.totalValorVenta, totalValorVenta) || other.totalValorVenta == totalValorVenta)&&(identical(other.importeTotal, importeTotal) || other.importeTotal == importeTotal)&&(identical(other.totalEnLetras, totalEnLetras) || other.totalEnLetras == totalEnLetras)&&const DeepCollectionEquality().equals(other.lineas, lineas));
}


@override
int get hashCode => Object.hash(runtimeType,opGravadas,opExoneradas,opInafectas,opExportacion,opGratuitas,totalIgv,totalIgvGratuitas,totalDescuentos,totalValorVenta,importeTotal,totalEnLetras,const DeepCollectionEquality().hash(lineas));

@override
String toString() {
  return 'Totales(opGravadas: $opGravadas, opExoneradas: $opExoneradas, opInafectas: $opInafectas, opExportacion: $opExportacion, opGratuitas: $opGratuitas, totalIgv: $totalIgv, totalIgvGratuitas: $totalIgvGratuitas, totalDescuentos: $totalDescuentos, totalValorVenta: $totalValorVenta, importeTotal: $importeTotal, totalEnLetras: $totalEnLetras, lineas: $lineas)';
}


}

/// @nodoc
abstract mixin class $TotalesCopyWith<$Res>  {
  factory $TotalesCopyWith(Totales value, $Res Function(Totales) _then) = _$TotalesCopyWithImpl;
@useResult
$Res call({
 double opGravadas, double opExoneradas, double opInafectas, double opExportacion, double opGratuitas, double totalIgv, double totalIgvGratuitas, double totalDescuentos, double totalValorVenta, double importeTotal, String totalEnLetras, List<LineaCalculada> lineas
});




}
/// @nodoc
class _$TotalesCopyWithImpl<$Res>
    implements $TotalesCopyWith<$Res> {
  _$TotalesCopyWithImpl(this._self, this._then);

  final Totales _self;
  final $Res Function(Totales) _then;

/// Create a copy of Totales
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? opGravadas = null,Object? opExoneradas = null,Object? opInafectas = null,Object? opExportacion = null,Object? opGratuitas = null,Object? totalIgv = null,Object? totalIgvGratuitas = null,Object? totalDescuentos = null,Object? totalValorVenta = null,Object? importeTotal = null,Object? totalEnLetras = null,Object? lineas = null,}) {
  return _then(_self.copyWith(
opGravadas: null == opGravadas ? _self.opGravadas : opGravadas // ignore: cast_nullable_to_non_nullable
as double,opExoneradas: null == opExoneradas ? _self.opExoneradas : opExoneradas // ignore: cast_nullable_to_non_nullable
as double,opInafectas: null == opInafectas ? _self.opInafectas : opInafectas // ignore: cast_nullable_to_non_nullable
as double,opExportacion: null == opExportacion ? _self.opExportacion : opExportacion // ignore: cast_nullable_to_non_nullable
as double,opGratuitas: null == opGratuitas ? _self.opGratuitas : opGratuitas // ignore: cast_nullable_to_non_nullable
as double,totalIgv: null == totalIgv ? _self.totalIgv : totalIgv // ignore: cast_nullable_to_non_nullable
as double,totalIgvGratuitas: null == totalIgvGratuitas ? _self.totalIgvGratuitas : totalIgvGratuitas // ignore: cast_nullable_to_non_nullable
as double,totalDescuentos: null == totalDescuentos ? _self.totalDescuentos : totalDescuentos // ignore: cast_nullable_to_non_nullable
as double,totalValorVenta: null == totalValorVenta ? _self.totalValorVenta : totalValorVenta // ignore: cast_nullable_to_non_nullable
as double,importeTotal: null == importeTotal ? _self.importeTotal : importeTotal // ignore: cast_nullable_to_non_nullable
as double,totalEnLetras: null == totalEnLetras ? _self.totalEnLetras : totalEnLetras // ignore: cast_nullable_to_non_nullable
as String,lineas: null == lineas ? _self.lineas : lineas // ignore: cast_nullable_to_non_nullable
as List<LineaCalculada>,
  ));
}

}


/// Adds pattern-matching-related methods to [Totales].
extension TotalesPatterns on Totales {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Totales value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Totales() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Totales value)  $default,){
final _that = this;
switch (_that) {
case _Totales():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Totales value)?  $default,){
final _that = this;
switch (_that) {
case _Totales() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double opGravadas,  double opExoneradas,  double opInafectas,  double opExportacion,  double opGratuitas,  double totalIgv,  double totalIgvGratuitas,  double totalDescuentos,  double totalValorVenta,  double importeTotal,  String totalEnLetras,  List<LineaCalculada> lineas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Totales() when $default != null:
return $default(_that.opGravadas,_that.opExoneradas,_that.opInafectas,_that.opExportacion,_that.opGratuitas,_that.totalIgv,_that.totalIgvGratuitas,_that.totalDescuentos,_that.totalValorVenta,_that.importeTotal,_that.totalEnLetras,_that.lineas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double opGravadas,  double opExoneradas,  double opInafectas,  double opExportacion,  double opGratuitas,  double totalIgv,  double totalIgvGratuitas,  double totalDescuentos,  double totalValorVenta,  double importeTotal,  String totalEnLetras,  List<LineaCalculada> lineas)  $default,) {final _that = this;
switch (_that) {
case _Totales():
return $default(_that.opGravadas,_that.opExoneradas,_that.opInafectas,_that.opExportacion,_that.opGratuitas,_that.totalIgv,_that.totalIgvGratuitas,_that.totalDescuentos,_that.totalValorVenta,_that.importeTotal,_that.totalEnLetras,_that.lineas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double opGravadas,  double opExoneradas,  double opInafectas,  double opExportacion,  double opGratuitas,  double totalIgv,  double totalIgvGratuitas,  double totalDescuentos,  double totalValorVenta,  double importeTotal,  String totalEnLetras,  List<LineaCalculada> lineas)?  $default,) {final _that = this;
switch (_that) {
case _Totales() when $default != null:
return $default(_that.opGravadas,_that.opExoneradas,_that.opInafectas,_that.opExportacion,_that.opGratuitas,_that.totalIgv,_that.totalIgvGratuitas,_that.totalDescuentos,_that.totalValorVenta,_that.importeTotal,_that.totalEnLetras,_that.lineas);case _:
  return null;

}
}

}

/// @nodoc


class _Totales extends Totales {
  const _Totales({this.opGravadas = 0.0, this.opExoneradas = 0.0, this.opInafectas = 0.0, this.opExportacion = 0.0, this.opGratuitas = 0.0, this.totalIgv = 0.0, this.totalIgvGratuitas = 0.0, this.totalDescuentos = 0.0, this.totalValorVenta = 0.0, this.importeTotal = 0.0, this.totalEnLetras = '', final  List<LineaCalculada> lineas = const <LineaCalculada>[]}): _lineas = lineas,super._();
  

@override@JsonKey() final  double opGravadas;
@override@JsonKey() final  double opExoneradas;
@override@JsonKey() final  double opInafectas;
@override@JsonKey() final  double opExportacion;
@override@JsonKey() final  double opGratuitas;
@override@JsonKey() final  double totalIgv;
/// IGV informativo de las entregas gratuitas (no forma parte del total).
@override@JsonKey() final  double totalIgvGratuitas;
@override@JsonKey() final  double totalDescuentos;
/// Suma de las bases imponibles onerosas (`cbc:LineExtensionAmount`).
@override@JsonKey() final  double totalValorVenta;
/// Importe a pagar (`cbc:PayableAmount`).
@override@JsonKey() final  double importeTotal;
@override@JsonKey() final  String totalEnLetras;
 final  List<LineaCalculada> _lineas;
@override@JsonKey() List<LineaCalculada> get lineas {
  if (_lineas is EqualUnmodifiableListView) return _lineas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lineas);
}


/// Create a copy of Totales
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TotalesCopyWith<_Totales> get copyWith => __$TotalesCopyWithImpl<_Totales>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Totales&&(identical(other.opGravadas, opGravadas) || other.opGravadas == opGravadas)&&(identical(other.opExoneradas, opExoneradas) || other.opExoneradas == opExoneradas)&&(identical(other.opInafectas, opInafectas) || other.opInafectas == opInafectas)&&(identical(other.opExportacion, opExportacion) || other.opExportacion == opExportacion)&&(identical(other.opGratuitas, opGratuitas) || other.opGratuitas == opGratuitas)&&(identical(other.totalIgv, totalIgv) || other.totalIgv == totalIgv)&&(identical(other.totalIgvGratuitas, totalIgvGratuitas) || other.totalIgvGratuitas == totalIgvGratuitas)&&(identical(other.totalDescuentos, totalDescuentos) || other.totalDescuentos == totalDescuentos)&&(identical(other.totalValorVenta, totalValorVenta) || other.totalValorVenta == totalValorVenta)&&(identical(other.importeTotal, importeTotal) || other.importeTotal == importeTotal)&&(identical(other.totalEnLetras, totalEnLetras) || other.totalEnLetras == totalEnLetras)&&const DeepCollectionEquality().equals(other._lineas, _lineas));
}


@override
int get hashCode => Object.hash(runtimeType,opGravadas,opExoneradas,opInafectas,opExportacion,opGratuitas,totalIgv,totalIgvGratuitas,totalDescuentos,totalValorVenta,importeTotal,totalEnLetras,const DeepCollectionEquality().hash(_lineas));

@override
String toString() {
  return 'Totales(opGravadas: $opGravadas, opExoneradas: $opExoneradas, opInafectas: $opInafectas, opExportacion: $opExportacion, opGratuitas: $opGratuitas, totalIgv: $totalIgv, totalIgvGratuitas: $totalIgvGratuitas, totalDescuentos: $totalDescuentos, totalValorVenta: $totalValorVenta, importeTotal: $importeTotal, totalEnLetras: $totalEnLetras, lineas: $lineas)';
}


}

/// @nodoc
abstract mixin class _$TotalesCopyWith<$Res> implements $TotalesCopyWith<$Res> {
  factory _$TotalesCopyWith(_Totales value, $Res Function(_Totales) _then) = __$TotalesCopyWithImpl;
@override @useResult
$Res call({
 double opGravadas, double opExoneradas, double opInafectas, double opExportacion, double opGratuitas, double totalIgv, double totalIgvGratuitas, double totalDescuentos, double totalValorVenta, double importeTotal, String totalEnLetras, List<LineaCalculada> lineas
});




}
/// @nodoc
class __$TotalesCopyWithImpl<$Res>
    implements _$TotalesCopyWith<$Res> {
  __$TotalesCopyWithImpl(this._self, this._then);

  final _Totales _self;
  final $Res Function(_Totales) _then;

/// Create a copy of Totales
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? opGravadas = null,Object? opExoneradas = null,Object? opInafectas = null,Object? opExportacion = null,Object? opGratuitas = null,Object? totalIgv = null,Object? totalIgvGratuitas = null,Object? totalDescuentos = null,Object? totalValorVenta = null,Object? importeTotal = null,Object? totalEnLetras = null,Object? lineas = null,}) {
  return _then(_Totales(
opGravadas: null == opGravadas ? _self.opGravadas : opGravadas // ignore: cast_nullable_to_non_nullable
as double,opExoneradas: null == opExoneradas ? _self.opExoneradas : opExoneradas // ignore: cast_nullable_to_non_nullable
as double,opInafectas: null == opInafectas ? _self.opInafectas : opInafectas // ignore: cast_nullable_to_non_nullable
as double,opExportacion: null == opExportacion ? _self.opExportacion : opExportacion // ignore: cast_nullable_to_non_nullable
as double,opGratuitas: null == opGratuitas ? _self.opGratuitas : opGratuitas // ignore: cast_nullable_to_non_nullable
as double,totalIgv: null == totalIgv ? _self.totalIgv : totalIgv // ignore: cast_nullable_to_non_nullable
as double,totalIgvGratuitas: null == totalIgvGratuitas ? _self.totalIgvGratuitas : totalIgvGratuitas // ignore: cast_nullable_to_non_nullable
as double,totalDescuentos: null == totalDescuentos ? _self.totalDescuentos : totalDescuentos // ignore: cast_nullable_to_non_nullable
as double,totalValorVenta: null == totalValorVenta ? _self.totalValorVenta : totalValorVenta // ignore: cast_nullable_to_non_nullable
as double,importeTotal: null == importeTotal ? _self.importeTotal : importeTotal // ignore: cast_nullable_to_non_nullable
as double,totalEnLetras: null == totalEnLetras ? _self.totalEnLetras : totalEnLetras // ignore: cast_nullable_to_non_nullable
as String,lineas: null == lineas ? _self._lineas : lineas // ignore: cast_nullable_to_non_nullable
as List<LineaCalculada>,
  ));
}


}

// dart format on
