import 'package:fintech/core/navigation/navigation_service.dart';
import 'package:fintech/core/routes/app_routes.dart';
import 'package:fintech/features/login/logic/login_cubit.dart';
import 'package:fintech/features/login/presentation/widgets/login_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/curved_background.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login_section.dart';

/// Main login screen - Authentication entry point for existing users
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    SizedBox(height: 80.h),
                    _buildHeader(),
                    SizedBox(height: 48.h),
                    LoginForm(
                      onLoginPressed: () => _validateThenDoLogin(context),
                      onForgotPasswordPressed: () =>
                          _handleForgotPassword(context),
                    ),
                    SocialLoginSection(
                      onFingerprintPressed: () =>
                          _navigateToFingerprint(context),
                      onFaceIdPressed: () => _navigateToFaceId(context),
                    ),
                    SizedBox(height: 32.h),
                    _buildSignUpRow(context),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Builder(
      builder: (context) => Column(
        children: [
          Text(
            'Login To Your Account',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Welcome back you've\nbeen missed!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              height: 1.4,
            ),
          ),
          const LoginBlocListener(),
        ],
      ),
    );
  }

  Widget _buildSignUpRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        GestureDetector(
          onTap: () => _navigateToRegister(context),
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToFaceId(BuildContext context) =>
      NavigationService.navigateTo(context, AppRoutes.faceIdScanning);

  void _navigateToFingerprint(BuildContext context) =>
      NavigationService.navigateTo(context, AppRoutes.touchIdScanning);

  void _validateThenDoLogin(BuildContext context) {
    if (context.read<LoginCubit>().formKey.currentState!.validate()) {
      context.read<LoginCubit>().login();
    }
  }

  void _handleForgotPassword(BuildContext context) {
    // TODO: Navigate to forgot password page
  }

  void _navigateToRegister(BuildContext context) =>
      NavigationService.navigateTo(context, AppRoutes.register);
}
