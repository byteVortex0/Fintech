import 'package:fintech/core/utils/constants.dart';
import 'package:fintech/core/utils/user_preferences.dart';
import 'package:fintech/features/register/data/models/create_user_request_body.dart';
import 'package:fintech/features/register/data/models/register_request_body.dart';
import 'package:fintech/features/register/data/repos/register_repo.dart';
import 'package:fintech/features/register/logic/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo _registerRepo;
  RegisterCubit(this._registerRepo) : super(RegisterState.initial());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void createUser() async {
    emit(RegisterState.loading());
    final response = await _registerRepo.createUser(
      RegisterUserRequestBody(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.when(
      success: (user) async {
        await UserPreferences.saveUserUid(user.user!.uid);
        isLoggedInUser = true;
        storeUser(user);
      },
      failure: (error) {
        emit(RegisterState.error(error));
      },
    );
  }

  void storeUser(UserCredential user) async {
    emit(RegisterState.loading());
    final response = await _registerRepo.storeUser(
      user: user,
      createUserRequestBody: CreateUserRequestBody(
        uid: user.user!.uid,
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text,
        phoneNumber: phoneController.text,
      ),
    );
    response.when(
      success: (massage) async {
        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        phoneController.clear();
        passwordController.clear();
        emit(RegisterState.success('User registered successfully'));
      },
      failure: (error) {
        emit(RegisterState.error(error));
      },
    );
  }
}
