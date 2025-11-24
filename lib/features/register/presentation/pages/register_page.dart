import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/routes/app_routes.dart';
import '../../../login/presentation/widgets/curved_background.dart';
import '../widgets/register_header.dart';
import '../widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  /// Handles registration completion
  /// TODO: Add device biometric detection logic to conditionally navigate to:
  /// - set_face_id if device supports Face ID
  /// - set_fingerprint if device supports fingerprint
  /// - login as fallback
  void _handleRegister(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.setFaceId);
  }

  /// Navigates back to login page and clears the navigation stack
  /// Uses pushNamedAndRemoveUntil to prevent going back to registration
  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FC),
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
