// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_coin_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MarketCoinModel {
  String get name => throw _privateConstructorUsedError;
  String get rank => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  String get changePercent => throw _privateConstructorUsedError;
  String? get svgIconPath => throw _privateConstructorUsedError;

  /// Create a copy of MarketCoinModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarketCoinModelCopyWith<MarketCoinModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketCoinModelCopyWith<$Res> {
  factory $MarketCoinModelCopyWith(
    MarketCoinModel value,
    $Res Function(MarketCoinModel) then,
  ) = _$MarketCoinModelCopyWithImpl<$Res, MarketCoinModel>;
  @useResult
  $Res call({
    String name,
    String rank,
    String price,
    String changePercent,
    String? svgIconPath,
  });
}

/// @nodoc
class _$MarketCoinModelCopyWithImpl<$Res, $Val extends MarketCoinModel>
    implements $MarketCoinModelCopyWith<$Res> {
  _$MarketCoinModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarketCoinModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? rank = null,
    Object? price = null,
    Object? changePercent = null,
    Object? svgIconPath = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as String,
            changePercent: null == changePercent
                ? _value.changePercent
                : changePercent // ignore: cast_nullable_to_non_nullable
                      as String,
            svgIconPath: freezed == svgIconPath
                ? _value.svgIconPath
                : svgIconPath // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MarketCoinModelImplCopyWith<$Res>
    implements $MarketCoinModelCopyWith<$Res> {
  factory _$$MarketCoinModelImplCopyWith(
    _$MarketCoinModelImpl value,
    $Res Function(_$MarketCoinModelImpl) then,
  ) = __$$MarketCoinModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String rank,
    String price,
    String changePercent,
    String? svgIconPath,
  });
}

/// @nodoc
class __$$MarketCoinModelImplCopyWithImpl<$Res>
    extends _$MarketCoinModelCopyWithImpl<$Res, _$MarketCoinModelImpl>
    implements _$$MarketCoinModelImplCopyWith<$Res> {
  __$$MarketCoinModelImplCopyWithImpl(
    _$MarketCoinModelImpl _value,
    $Res Function(_$MarketCoinModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketCoinModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? rank = null,
    Object? price = null,
    Object? changePercent = null,
    Object? svgIconPath = freezed,
  }) {
    return _then(
      _$MarketCoinModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as String,
        changePercent: null == changePercent
            ? _value.changePercent
            : changePercent // ignore: cast_nullable_to_non_nullable
                  as String,
        svgIconPath: freezed == svgIconPath
            ? _value.svgIconPath
            : svgIconPath // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$MarketCoinModelImpl implements _MarketCoinModel {
  const _$MarketCoinModelImpl({
    required this.name,
    required this.rank,
    required this.price,
    required this.changePercent,
    this.svgIconPath,
  });

  @override
  final String name;
  @override
  final String rank;
  @override
  final String price;
  @override
  final String changePercent;
  @override
  final String? svgIconPath;

  @override
  String toString() {
    return 'MarketCoinModel(name: $name, rank: $rank, price: $price, changePercent: $changePercent, svgIconPath: $svgIconPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketCoinModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.changePercent, changePercent) ||
                other.changePercent == changePercent) &&
            (identical(other.svgIconPath, svgIconPath) ||
                other.svgIconPath == svgIconPath));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, rank, price, changePercent, svgIconPath);

  /// Create a copy of MarketCoinModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketCoinModelImplCopyWith<_$MarketCoinModelImpl> get copyWith =>
      __$$MarketCoinModelImplCopyWithImpl<_$MarketCoinModelImpl>(
        this,
        _$identity,
      );
}

abstract class _MarketCoinModel implements MarketCoinModel {
  const factory _MarketCoinModel({
    required final String name,
    required final String rank,
    required final String price,
    required final String changePercent,
    final String? svgIconPath,
  }) = _$MarketCoinModelImpl;

  @override
  String get name;
  @override
  String get rank;
  @override
  String get price;
  @override
  String get changePercent;
  @override
  String? get svgIconPath;

  /// Create a copy of MarketCoinModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarketCoinModelImplCopyWith<_$MarketCoinModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
