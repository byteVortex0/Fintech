import 'package:fintech/core/utils/image_manager.dart';
import 'package:fintech/core/routes/app_routes.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../login/presentation/widgets/curved_background.dart';

/// SetFaceIdPage - Face ID setup option screen for new users
///
/// Presented during registration flow to offer Face ID biometric setup.
/// Responsibilities:
/// - Display Face ID setup prompt with description text
/// - Provide Skip button to bypass biometric setup
/// - Provide Continue button to proceed to Face ID scanning
/// - Both options route to appropriate next steps in registration flow
class SetFaceIdPage extends StatelessWidget {
  const SetFaceIdPage({super.key});

  /// Skips Face ID setup and returns to login
  /// Clears stack to prevent returning to register flow
  void _handleSkip(BuildContext context) {
    NavigationService.navigateToAndRemoveUntil(AppRoutes.login);
  }

  /// Proceeds to Face ID scanning screen
  void _handleContinue(BuildContext context) {
    NavigationService.navigateTo(AppRoutes.faceIdScanning);
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
                    SizedBox(height: 80.h),
                    _buildFaceIdSection(context),
                    SizedBox(height: 80.h),
                    _buildButtons(context),
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
          'Set Your Face ID',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A2B4A),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Add your face ID to make your account\nmore secure.',
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

  Widget _buildFaceIdSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(32.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
          ),
          child: Image.asset(ImageManager.faceIdWithText),
        ),
        SizedBox(height: 48.h),
        SizedBox(
          width: double.infinity,
          child: Text(
            'Position your face in front of camera until the icon completely',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1A2B4A),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 52.h,
            child: OutlinedButton(
              onPressed: () => _handleSkip(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF1A2B4A), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                ),
              ),
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A2B4A),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: SizedBox(
            height: 52.h,
            child: ElevatedButton(
              onPressed: () => _handleContinue(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A2B4A),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                ),
              ),
              child: Text(
                'continue',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
