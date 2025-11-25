import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/routes/app_routes.dart';
import '../../../login/presentation/widgets/curved_background.dart';

/// SetFingerprintVerifiedPage - Fingerprint verification success confirmation screen
///
/// Presented after successful fingerprint scanning during registration flow.
/// Responsibilities:
/// - Display fingerprint verification success with checkmark icon
/// - Show success message and confirmation text
/// - Provide Continue button to complete registration and return to login
/// - Use curved background design for visual consistency with other onboarding screens
class SetFingerprintVerifiedPage extends StatelessWidget {
  const SetFingerprintVerifiedPage({super.key});

  /// Completes fingerprint setup and returns to login
  /// Clears stack so user starts fresh from login
  void _handleContinue(BuildContext context) {
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
                    SizedBox(height: 120.h),
                    _buildCheckmark(),
                    SizedBox(height: 40.h),
                    _buildContent(),
                    SizedBox(height: 60.h),
                    _buildContinueButton(context),
                    SizedBox(height: 120.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckmark() {
    return Center(
      child: Container(
        width: 140.w,
        height: 140.w,
        decoration: const BoxDecoration(
          color: Color(0xFF1A2B4A),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.check, color: Colors.white, size: 70.sp),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Text(
          'Your scanning is complete',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A2B4A),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: Text(
            'you will be able to sign in by using fingerprint',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF374151),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: () => _handleContinue(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A2B4A),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.r),
            ),
          ),
          child: Text(
            'Continue',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
