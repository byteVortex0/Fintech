import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/user_profile_model.dart';

part 'settings_state.freezed.dart';

/// Settings screen state management using Freezed
/// Represents all possible states: initial, loading, loaded with data, error, and logout states
@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = Initial;
  const factory SettingsState.loading() = Loading;
  const factory SettingsState.loaded(UserProfileModel userProfile) = Loaded;
  const factory SettingsState.error(String message) = Error;
  const factory SettingsState.logoutLoading() = LogoutLoading;
  const factory SettingsState.logoutSuccess() = LogoutSuccess;
  const factory SettingsState.logoutError(String message) = LogoutError;
}
