import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech/core/utils/constants.dart';
import 'package:fintech/core/utils/user_preferences.dart';
import 'package:fintech/features/login/data/repository/login_repository.dart';
import 'package:fintech/features/login/presentation/cubit/login_state.dart';

/// LoginCubit handles user authentication via Firebase
/// Manages login state and emits appropriate states
class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _repository;

  LoginCubit(this._repository) : super(const LoginState.initial());

  /// Authenticate user with email and password
  /// Emits loading → authenticated/error states
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(const LoginState.loading());

      // Validate inputs
      if (email.trim().isEmpty || password.trim().isEmpty) {
        emit(const LoginState.error('Email and password are required'));
        return;
      }

      // Attempt sign-in
      final user = await _repository.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Update app state
      isLoggedInUser = true;
      // ignore: avoid_print
      print('[LoginCubit] Login successful for user: ${user.email}');

      // Save user UID to SharedPreferences (for persistent login)
      // ignore: avoid_print
      print('[LoginCubit] About to save UID: ${user.uid}');
      await UserPreferences.saveUserUid(user.uid);
      // ignore: avoid_print
      print('[LoginCubit] UID saved successfully');

      // Emit authenticated state
      emit(LoginState.authenticated(user.email ?? email));
    } catch (e) {
      emit(LoginState.error(e.toString()));
    }
  }
}
