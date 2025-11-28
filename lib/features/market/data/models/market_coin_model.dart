import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_coin_model.freezed.dart';

/// MarketCoinModel represents cryptocurrency data for market listing
/// Used in market screen to display coin information with rank and price
@freezed
class MarketCoinModel with _$MarketCoinModel {
  const factory MarketCoinModel({
    required String name,
    required String rank,
    required String price,
    required String changePercent,
    String? svgIconPath,
  }) = _MarketCoinModel;
}
