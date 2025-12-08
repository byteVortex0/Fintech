import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech/features/settings/presentation/cubit/settings_state.dart';
import 'package:fintech/features/settings/data/repository/settings_repository.dart';

/// Settings Cubit for managing user profile data
/// Handles fetching and refreshing user profile from Firestore
class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _repository;

  SettingsCubit(this._repository) : super(const SettingsState.initial());

  /// Fetch user profile from Firestore
  Future<void> fetchUserProfile() async {
    try {
      emit(const SettingsState.loading());
      final userProfile = await _repository.getUserProfile();
      emit(SettingsState.loaded(userProfile));
    } catch (e) {
      emit(SettingsState.error(e.toString()));
    }
  }

  /// Refresh user profile data
  Future<void> refreshUserProfile() async {
    try {
      final userProfile = await _repository.getUserProfile();
      emit(SettingsState.loaded(userProfile));
    } catch (e) {
      emit(SettingsState.error(e.toString()));
    }
  }
}
