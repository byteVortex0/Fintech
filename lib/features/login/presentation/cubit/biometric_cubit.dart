import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:fintech/features/login/data/repository/biometric_repository.dart';
import 'biometric_state.dart';

/// BiometricCubit for managing biometric authentication state
/// Handles fingerprint and face ID authentication
class BiometricCubit extends Cubit<BiometricState> {
  final BiometricRepository _repository;

  BiometricCubit(this._repository) : super(const BiometricState.initial());

  /// Check if device supports biometric authentication
  Future<void> checkBiometricSupport() async {
    try {
      final bool isSupported = await _repository.canUseBiometrics();

      if (!isSupported) {
        if (!isClosed) {
          emit(const BiometricState.notSupported());
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[BiometricCubit] Error checking biometric support: $e');
      }
      if (!isClosed) {
        emit(BiometricState.error('Failed to check biometric support'));
      }
    }
  }

  /// Authenticate user with biometrics
  /// Requires email and password for Firebase sign-in after biometric verification
  Future<void> authenticateWithBiometrics({
    required String email,
    required String password,
    required String localizedReason,
  }) async {
    if (!isClosed) {
      emit(const BiometricState.loading());
    }

    try {
      if (kDebugMode) {
        debugPrint('[BiometricCubit] Starting biometric authentication');
      }

      final user = await _repository.authenticateWithBiometrics(
        email: email,
        password: password,
        localizedReason: localizedReason,
      );

      if (user != null && !isClosed) {
        if (kDebugMode) {
          debugPrint('[BiometricCubit] Authentication successful for user: ${user.email}');
        }
        emit(BiometricState.authenticated(user.uid));
      } else if (!isClosed) {
        emit(const BiometricState.error('Authentication failed'));
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint('[BiometricCubit] Authentication error: $e');
      }
      if (!isClosed) {
        emit(BiometricState.error(e.toString()));
      }
    }
  }
}
