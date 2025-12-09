import 'package:freezed_annotation/freezed_annotation.dart';

part 'trending_response.freezed.dart';
part 'trending_response.g.dart';

@freezed
abstract class TrendingResponse with _$TrendingResponse {
  const factory TrendingResponse({required List<TrendingCoin> coins}) =
      _TrendingResponse;

  factory TrendingResponse.fromJson(Map<String, dynamic> json) =>
      _$TrendingResponseFromJson(json);
}

@freezed
abstract class TrendingCoin with _$TrendingCoin {
  const factory TrendingCoin({required TrendingCoinItem item}) = _TrendingCoin;

  factory TrendingCoin.fromJson(Map<String, dynamic> json) =>
      _$TrendingCoinFromJson(json);
}

@freezed
abstract class TrendingCoinItem with _$TrendingCoinItem {
  const factory TrendingCoinItem({
    required String id,
    required String name,
    required String symbol,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'small') required String image,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'price_btc') required double priceBtc,
  }) = _TrendingCoinItem;

  factory TrendingCoinItem.fromJson(Map<String, dynamic> json) =>
      _$TrendingCoinItemFromJson(json);
}
