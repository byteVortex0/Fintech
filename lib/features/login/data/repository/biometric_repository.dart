import 'package:local_auth/local_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/utils/user_preferences.dart';
import 'package:flutter/foundation.dart';

/// Repository for handling biometric authentication (fingerprint and face ID)
/// Authenticates user with local biometrics then signs in to Firebase
class BiometricRepository {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Check if device supports biometric authentication
  Future<bool> canUseBiometrics() async {
    try {
      final bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();
      return canCheckBiometrics && isDeviceSupported;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[BiometricRepository] Error checking biometric support: $e');
      }
      return false;
    }
  }

  /// Get available biometric types (fingerprint, face, iris)
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[BiometricRepository] Error getting available biometrics: $e');
      }
      return [];
    }
  }

  /// Authenticate user with biometrics
  /// For auto-login (no password), uses cached Firebase session
  /// For manual login, signs in with email and password
  /// Returns user if successful, throws exception if failed
  Future<User?> authenticateWithBiometrics({
    required String email,
    required String password,
    required String localizedReason,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint('[BiometricRepository] Starting biometric authentication for: $email');
      }

      // Authenticate with local biometrics
      final bool didAuthenticate = await _localAuth.authenticate(localizedReason: localizedReason);

      if (!didAuthenticate) {
        if (kDebugMode) {
          debugPrint('[BiometricRepository] Biometric authentication failed');
        }
        throw Exception('Biometric authentication failed');
      }

      if (kDebugMode) {
        debugPrint('[BiometricRepository] Biometric authentication successful');
      }

      // If password is empty, use cached Firebase session (auto-login flow)
      if (password.isEmpty) {
        final User? currentUser = _firebaseAuth.currentUser;
        if (currentUser != null) {
          if (kDebugMode) {
            debugPrint(
              '[BiometricRepository] Using cached Firebase session for user: ${currentUser.email}',
            );
          }
          // Ensure UID is saved
          await UserPreferences.saveUserUid(currentUser.uid);
          return currentUser;
        } else {
          throw Exception('No active Firebase session. Please log in again.');
        }
      }

      // Sign in to Firebase with stored credentials (manual login flow)
      if (kDebugMode) {
        debugPrint('[BiometricRepository] Signing into Firebase with email/password');
      }

      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user != null) {
        // Save UID to SharedPreferences for persistence
        await UserPreferences.saveUserUid(user.uid);
        if (kDebugMode) {
          debugPrint('[BiometricRepository] User UID saved: ${user.uid}');
        }
      }

      return user;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[BiometricRepository] Biometric authentication error: $e');
      }
      rethrow;
    }
  }
}
