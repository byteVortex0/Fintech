import 'package:flutter/foundation.dart';
import 'package:fintech/core/utils/user_preferences.dart';

/// Service to manage biometric enrollment status for users
/// Handles checking and updating whether user has enrolled for biometric login
class BiometricEnrollmentService {
  /// Enroll current user for biometric login with optional email and password storage
  Future<void> enrollBiometric({String? email, String? password}) async {
    try {
      if (kDebugMode) {
        debugPrint(
          '[BiometricEnrollmentService] Starting enrollment - email: $email, password: ${password?.isNotEmpty ?? false}',
        );
      }

      await UserPreferences.setBiometricEnrolled(true);
      if (kDebugMode) {
        debugPrint('[BiometricEnrollmentService] Enrollment flag set to true');
      }

      if (email != null && email.isNotEmpty) {
        await UserPreferences.saveBiometricEmail(email);
        if (kDebugMode) {
          debugPrint('[BiometricEnrollmentService] Email saved: $email');
        }
      } else {
        if (kDebugMode) {
          debugPrint(
            '[BiometricEnrollmentService] WARNING: Email is null or empty',
          );
        }
      }

      if (password != null && password.isNotEmpty) {
        await UserPreferences.saveBiometricPassword(password);
        if (kDebugMode) {
          debugPrint(
            '[BiometricEnrollmentService] Password saved successfully',
          );
        }
      } else {
        if (kDebugMode) {
          debugPrint(
            '[BiometricEnrollmentService] WARNING: Password is null or empty',
          );
        }
      }

      if (kDebugMode) {
        debugPrint(
          '[BiometricEnrollmentService] User enrolled for biometric login',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint(
          '[BiometricEnrollmentService] Error enrolling biometric: $e',
        );
      }
      rethrow;
    }
  }

  /// Check if current user has enrolled for biometric login
  Future<bool> isBiometricEnrolled() async {
    try {
      final enrolled = await UserPreferences.isBiometricEnrolled();
      if (kDebugMode) {
        debugPrint(
          '[BiometricEnrollmentService] Biometric enrolled status: $enrolled',
        );
      }
      return enrolled;
    } catch (e) {
      if (kDebugMode) {
        debugPrint(
          '[BiometricEnrollmentService] Error checking enrollment: $e',
        );
      }
      return false;
    }
  }

  /// Clear biometric enrollment (used on logout)
  Future<void> unenrollBiometric() async {
    try {
      await UserPreferences.clearBiometricEnrollment();
      if (kDebugMode) {
        debugPrint(
          '[BiometricEnrollmentService] User unenrolled from biometric login',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint(
          '[BiometricEnrollmentService] Error unenrolling biometric: $e',
        );
      }
      rethrow;
    }
  }
}
