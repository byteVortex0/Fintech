import 'package:freezed_annotation/freezed_annotation.dart';

part 'coingecko_price_response.freezed.dart';

/// API response model from CoinGecko for cryptocurrency prices
@freezed
abstract class CoinGeckoPriceResponse with _$CoinGeckoPriceResponse {
  const factory CoinGeckoPriceResponse({
    required Map<String, CoinPriceData> prices,
  }) = _CoinGeckoPriceResponse;
}

/// Individual coin price data from CoinGecko API
@freezed
abstract class CoinPriceData with _$CoinPriceData {
  const factory CoinPriceData({
    required double usd,
    required double usd24hChange,
  }) = _CoinPriceData;
}
