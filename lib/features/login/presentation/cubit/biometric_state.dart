import 'package:freezed_annotation/freezed_annotation.dart';

part 'biometric_state.freezed.dart';

/// Biometric authentication states using Freezed
@freezed
class BiometricState with _$BiometricState {
  const factory BiometricState.initial() = _Initial;

  const factory BiometricState.loading() = _Loading;

  /// User successfully authenticated with biometrics
  const factory BiometricState.authenticated(String uid) = _Authenticated;

  /// Authentication failed with error message
  const factory BiometricState.error(String message) = _Error;

  /// Device doesn't support biometric authentication
  const factory BiometricState.notSupported() = _NotSupported;
}
