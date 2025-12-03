import 'package:fintech/core/utils/constants.dart';
import 'package:fintech/core/utils/user_preferences.dart';
import 'package:fintech/features/login/data/repos/login_repo.dart';
import 'package:fintech/features/login/logic/login_state.dart';
import 'package:fintech/features/login/data/models/login_request_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(LoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void login() async {
    emit(LoginState.loading());
    final response = await _loginRepo.login(
      LoginUserRequestBody(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.when(
      success: (user) async {
        await UserPreferences.saveUserUid(user.user!.uid);
        isLoggedInUser = true;
        emit(LoginState.success(user));
      },
      failure: (error) {
        emit(LoginState.error(error));
      },
    );
  }
}
