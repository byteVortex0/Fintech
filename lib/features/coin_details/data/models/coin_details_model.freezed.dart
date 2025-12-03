// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coin_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CoinDetailsModel {

 String get name; String get price; String get pricePerUnit; String get changePercent; bool get isPositive; String get svgIconPath; String get currentPrice; String get marketCap; String get volume24h; String get availableSupply; String get maxSupply; String get description;
/// Create a copy of CoinDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoinDetailsModelCopyWith<CoinDetailsModel> get copyWith => _$CoinDetailsModelCopyWithImpl<CoinDetailsModel>(this as CoinDetailsModel, _$identity);

  /// Serializes this CoinDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoinDetailsModel&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.pricePerUnit, pricePerUnit) || other.pricePerUnit == pricePerUnit)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.isPositive, isPositive) || other.isPositive == isPositive)&&(identical(other.svgIconPath, svgIconPath) || other.svgIconPath == svgIconPath)&&(identical(other.currentPrice, currentPrice) || other.currentPrice == currentPrice)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.volume24h, volume24h) || other.volume24h == volume24h)&&(identical(other.availableSupply, availableSupply) || other.availableSupply == availableSupply)&&(identical(other.maxSupply, maxSupply) || other.maxSupply == maxSupply)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,price,pricePerUnit,changePercent,isPositive,svgIconPath,currentPrice,marketCap,volume24h,availableSupply,maxSupply,description);

@override
String toString() {
  return 'CoinDetailsModel(name: $name, price: $price, pricePerUnit: $pricePerUnit, changePercent: $changePercent, isPositive: $isPositive, svgIconPath: $svgIconPath, currentPrice: $currentPrice, marketCap: $marketCap, volume24h: $volume24h, availableSupply: $availableSupply, maxSupply: $maxSupply, description: $description)';
}


}

