part of 'get_coin_details_cubit.dart';

@freezed
class GetCoinDetailsState with _$GetCoinDetailsState {
  const factory GetCoinDetailsState.loading() = _Loading;
  const factory GetCoinDetailsState.loaded({
    required CoinDetailsModel coinDetails,
  }) = _Loaded;
  const factory GetCoinDetailsState.error({required String message}) = _Error;
}
