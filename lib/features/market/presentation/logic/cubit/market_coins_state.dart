part of 'market_coins_cubit.dart';

@freezed
sealed class MarketCoinsState with _$MarketCoinsState {
  const factory MarketCoinsState.loading() = _Loading;
  const factory MarketCoinsState.loaded({required List<MarketCoinResponse> coinsMarkets}) = _Loaded;
  const factory MarketCoinsState.error({required String message}) = _Error;

  const factory MarketCoinsState.empty() = _Empty;

  const factory MarketCoinsState.searching() = _Searching;
  const factory MarketCoinsState.searchLoaded({required List<SearchCoin> searchResults}) =
      _SearchLoaded;
  const factory MarketCoinsState.searchError({required String message}) = _SearchError;
}
