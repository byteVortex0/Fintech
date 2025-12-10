import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/service/api/error/error_handler.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/service/shared_pref/pref_keys.dart';
import '../../../../core/service/shared_pref/shared_pref.dart';
import 'settings_state.dart';
import '../../data/repository/settings_repository.dart';

/// Settings Cubit for managing user profile data and authentication
/// Handles fetching, refreshing user profile from Firestore, and logout operations with friendly error messages
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
      final failure = await ErrorHandler.handle(e);
      emit(SettingsState.error(failure.errorModel.userMessage));
    }
  }

  /// Refresh user profile data without showing loading overlay
  Future<void> refreshUserProfile() async {
    try {
      final userProfile = await _repository.getUserProfile();
      emit(SettingsState.loaded(userProfile));
    } catch (e) {
      final failure = await ErrorHandler.handle(e);
      emit(SettingsState.error(failure.errorModel.userMessage));
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

      // Clear user UID from SharedPreferences
      await SharedPref.removeValue(PrefKeys.uid);

      // Emit success state
      emit(const SettingsState.logoutSuccess());
    } catch (e) {
      final failure = await ErrorHandler.handle(e);
      emit(SettingsState.logoutError(failure.errorModel.userMessage));
    }
  }
}
