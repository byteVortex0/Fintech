// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coin_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CoinModel {

 String get coinName; String get ticker; String get price; String get change; String? get svgIconPath; IconData? get icon; Color? get iconColor;
/// Create a copy of CoinModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoinModelCopyWith<CoinModel> get copyWith => _$CoinModelCopyWithImpl<CoinModel>(this as CoinModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoinModel&&(identical(other.coinName, coinName) || other.coinName == coinName)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.price, price) || other.price == price)&&(identical(other.change, change) || other.change == change)&&(identical(other.svgIconPath, svgIconPath) || other.svgIconPath == svgIconPath)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconColor, iconColor) || other.iconColor == iconColor));
}


@override
int get hashCode => Object.hash(runtimeType,coinName,ticker,price,change,svgIconPath,icon,iconColor);

@override
String toString() {
  return 'CoinModel(coinName: $coinName, ticker: $ticker, price: $price, change: $change, svgIconPath: $svgIconPath, icon: $icon, iconColor: $iconColor)';
}


}

/// @nodoc
abstract mixin class $CoinModelCopyWith<$Res>  {
  factory $CoinModelCopyWith(CoinModel value, $Res Function(CoinModel) _then) = _$CoinModelCopyWithImpl;
@useResult
$Res call({
 String coinName, String ticker, String price, String change, String? svgIconPath, IconData? icon, Color? iconColor
});




}
/// @nodoc
class _$CoinModelCopyWithImpl<$Res>
    implements $CoinModelCopyWith<$Res> {
  _$CoinModelCopyWithImpl(this._self, this._then);

  final CoinModel _self;
  final $Res Function(CoinModel) _then;

/// Create a copy of CoinModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? coinName = null,Object? ticker = null,Object? price = null,Object? change = null,Object? svgIconPath = freezed,Object? icon = freezed,Object? iconColor = freezed,}) {
  return _then(_self.copyWith(
coinName: null == coinName ? _self.coinName : coinName // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,change: null == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as String,svgIconPath: freezed == svgIconPath ? _self.svgIconPath : svgIconPath // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData?,iconColor: freezed == iconColor ? _self.iconColor : iconColor // ignore: cast_nullable_to_non_nullable
as Color?,
  ));
}

}


/// Adds pattern-matching-related methods to [CoinModel].
extension CoinModelPatterns on CoinModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoinModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoinModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoinModel value)  $default,){
final _that = this;
switch (_that) {
case _CoinModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoinModel value)?  $default,){
final _that = this;
switch (_that) {
case _CoinModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String coinName,  String ticker,  String price,  String change,  String? svgIconPath,  IconData? icon,  Color? iconColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoinModel() when $default != null:
return $default(_that.coinName,_that.ticker,_that.price,_that.change,_that.svgIconPath,_that.icon,_that.iconColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String coinName,  String ticker,  String price,  String change,  String? svgIconPath,  IconData? icon,  Color? iconColor)  $default,) {final _that = this;
switch (_that) {
case _CoinModel():
return $default(_that.coinName,_that.ticker,_that.price,_that.change,_that.svgIconPath,_that.icon,_that.iconColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String coinName,  String ticker,  String price,  String change,  String? svgIconPath,  IconData? icon,  Color? iconColor)?  $default,) {final _that = this;
switch (_that) {
case _CoinModel() when $default != null:
return $default(_that.coinName,_that.ticker,_that.price,_that.change,_that.svgIconPath,_that.icon,_that.iconColor);case _:
  return null;

}
}

}

/// @nodoc


class _CoinModel implements CoinModel {
  const _CoinModel({required this.coinName, required this.ticker, required this.price, required this.change, this.svgIconPath, this.icon, this.iconColor});
  

@override final  String coinName;
@override final  String ticker;
@override final  String price;
@override final  String change;
@override final  String? svgIconPath;
@override final  IconData? icon;
@override final  Color? iconColor;

/// Create a copy of CoinModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoinModelCopyWith<_CoinModel> get copyWith => __$CoinModelCopyWithImpl<_CoinModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoinModel&&(identical(other.coinName, coinName) || other.coinName == coinName)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.price, price) || other.price == price)&&(identical(other.change, change) || other.change == change)&&(identical(other.svgIconPath, svgIconPath) || other.svgIconPath == svgIconPath)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconColor, iconColor) || other.iconColor == iconColor));
}


@override
int get hashCode => Object.hash(runtimeType,coinName,ticker,price,change,svgIconPath,icon,iconColor);

@override
String toString() {
  return 'CoinModel(coinName: $coinName, ticker: $ticker, price: $price, change: $change, svgIconPath: $svgIconPath, icon: $icon, iconColor: $iconColor)';
}


}

/// @nodoc
abstract mixin class _$CoinModelCopyWith<$Res> implements $CoinModelCopyWith<$Res> {
  factory _$CoinModelCopyWith(_CoinModel value, $Res Function(_CoinModel) _then) = __$CoinModelCopyWithImpl;
@override @useResult
$Res call({
 String coinName, String ticker, String price, String change, String? svgIconPath, IconData? icon, Color? iconColor
});




}
/// @nodoc
class __$CoinModelCopyWithImpl<$Res>
    implements _$CoinModelCopyWith<$Res> {
  __$CoinModelCopyWithImpl(this._self, this._then);

  final _CoinModel _self;
  final $Res Function(_CoinModel) _then;

/// Create a copy of CoinModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? coinName = null,Object? ticker = null,Object? price = null,Object? change = null,Object? svgIconPath = freezed,Object? icon = freezed,Object? iconColor = freezed,}) {
  return _then(_CoinModel(
coinName: null == coinName ? _self.coinName : coinName // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,change: null == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as String,svgIconPath: freezed == svgIconPath ? _self.svgIconPath : svgIconPath // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData?,iconColor: freezed == iconColor ? _self.iconColor : iconColor // ignore: cast_nullable_to_non_nullable
as Color?,
  ));
}


}

// dart format on
