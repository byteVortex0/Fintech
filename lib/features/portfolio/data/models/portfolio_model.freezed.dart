// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PortfolioModel {
  double get totalValue => throw _privateConstructorUsedError;
  double get todayChange => throw _privateConstructorUsedError;
  double get todayChangePercent => throw _privateConstructorUsedError;
  bool get isPositiveChange => throw _privateConstructorUsedError;

  /// Create a copy of PortfolioModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PortfolioModelCopyWith<PortfolioModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortfolioModelCopyWith<$Res> {
  factory $PortfolioModelCopyWith(
    PortfolioModel value,
    $Res Function(PortfolioModel) then,
  ) = _$PortfolioModelCopyWithImpl<$Res, PortfolioModel>;
  @useResult
  $Res call({
    double totalValue,
    double todayChange,
    double todayChangePercent,
    bool isPositiveChange,
  });
}

/// @nodoc
class _$PortfolioModelCopyWithImpl<$Res, $Val extends PortfolioModel>
    implements $PortfolioModelCopyWith<$Res> {
  _$PortfolioModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PortfolioModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalValue = null,
    Object? todayChange = null,
    Object? todayChangePercent = null,
    Object? isPositiveChange = null,
  }) {
    return _then(
      _value.copyWith(
            totalValue: null == totalValue
                ? _value.totalValue
                : totalValue // ignore: cast_nullable_to_non_nullable
                      as double,
            todayChange: null == todayChange
                ? _value.todayChange
                : todayChange // ignore: cast_nullable_to_non_nullable
                      as double,
            todayChangePercent: null == todayChangePercent
                ? _value.todayChangePercent
                : todayChangePercent // ignore: cast_nullable_to_non_nullable
                      as double,
            isPositiveChange: null == isPositiveChange
                ? _value.isPositiveChange
                : isPositiveChange // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PortfolioModelImplCopyWith<$Res>
    implements $PortfolioModelCopyWith<$Res> {
  factory _$$PortfolioModelImplCopyWith(
    _$PortfolioModelImpl value,
    $Res Function(_$PortfolioModelImpl) then,
  ) = __$$PortfolioModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double totalValue,
    double todayChange,
    double todayChangePercent,
    bool isPositiveChange,
  });
}

/// @nodoc
class __$$PortfolioModelImplCopyWithImpl<$Res>
    extends _$PortfolioModelCopyWithImpl<$Res, _$PortfolioModelImpl>
    implements _$$PortfolioModelImplCopyWith<$Res> {
  __$$PortfolioModelImplCopyWithImpl(
    _$PortfolioModelImpl _value,
    $Res Function(_$PortfolioModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PortfolioModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalValue = null,
    Object? todayChange = null,
    Object? todayChangePercent = null,
    Object? isPositiveChange = null,
  }) {
    return _then(
      _$PortfolioModelImpl(
        totalValue: null == totalValue
            ? _value.totalValue
            : totalValue // ignore: cast_nullable_to_non_nullable
                  as double,
        todayChange: null == todayChange
            ? _value.todayChange
            : todayChange // ignore: cast_nullable_to_non_nullable
                  as double,
        todayChangePercent: null == todayChangePercent
            ? _value.todayChangePercent
            : todayChangePercent // ignore: cast_nullable_to_non_nullable
                  as double,
        isPositiveChange: null == isPositiveChange
            ? _value.isPositiveChange
            : isPositiveChange // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$PortfolioModelImpl implements _PortfolioModel {
  const _$PortfolioModelImpl({
    required this.totalValue,
    required this.todayChange,
    required this.todayChangePercent,
    required this.isPositiveChange,
  });

  @override
  final double totalValue;
  @override
  final double todayChange;
  @override
  final double todayChangePercent;
  @override
  final bool isPositiveChange;

  @override
  String toString() {
    return 'PortfolioModel(totalValue: $totalValue, todayChange: $todayChange, todayChangePercent: $todayChangePercent, isPositiveChange: $isPositiveChange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortfolioModelImpl &&
            (identical(other.totalValue, totalValue) ||
                other.totalValue == totalValue) &&
            (identical(other.todayChange, todayChange) ||
                other.todayChange == todayChange) &&
            (identical(other.todayChangePercent, todayChangePercent) ||
                other.todayChangePercent == todayChangePercent) &&
            (identical(other.isPositiveChange, isPositiveChange) ||
                other.isPositiveChange == isPositiveChange));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalValue,
    todayChange,
    todayChangePercent,
    isPositiveChange,
  );

  /// Create a copy of PortfolioModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PortfolioModelImplCopyWith<_$PortfolioModelImpl> get copyWith =>
      __$$PortfolioModelImplCopyWithImpl<_$PortfolioModelImpl>(
        this,
        _$identity,
      );
}

abstract class _PortfolioModel implements PortfolioModel {
  const factory _PortfolioModel({
    required final double totalValue,
    required final double todayChange,
    required final double todayChangePercent,
    required final bool isPositiveChange,
  }) = _$PortfolioModelImpl;

  @override
  double get totalValue;
  @override
  double get todayChange;
  @override
  double get todayChangePercent;
  @override
  bool get isPositiveChange;

  /// Create a copy of PortfolioModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PortfolioModelImplCopyWith<_$PortfolioModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
