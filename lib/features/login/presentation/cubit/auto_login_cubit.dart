import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/utils/user_preferences.dart';
import '../../data/services/biometric_enrollment_service.dart';
import 'package:local_auth/local_auth.dart';
import 'auto_login_state.dart';

/// Cubit for checking auto-login eligibility on app startup
/// Determines if user should be auto-logged in with biometric or needs to login
class AutoLoginCubit extends Cubit<AutoLoginState> {
  final BiometricEnrollmentService _enrollmentService;

  AutoLoginCubit(this._enrollmentService)
    : super(const AutoLoginState.checking());

  Future<void> checkAutoLogin() async {
    try {
      if (kDebugMode) {
        debugPrint('[AutoLoginCubit] Checking auto-login eligibility');
      }

      // 1) Check if user was logged in previously
      final isLoggedIn = await UserPreferences.checkIfLoggedInUser();
      if (isClosed) return;
      log('isLoggedIn: $isLoggedIn');

      if (!isLoggedIn) {
        emit(const AutoLoginState.loginRequired());
        return;
      }

      // 2) Check if user enrolled biometrics inside app
      final hasBiometricEnrollment = await _enrollmentService
          .isBiometricEnrolled();
      if (isClosed) return;
      log('hasBiometricEnrollment: $hasBiometricEnrollment');

      if (!hasBiometricEnrollment) {
        emit(const AutoLoginState.alreadyLoggedIn());
        return;
      }

      // 3) Detect biometric type
      final type = await _detectBiometricType();

      if (kDebugMode) {
        debugPrint('[AutoLoginCubit] Biometric type: $type');
      }

      if (type == null) {
        emit(const AutoLoginState.loginRequired());
        log('No biometric type detected');
        return;
      }

      log('type: $type');

      // 4) Require biometric login with type
      emit(AutoLoginState.biometricRequired(type));
    } catch (e) {
      if (!isClosed) {
        emit(AutoLoginState.error(e.toString()));
      }
    }
  }

  Future<BiometricType?> _detectBiometricType() async {
    final localAuth = LocalAuthentication();

    try {
      final canCheck = await localAuth.canCheckBiometrics;
      log('canCheck: $canCheck');

      final isSupported = await localAuth.isDeviceSupported();
      log('isSupported: $isSupported');

      if (!canCheck || !isSupported) return null;

      final types = await localAuth.getAvailableBiometrics();
      log('types: $types');

      // Mapping للـ Android devices
      if (types.contains(BiometricType.face)) return BiometricType.face;
      if (types.contains(BiometricType.fingerprint)) {
        return BiometricType.fingerprint;
      }

      // fallback: لو رجع strong أو weak
      if (types.contains(BiometricType.strong)) {
        return BiometricType.fingerprint;
      }
      if (types.contains(BiometricType.weak)) return BiometricType.face;

      return null;
    } catch (e) {
      log('Error detecting biometric type: $e');
      return null;
    }
  }
}
