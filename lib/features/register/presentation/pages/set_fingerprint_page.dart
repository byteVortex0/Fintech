import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/routes/app_routes.dart';
import '../../../login/presentation/widgets/curved_background.dart';

class SetFingerprintPage extends StatelessWidget {
  const SetFingerprintPage({super.key});

  /// Skips fingerprint setup and returns to login
  /// Clears stack to prevent returning to register flow
  void _handleSkip(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
  }

  /// Proceeds to fingerprint verification after scanning
  void _handleFingerprintSet(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.setFingerprintVerified);
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
                    _buildFingerprintSection(context),
                    SizedBox(height: 80.h),
                    _buildSkipButton(context),
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
          'Set Your Finger Print',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A2B4A),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Add a fingerprint to make your account\nmore secure.',
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

  Widget _buildFingerprintSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _handleFingerprintSet(context),
          child: Icon(
            Icons.fingerprint,
            size: 180.sp,
            color: const Color(0xFF6B7280),
          ),
        ),
        SizedBox(height: 48.h),
        SizedBox(
          width: double.infinity,
          child: Text(
            'Place your finger in fingerprint\nsensor until the icon completely',
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

  Widget _buildSkipButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 180.w,
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
    );
  }
}
