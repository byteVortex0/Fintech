import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/routes/app_routes.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import '../../../login/presentation/widgets/curved_background.dart';
import '../widgets/register_header.dart';
import '../widgets/register_form.dart';

/// RegisterPage - Main registration screen orchestrator
///
/// This page serves as the entry point for new user signup.
/// Responsibilities:
/// - Assembles registration form with 6 input fields (name, email, password, phone)
/// - Handles registration completion and navigation to biometric setup
/// - Routes back to login page with stack clearing to prevent backward navigation
/// - Uses shared curved background for visual consistency
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  /// Handles registration completion
  /// TODO: Add device biometric detection logic to conditionally navigate to:
  /// - set_face_id if device supports Face ID
  /// - set_fingerprint if device supports fingerprint
  /// - login as fallback
  void _handleRegister(BuildContext context) {
    NavigationService.navigateTo(AppRoutes.setFaceId);
  }

  /// Navigates back to login page and clears the navigation stack
  /// Uses NavigationService to prevent going back to registration
  void _navigateToLogin(BuildContext context) {
    NavigationService.navigateToAndRemoveUntil(AppRoutes.login);
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
