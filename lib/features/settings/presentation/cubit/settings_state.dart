import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fintech/features/settings/data/models/user_profile_model.dart';

part 'settings_state.freezed.dart';

/// Settings screen state management using Freezed
/// Represents all possible states: initial, loading, loaded with data, and error
@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = Initial;
  const factory SettingsState.loading() = Loading;
  const factory SettingsState.loaded(UserProfileModel userProfile) = Loaded;
  const factory SettingsState.error(String message) = Error;
}
