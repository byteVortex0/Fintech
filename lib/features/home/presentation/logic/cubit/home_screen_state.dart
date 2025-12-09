part of 'home_screen_cubit.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState.loading() = _Loading;

  const factory HomeScreenState.loaded({required HomeScreenResponse data}) =
      _Loaded;

  const factory HomeScreenState.error({required String message}) = _Error;

  const factory HomeScreenState.empty() = _Empty;
}
