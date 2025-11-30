import 'package:freezed_annotation/freezed_annotation.dart';

part 'holding_model.freezed.dart';

/// Cryptocurrency holding model with value, percentage, and performance data
@freezed
class HoldingModel with _$HoldingModel {
  const factory HoldingModel({
    required String coinName,
    required String symbol,
    required String svgIconPath,
    required double amount,
    required int percentage,
    required double change,
    required bool isPositiveChange,
    required String cryptoAmount,
    required String dollarValue,
    required String dollarChange,
  }) = _HoldingModel;
}
