import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import '../../../login/presentation/widgets/curved_background.dart';
import '../widgets/register_header.dart';
import '../widgets/register_form.dart';

/// User registration/signup screen
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
                      onRegisterPressed: () => _handleRegister(context),
                      onLoginPressed: () => _navigateToLogin(context),
                    ),
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
}
