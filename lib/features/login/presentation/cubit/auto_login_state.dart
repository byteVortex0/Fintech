import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:local_auth/local_auth.dart';

part 'auto_login_state.freezed.dart';

/// State for auto-login checking on app startup
@freezed
class AutoLoginState with _$AutoLoginState {
  /// Initial checking state
  const factory AutoLoginState.checking() = _Checking;

  /// User should be auto-logged in with biometric
  const factory AutoLoginState.biometricRequired(BiometricType? type) = _BiometricRequired;

  /// User is already logged in, go to home
  const factory AutoLoginState.alreadyLoggedIn() = _AlreadyLoggedIn;

  /// User needs to log in with email/password
  const factory AutoLoginState.loginRequired() = _LoginRequired;

  /// Error occurred during auto-login check
  const factory AutoLoginState.error(String message) = _Error;
}
