import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

/// Login screen state management using Freezed
/// Represents all possible states during login process
@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.initial() = Initial;
  const factory LoginState.loading() = Loading;
  const factory LoginState.authenticated(String userEmail) = Authenticated;
  const factory LoginState.error(String message) = Error;
}
