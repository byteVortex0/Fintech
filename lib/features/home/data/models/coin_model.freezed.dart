// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coin_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CoinModel {
  String get coinName => throw _privateConstructorUsedError;
  String get ticker => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  String get change => throw _privateConstructorUsedError;
  String? get svgIconPath => throw _privateConstructorUsedError;
  IconData? get icon => throw _privateConstructorUsedError;
  Color? get iconColor => throw _privateConstructorUsedError;

  /// Create a copy of CoinModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoinModelCopyWith<CoinModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoinModelCopyWith<$Res> {
  factory $CoinModelCopyWith(CoinModel value, $Res Function(CoinModel) then) =
      _$CoinModelCopyWithImpl<$Res, CoinModel>;
  @useResult
  $Res call({
    String coinName,
    String ticker,
    String price,
    String change,
    String? svgIconPath,
    IconData? icon,
    Color? iconColor,
  });
}

/// @nodoc
class _$CoinModelCopyWithImpl<$Res, $Val extends CoinModel>
    implements $CoinModelCopyWith<$Res> {
  _$CoinModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoinModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coinName = null,
    Object? ticker = null,
    Object? price = null,
    Object? change = null,
    Object? svgIconPath = freezed,
    Object? icon = freezed,
    Object? iconColor = freezed,
  }) {
    return _then(
      _value.copyWith(
            coinName: null == coinName
                ? _value.coinName
                : coinName // ignore: cast_nullable_to_non_nullable
                      as String,
            ticker: null == ticker
                ? _value.ticker
                : ticker // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as String,
            change: null == change
                ? _value.change
                : change // ignore: cast_nullable_to_non_nullable
                      as String,
            svgIconPath: freezed == svgIconPath
                ? _value.svgIconPath
                : svgIconPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as IconData?,
            iconColor: freezed == iconColor
                ? _value.iconColor
                : iconColor // ignore: cast_nullable_to_non_nullable
                      as Color?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CoinModelImplCopyWith<$Res>
    implements $CoinModelCopyWith<$Res> {
  factory _$$CoinModelImplCopyWith(
    _$CoinModelImpl value,
    $Res Function(_$CoinModelImpl) then,
  ) = __$$CoinModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String coinName,
    String ticker,
    String price,
    String change,
    String? svgIconPath,
    IconData? icon,
    Color? iconColor,
  });
}

/// @nodoc
class __$$CoinModelImplCopyWithImpl<$Res>
    extends _$CoinModelCopyWithImpl<$Res, _$CoinModelImpl>
    implements _$$CoinModelImplCopyWith<$Res> {
  __$$CoinModelImplCopyWithImpl(
    _$CoinModelImpl _value,
    $Res Function(_$CoinModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CoinModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coinName = null,
    Object? ticker = null,
    Object? price = null,
    Object? change = null,
    Object? svgIconPath = freezed,
    Object? icon = freezed,
    Object? iconColor = freezed,
  }) {
    return _then(
      _$CoinModelImpl(
        coinName: null == coinName
            ? _value.coinName
            : coinName // ignore: cast_nullable_to_non_nullable
                  as String,
        ticker: null == ticker
            ? _value.ticker
            : ticker // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as String,
        change: null == change
            ? _value.change
            : change // ignore: cast_nullable_to_non_nullable
                  as String,
        svgIconPath: freezed == svgIconPath
            ? _value.svgIconPath
            : svgIconPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as IconData?,
        iconColor: freezed == iconColor
            ? _value.iconColor
            : iconColor // ignore: cast_nullable_to_non_nullable
                  as Color?,
      ),
    );
  }
}

/// @nodoc

class _$CoinModelImpl implements _CoinModel {
  const _$CoinModelImpl({
    required this.coinName,
    required this.ticker,
    required this.price,
    required this.change,
    this.svgIconPath,
    this.icon,
    this.iconColor,
  });

  @override
  final String coinName;
  @override
  final String ticker;
  @override
  final String price;
  @override
  final String change;
  @override
  final String? svgIconPath;
  @override
  final IconData? icon;
  @override
  final Color? iconColor;

  @override
  String toString() {
    return 'CoinModel(coinName: $coinName, ticker: $ticker, price: $price, change: $change, svgIconPath: $svgIconPath, icon: $icon, iconColor: $iconColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoinModelImpl &&
            (identical(other.coinName, coinName) ||
                other.coinName == coinName) &&
            (identical(other.ticker, ticker) || other.ticker == ticker) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.change, change) || other.change == change) &&
            (identical(other.svgIconPath, svgIconPath) ||
                other.svgIconPath == svgIconPath) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.iconColor, iconColor) ||
                other.iconColor == iconColor));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    coinName,
    ticker,
    price,
    change,
    svgIconPath,
    icon,
    iconColor,
  );

  /// Create a copy of CoinModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoinModelImplCopyWith<_$CoinModelImpl> get copyWith =>
      __$$CoinModelImplCopyWithImpl<_$CoinModelImpl>(this, _$identity);
}

abstract class _CoinModel implements CoinModel {
  const factory _CoinModel({
    required final String coinName,
    required final String ticker,
    required final String price,
    required final String change,
    final String? svgIconPath,
    final IconData? icon,
    final Color? iconColor,
  }) = _$CoinModelImpl;

  @override
  String get coinName;
  @override
  String get ticker;
  @override
  String get price;
  @override
  String get change;
  @override
  String? get svgIconPath;
  @override
  IconData? get icon;
  @override
  Color? get iconColor;

  /// Create a copy of CoinModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoinModelImplCopyWith<_$CoinModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
