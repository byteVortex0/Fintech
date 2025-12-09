import 'package:flutter/foundation.dart';
import 'package:fintech/core/service/shared_pref/pref_keys.dart';
import 'package:fintech/core/service/shared_pref/shared_pref.dart';

class UserPreferences {
  /// Initialize SharedPreferences (must be called before any other methods)
  static Future<void> init() async {
    await SharedPref.init();
    if (kDebugMode) {
      debugPrint('[UserPreferences] SharedPreferences initialized');
    }
  }

  static Future<void> saveUserUid(String uid) async {
    await SharedPref.setValue(PrefKeys.uid, uid);
    if (kDebugMode) {
      debugPrint('[UserPreferences] Saved UID: $uid');
    }
  }

  static Future<bool> checkIfLoggedInUser() async {
    final uid = SharedPref.getValue(PrefKeys.uid);
    final isLoggedIn = uid != null;
    if (kDebugMode) {
      debugPrint(
        '[UserPreferences] checkIfLoggedInUser - UID value: $uid, isLoggedIn: $isLoggedIn',
      );
    }
    return isLoggedIn;
  }

  static Future<void> setBiometricEnrolled(bool enrolled) async {
    await SharedPref.setValue(PrefKeys.biometricEnrolled, enrolled);
    if (kDebugMode) {
      debugPrint('[UserPreferences] Set biometric enrolled: $enrolled');
    }
  }

  static Future<bool> isBiometricEnrolled() async {
    final enrolled = SharedPref.getValue(PrefKeys.biometricEnrolled) ?? false;
    if (kDebugMode) {
      debugPrint('[UserPreferences] isBiometricEnrolled: $enrolled');
    }
    return enrolled is bool ? enrolled : false;
  }

  static Future<void> clearBiometricEnrollment() async {
    await SharedPref.removeValue(PrefKeys.biometricEnrolled);
    await SharedPref.removeValue(PrefKeys.biometricEmail);
    await SharedPref.removeValue(PrefKeys.biometricPassword);
    if (kDebugMode) {
      debugPrint('[UserPreferences] Cleared biometric enrollment');
    }
  }

  static Future<void> saveBiometricEmail(String email) async {
    if (kDebugMode) {
      debugPrint(
        '[UserPreferences] saveBiometricEmail START - key: ${PrefKeys.biometricEmail}, value: $email',
      );
    }
    await SharedPref.setValue(PrefKeys.biometricEmail, email);
    if (kDebugMode) {
      debugPrint('[UserPreferences] saveBiometricEmail COMPLETE');
    }
  }

  static Future<String?> getBiometricEmail() async {
    if (kDebugMode) {
      debugPrint(
        '[UserPreferences] getBiometricEmail START - key: ${PrefKeys.biometricEmail}',
      );
    }
    final email = SharedPref.getValue(PrefKeys.biometricEmail);
    if (kDebugMode) {
      debugPrint(
        '[UserPreferences] getBiometricEmail RESULT - value: $email, type: ${email.runtimeType}',
      );
    }
    return email as String?;
  }

  static Future<void> saveBiometricPassword(String password) async {
    if (kDebugMode) {
      debugPrint(
        '[UserPreferences] saveBiometricPassword START - key: ${PrefKeys.biometricPassword}, isEmpty: ${password.isEmpty}',
      );
    }
    await SharedPref.setValue(PrefKeys.biometricPassword, password);
    if (kDebugMode) {
      debugPrint('[UserPreferences] saveBiometricPassword COMPLETE');
    }
  }

  static Future<String?> getBiometricPassword() async {
    if (kDebugMode) {
      debugPrint(
        '[UserPreferences] getBiometricPassword START - key: ${PrefKeys.biometricPassword}',
      );
    }
    final password = SharedPref.getValue(PrefKeys.biometricPassword);
    if (kDebugMode) {
      debugPrint(
        '[UserPreferences] getBiometricPassword RESULT - value: ${password != null ? 'EXISTS' : 'NULL'}, type: ${password.runtimeType}',
      );
    }
    return password as String?;
  }

  /// Debug method to check if biometric credentials are stored
  static Future<bool> hasBiometricCredentials() async {
    final email = await getBiometricEmail();
    final password = await getBiometricPassword();
    final hasCredentials =
        email != null &&
        email.isNotEmpty &&
        password != null &&
        password.isNotEmpty;
    if (kDebugMode) {
      debugPrint(
        '[UserPreferences] hasBiometricCredentials: $hasCredentials (email: ${email?.isNotEmpty ?? false}, password: ${password?.isNotEmpty ?? false})',
      );
    }
    return hasCredentials;
  }
}
