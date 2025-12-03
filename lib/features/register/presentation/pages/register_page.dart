import 'package:fintech/core/navigation/navigation_service.dart';
import 'package:fintech/core/routes/app_routes.dart';
import 'package:fintech/features/login/presentation/widgets/curved_background.dart';
import 'package:fintech/features/register/logic/register_cubit.dart';
import 'package:fintech/features/register/presentation/widgets/register_bloc_listener.dart';
import 'package:fintech/features/register/presentation/widgets/register_form.dart';
import 'package:fintech/features/register/presentation/widgets/register_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  void _handleRegister(BuildContext context) =>
      NavigationService.navigateTo(context, '/set_fingerprint');

  void _navigateToLogin(BuildContext context) =>
      NavigationService.navigateToAndRemoveUntil(context, '/login');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          const CurvedBackground(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    const RegisterHeader(),
                    SizedBox(height: 32.h),
                    RegisterForm(
                      onRegisterPressed: () => _validateThenDoRegister(context),
                      onLoginPressed: () => _navigateToLogin(context),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
          const RegisterBlocListener(),
        ],
      ),
    );
  }

  void _validateThenDoRegister(BuildContext context) {
    if (context.read<RegisterCubit>().formKey.currentState!.validate()) {
      context.read<RegisterCubit>().createUser();
    }
  }

  void _navigateToLogin(BuildContext context) =>
      NavigationService.navigateToAndRemoveUntil(context, AppRoutes.login);
}