/// @nodoc
abstract mixin class $CoinDetailsModelCopyWith<$Res>  {
  factory $CoinDetailsModelCopyWith(CoinDetailsModel value, $Res Function(CoinDetailsModel) _then) = _$CoinDetailsModelCopyWithImpl;
@useResult
$Res call({
 String name, String price, String pricePerUnit, String changePercent, bool isPositive, String svgIconPath, String currentPrice, String marketCap, String volume24h, String availableSupply, String maxSupply, String description
});




}
/// @nodoc
class _$CoinDetailsModelCopyWithImpl<$Res>
    implements $CoinDetailsModelCopyWith<$Res> {
  _$CoinDetailsModelCopyWithImpl(this._self, this._then);

  final CoinDetailsModel _self;
  final $Res Function(CoinDetailsModel) _then;

/// Create a copy of CoinDetailsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? price = null,Object? pricePerUnit = null,Object? changePercent = null,Object? isPositive = null,Object? svgIconPath = null,Object? currentPrice = null,Object? marketCap = null,Object? volume24h = null,Object? availableSupply = null,Object? maxSupply = null,Object? description = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,pricePerUnit: null == pricePerUnit ? _self.pricePerUnit : pricePerUnit // ignore: cast_nullable_to_non_nullable
as String,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as String,isPositive: null == isPositive ? _self.isPositive : isPositive // ignore: cast_nullable_to_non_nullable
as bool,svgIconPath: null == svgIconPath ? _self.svgIconPath : svgIconPath // ignore: cast_nullable_to_non_nullable
as String,currentPrice: null == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as String,marketCap: null == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as String,volume24h: null == volume24h ? _self.volume24h : volume24h // ignore: cast_nullable_to_non_nullable
as String,availableSupply: null == availableSupply ? _self.availableSupply : availableSupply // ignore: cast_nullable_to_non_nullable
as String,maxSupply: null == maxSupply ? _self.maxSupply : maxSupply // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CoinDetailsModel].
extension CoinDetailsModelPatterns on CoinDetailsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoinDetailsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoinDetailsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoinDetailsModel value)  $default,){
final _that = this;
switch (_that) {
case _CoinDetailsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoinDetailsModel value)?  $default,){
final _that = this;
switch (_that) {
case _CoinDetailsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String price,  String pricePerUnit,  String changePercent,  bool isPositive,  String svgIconPath,  String currentPrice,  String marketCap,  String volume24h,  String availableSupply,  String maxSupply,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoinDetailsModel() when $default != null:
return $default(_that.name,_that.price,_that.pricePerUnit,_that.changePercent,_that.isPositive,_that.svgIconPath,_that.currentPrice,_that.marketCap,_that.volume24h,_that.availableSupply,_that.maxSupply,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String price,  String pricePerUnit,  String changePercent,  bool isPositive,  String svgIconPath,  String currentPrice,  String marketCap,  String volume24h,  String availableSupply,  String maxSupply,  String description)  $default,) {final _that = this;
switch (_that) {
case _CoinDetailsModel():
return $default(_that.name,_that.price,_that.pricePerUnit,_that.changePercent,_that.isPositive,_that.svgIconPath,_that.currentPrice,_that.marketCap,_that.volume24h,_that.availableSupply,_that.maxSupply,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String price,  String pricePerUnit,  String changePercent,  bool isPositive,  String svgIconPath,  String currentPrice,  String marketCap,  String volume24h,  String availableSupply,  String maxSupply,  String description)?  $default,) {final _that = this;
switch (_that) {
case _CoinDetailsModel() when $default != null:
return $default(_that.name,_that.price,_that.pricePerUnit,_that.changePercent,_that.isPositive,_that.svgIconPath,_that.currentPrice,_that.marketCap,_that.volume24h,_that.availableSupply,_that.maxSupply,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoinDetailsModel implements CoinDetailsModel {
  const _CoinDetailsModel({required this.name, required this.price, required this.pricePerUnit, required this.changePercent, required this.isPositive, required this.svgIconPath, required this.currentPrice, required this.marketCap, required this.volume24h, required this.availableSupply, required this.maxSupply, required this.description});
  factory _CoinDetailsModel.fromJson(Map<String, dynamic> json) => _$CoinDetailsModelFromJson(json);

@override final  String name;
@override final  String price;
@override final  String pricePerUnit;
@override final  String changePercent;
@override final  bool isPositive;
@override final  String svgIconPath;
@override final  String currentPrice;
@override final  String marketCap;
@override final  String volume24h;
@override final  String availableSupply;
@override final  String maxSupply;
@override final  String description;

/// Create a copy of CoinDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoinDetailsModelCopyWith<_CoinDetailsModel> get copyWith => __$CoinDetailsModelCopyWithImpl<_CoinDetailsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoinDetailsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoinDetailsModel&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.pricePerUnit, pricePerUnit) || other.pricePerUnit == pricePerUnit)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.isPositive, isPositive) || other.isPositive == isPositive)&&(identical(other.svgIconPath, svgIconPath) || other.svgIconPath == svgIconPath)&&(identical(other.currentPrice, currentPrice) || other.currentPrice == currentPrice)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.volume24h, volume24h) || other.volume24h == volume24h)&&(identical(other.availableSupply, availableSupply) || other.availableSupply == availableSupply)&&(identical(other.maxSupply, maxSupply) || other.maxSupply == maxSupply)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,price,pricePerUnit,changePercent,isPositive,svgIconPath,currentPrice,marketCap,volume24h,availableSupply,maxSupply,description);

@override
String toString() {
  return 'CoinDetailsModel(name: $name, price: $price, pricePerUnit: $pricePerUnit, changePercent: $changePercent, isPositive: $isPositive, svgIconPath: $svgIconPath, currentPrice: $currentPrice, marketCap: $marketCap, volume24h: $volume24h, availableSupply: $availableSupply, maxSupply: $maxSupply, description: $description)';
}


}

/// @nodoc
abstract mixin class _$CoinDetailsModelCopyWith<$Res> implements $CoinDetailsModelCopyWith<$Res> {
  factory _$CoinDetailsModelCopyWith(_CoinDetailsModel value, $Res Function(_CoinDetailsModel) _then) = __$CoinDetailsModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String price, String pricePerUnit, String changePercent, bool isPositive, String svgIconPath, String currentPrice, String marketCap, String volume24h, String availableSupply, String maxSupply, String description
});




}
/// @nodoc
class __$CoinDetailsModelCopyWithImpl<$Res>
    implements _$CoinDetailsModelCopyWith<$Res> {
  __$CoinDetailsModelCopyWithImpl(this._self, this._then);

  final _CoinDetailsModel _self;
  final $Res Function(_CoinDetailsModel) _then;

/// Create a copy of CoinDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? price = null,Object? pricePerUnit = null,Object? changePercent = null,Object? isPositive = null,Object? svgIconPath = null,Object? currentPrice = null,Object? marketCap = null,Object? volume24h = null,Object? availableSupply = null,Object? maxSupply = null,Object? description = null,}) {
  return _then(_CoinDetailsModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,pricePerUnit: null == pricePerUnit ? _self.pricePerUnit : pricePerUnit // ignore: cast_nullable_to_non_nullable
as String,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as String,isPositive: null == isPositive ? _self.isPositive : isPositive // ignore: cast_nullable_to_non_nullable
as bool,svgIconPath: null == svgIconPath ? _self.svgIconPath : svgIconPath // ignore: cast_nullable_to_non_nullable
as String,currentPrice: null == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as String,marketCap: null == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as String,volume24h: null == volume24h ? _self.volume24h : volume24h // ignore: cast_nullable_to_non_nullable
as String,availableSupply: null == availableSupply ? _self.availableSupply : availableSupply // ignore: cast_nullable_to_non_nullable
as String,maxSupply: null == maxSupply ? _self.maxSupply : maxSupply // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
