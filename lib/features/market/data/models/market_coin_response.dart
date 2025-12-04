import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_coin_response.freezed.dart';
part 'market_coin_response.g.dart';

@freezed
abstract class MarketCoinResponse with _$MarketCoinResponse {
  const factory MarketCoinResponse({
    required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'market_cap_rank') required int rank,
    @JsonKey(name: 'current_price') required double price,
    @JsonKey(name: 'price_change_percentage_24h') required double changePercent,
    @JsonKey(name: 'image') required String image,
  }) = _MarketCoinResponse;

  factory MarketCoinResponse.fromJson(Map<String, dynamic> json) =>
      _$MarketCoinResponseFromJson(json);
}
