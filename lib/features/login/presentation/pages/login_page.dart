import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/routes/app_routes.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import '../widgets/curved_background.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login_section.dart';

/// LoginPage - Main login screen orchestrator
///
/// This page serves as the authentication entry point for existing users.
/// Responsibilities:
/// - Assembles login form with email/password input fields
/// - Orchestrates biometric authentication options (Face ID, Touch ID)
/// - Handles navigation to forgot password, registration, and biometric setup flows
/// - Manages credential-based and biometric login methods
/// - Provides visual hierarchy with curved background and responsive layout
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  /// Navigation: Initiates Face ID biometric authentication flow
  /// Routes to face_id_scanning page where biometric capture occurs
  void _navigateToFaceId(BuildContext context) {
    NavigationService.navigateTo(AppRoutes.faceIdScanning);
  }

  /// Navigation: Initiates Touch ID biometric authentication flow
  /// Routes to touch_id_scanning page where biometric capture occurs
  void _navigateToFingerprint(BuildContext context) {
    NavigationService.navigateTo(AppRoutes.touchIdScanning);
  }

  /// Authentication: Handles email/password login
  /// TODO: Implement login logic with BLoC pattern for state management
  /// Should validate credentials, handle auth errors, and navigate to home on success
  void _handleLogin(BuildContext context) {
    // TODO: Implement login logic with BLoC
  }

  /// Navigation: Routes to forgot password recovery screen
  /// TODO: Navigate to forgot password page when implemented
  void _handleForgotPassword(BuildContext context) {
    // TODO: Navigate to forgot password page
  }

  /// Navigation: Routes to user registration/signup flow
  /// Allows new users to create an account
  void _navigateToRegister(BuildContext context) {
    NavigationService.navigateTo(AppRoutes.register);
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
                    SizedBox(height: 80.h),
                    _buildHeader(),
                    SizedBox(height: 48.h),
                    LoginForm(
                      onLoginPressed: () => _handleLogin(context),
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
    return Column(
      children: [
        Text(
          'Login To Your Account',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A2B4A),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Welcome back you've\nbeen missed!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF374151),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(fontSize: 14.sp, color: const Color(0xFF6B7280)),
        ),
        GestureDetector(
          onTap: () => _navigateToRegister(context),
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF1A5FFF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
