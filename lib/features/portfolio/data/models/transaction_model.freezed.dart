// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TransactionModel {
  String get type => throw _privateConstructorUsedError;
  String get coinName => throw _privateConstructorUsedError;
  String get timeAgo => throw _privateConstructorUsedError;
  String get svgIconPath => throw _privateConstructorUsedError;
  String get cryptoAmount => throw _privateConstructorUsedError;
  String get dollarValue => throw _privateConstructorUsedError;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionModelCopyWith<TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionModelCopyWith<$Res> {
  factory $TransactionModelCopyWith(
    TransactionModel value,
    $Res Function(TransactionModel) then,
  ) = _$TransactionModelCopyWithImpl<$Res, TransactionModel>;
  @useResult
  $Res call({
    String type,
    String coinName,
    String timeAgo,
    String svgIconPath,
    String cryptoAmount,
    String dollarValue,
  });
}

/// @nodoc
class _$TransactionModelCopyWithImpl<$Res, $Val extends TransactionModel>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? coinName = null,
    Object? timeAgo = null,
    Object? svgIconPath = null,
    Object? cryptoAmount = null,
    Object? dollarValue = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            coinName: null == coinName
                ? _value.coinName
                : coinName // ignore: cast_nullable_to_non_nullable
                      as String,
            timeAgo: null == timeAgo
                ? _value.timeAgo
                : timeAgo // ignore: cast_nullable_to_non_nullable
                      as String,
            svgIconPath: null == svgIconPath
                ? _value.svgIconPath
                : svgIconPath // ignore: cast_nullable_to_non_nullable
                      as String,
            cryptoAmount: null == cryptoAmount
                ? _value.cryptoAmount
                : cryptoAmount // ignore: cast_nullable_to_non_nullable
                      as String,
            dollarValue: null == dollarValue
                ? _value.dollarValue
                : dollarValue // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransactionModelImplCopyWith<$Res>
    implements $TransactionModelCopyWith<$Res> {
  factory _$$TransactionModelImplCopyWith(
    _$TransactionModelImpl value,
    $Res Function(_$TransactionModelImpl) then,
  ) = __$$TransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    String coinName,
    String timeAgo,
    String svgIconPath,
    String cryptoAmount,
    String dollarValue,
  });
}

/// @nodoc
class __$$TransactionModelImplCopyWithImpl<$Res>
    extends _$TransactionModelCopyWithImpl<$Res, _$TransactionModelImpl>
    implements _$$TransactionModelImplCopyWith<$Res> {
  __$$TransactionModelImplCopyWithImpl(
    _$TransactionModelImpl _value,
    $Res Function(_$TransactionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? coinName = null,
    Object? timeAgo = null,
    Object? svgIconPath = null,
    Object? cryptoAmount = null,
    Object? dollarValue = null,
  }) {
    return _then(
      _$TransactionModelImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        coinName: null == coinName
            ? _value.coinName
            : coinName // ignore: cast_nullable_to_non_nullable
                  as String,
        timeAgo: null == timeAgo
            ? _value.timeAgo
            : timeAgo // ignore: cast_nullable_to_non_nullable
                  as String,
        svgIconPath: null == svgIconPath
            ? _value.svgIconPath
            : svgIconPath // ignore: cast_nullable_to_non_nullable
                  as String,
        cryptoAmount: null == cryptoAmount
            ? _value.cryptoAmount
            : cryptoAmount // ignore: cast_nullable_to_non_nullable
                  as String,
        dollarValue: null == dollarValue
            ? _value.dollarValue
            : dollarValue // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$TransactionModelImpl implements _TransactionModel {
  const _$TransactionModelImpl({
    required this.type,
    required this.coinName,
    required this.timeAgo,
    required this.svgIconPath,
    required this.cryptoAmount,
    required this.dollarValue,
  });

  @override
  final String type;
  @override
  final String coinName;
  @override
  final String timeAgo;
  @override
  final String svgIconPath;
  @override
  final String cryptoAmount;
  @override
  final String dollarValue;

  @override
  String toString() {
    return 'TransactionModel(type: $type, coinName: $coinName, timeAgo: $timeAgo, svgIconPath: $svgIconPath, cryptoAmount: $cryptoAmount, dollarValue: $dollarValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionModelImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.coinName, coinName) ||
                other.coinName == coinName) &&
            (identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo) &&
            (identical(other.svgIconPath, svgIconPath) ||
                other.svgIconPath == svgIconPath) &&
            (identical(other.cryptoAmount, cryptoAmount) ||
                other.cryptoAmount == cryptoAmount) &&
            (identical(other.dollarValue, dollarValue) ||
                other.dollarValue == dollarValue));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    coinName,
    timeAgo,
    svgIconPath,
    cryptoAmount,
    dollarValue,
  );

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      __$$TransactionModelImplCopyWithImpl<_$TransactionModelImpl>(
        this,
        _$identity,
      );
}

abstract class _TransactionModel implements TransactionModel {
  const factory _TransactionModel({
    required final String type,
    required final String coinName,
    required final String timeAgo,
    required final String svgIconPath,
    required final String cryptoAmount,
    required final String dollarValue,
  }) = _$TransactionModelImpl;

  @override
  String get type;
  @override
  String get coinName;
  @override
  String get timeAgo;
  @override
  String get svgIconPath;
  @override
  String get cryptoAmount;
  @override
  String get dollarValue;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
