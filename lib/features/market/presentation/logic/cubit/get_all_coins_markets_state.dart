part of 'get_all_coins_markets_cubit.dart';

@freezed
class GetAllCoinsMarketsState with _$GetAllCoinsMarketsState {
  const factory GetAllCoinsMarketsState.loading() = _Loading;
  const factory GetAllCoinsMarketsState.loaded({
    required List<MarketCoinResponse> coinsMarkets,
  }) = _Loaded;
  const factory GetAllCoinsMarketsState.error({required String message}) =
      _Error;

  const factory GetAllCoinsMarketsState.empty() = _Empty;
}
