import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_model.freezed.dart';

/// Portfolio summary model containing total value and today's performance
@freezed
abstract class PortfolioModel with _$PortfolioModel {
  const factory PortfolioModel({
    required double totalValue,
    required double todayChange,
    required double todayChangePercent,
    required bool isPositiveChange,
  }) = _PortfolioModel;
}
