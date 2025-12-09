part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = _Loading;

  const factory HomeState.loaded({
    required HomeScreenResponse data,
    required UserProfileModel userProfile,
  }) = _Loaded;

  const factory HomeState.error({required String message}) = _Error;

  const factory HomeState.empty() = _Empty;
}
