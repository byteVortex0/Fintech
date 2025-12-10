import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/service/api/error/error_handler.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/user_preferences.dart';
import '../../data/repository/login_repository.dart';
import 'login_state.dart';

/// LoginCubit handles user authentication via Firebase
/// Manages login state and emits appropriate states with friendly error messages
class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _repository;

  LoginCubit(this._repository) : super(const LoginState.initial());

  /// Authenticate user with email and password
  /// Emits loading → authenticated/error states with friendly messages
  Future<void> login({required String email, required String password}) async {
    try {
      emit(const LoginState.loading());

      // Validate inputs with friendly message
      if (email.trim().isEmpty || password.trim().isEmpty) {
        emit(const LoginState.error('Please enter both email and password'));
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
      // Handle error with friendly message
      final failure = await ErrorHandler.handle(e);
      final errorMessage = failure.errorModel.userMessage;
      emit(LoginState.error(errorMessage));
    }
  }
}
