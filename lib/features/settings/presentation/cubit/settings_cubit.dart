import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech/core/utils/constants.dart';
import 'package:fintech/features/settings/presentation/cubit/settings_state.dart';
import 'package:fintech/features/settings/data/repository/settings_repository.dart';

/// Settings Cubit for managing user profile data and authentication
/// Handles fetching, refreshing user profile from Firestore, and logout operations
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

  /// Refresh user profile data without showing loading overlay
  Future<void> refreshUserProfile() async {
    try {
      final userProfile = await _repository.getUserProfile();
      emit(SettingsState.loaded(userProfile));
    } catch (e) {
      emit(SettingsState.error(e.toString()));
    }
  }

  /// Handle logout - Sign out from Firebase and update app state
  /// Emits logoutLoading → logoutSuccess/logoutError states
  Future<void> logout() async {
    try {
      emit(const SettingsState.logoutLoading());

      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Update app state
      isLoggedInUser = false;

      // Emit success state
      emit(const SettingsState.logoutSuccess());
    } catch (e) {
      emit(SettingsState.logoutError(e.toString()));
    }
  }
}
