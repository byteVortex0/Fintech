import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:fintech/core/utils/user_preferences.dart';
import 'package:fintech/features/login/data/services/biometric_enrollment_service.dart';
import 'auto_login_state.dart';

/// Cubit for checking auto-login eligibility on app startup
/// Determines if user should be auto-logged in with biometric or needs to login
class AutoLoginCubit extends Cubit<AutoLoginState> {
  final BiometricEnrollmentService _enrollmentService;

  AutoLoginCubit(this._enrollmentService)
    : super(const AutoLoginState.checking());

  /// Check if user should be auto-logged in on app startup
  Future<void> checkAutoLogin() async {
    try {
      if (kDebugMode) {
        debugPrint('[AutoLoginCubit] Checking auto-login eligibility');
      }

      // Check if user was previously logged in
      final isLoggedIn = await UserPreferences.checkIfLoggedInUser();
      if (isClosed) return;

      if (!isLoggedIn) {
        if (kDebugMode) {
          debugPrint(
            '[AutoLoginCubit] No previous login found, showing login page',
          );
        }
        emit(const AutoLoginState.loginRequired());
        return;
      }

      // Check if user has biometric enrollment
      final hasBiometricEnrollment = await _enrollmentService
          .isBiometricEnrolled();
      if (isClosed) return;

      if (!hasBiometricEnrollment) {
        if (kDebugMode) {
          debugPrint(
            '[AutoLoginCubit] User logged in but no biometric enrollment, going to home',
          );
        }
        // User is logged in but hasn't enrolled for biometric
        emit(const AutoLoginState.alreadyLoggedIn());
        return;
      }

      if (kDebugMode) {
        debugPrint(
          '[AutoLoginCubit] User has biometric enrollment, requiring biometric auth',
        );
      }

      // User is logged in and has biometric enrollment
      emit(const AutoLoginState.biometricRequired());
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[AutoLoginCubit] Error checking auto-login: $e');
      }
      if (isClosed) return;
      emit(AutoLoginState.error(e.toString()));
    }
  }
}
