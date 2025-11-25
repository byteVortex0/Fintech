import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/routes/app_routes.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import '../widgets/curved_background.dart';

class FaceIdVerifiedPage extends StatelessWidget {
  const FaceIdVerifiedPage({super.key});

  void _handleContinue(BuildContext context) {
    NavigationService.navigateToAndRemoveUntil(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FC),
      body: Stack(
        children: [
          const CurvedBackground(),
          _buildBackButton(context),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 180.h),
                  _buildFaceIdCard(),
                  SizedBox(height: 40.h),
                  _buildVerifiedText(),
                  const Spacer(),
                  _buildContinueButton(context),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaceIdCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 48.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCheckIcon(),
          SizedBox(height: 16.h),
          Text(
            'Face ID',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A2B4A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckIcon() {
    return Container(
      width: 70.w,
      height: 70.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF1A2B4A), width: 2.5),
      ),
      child: Icon(Icons.check, color: const Color(0xFF1A2B4A), size: 40.sp),
    );
  }

  Widget _buildVerifiedText() {
    return Column(
      children: [
        Text(
          "You're verified",
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A2B4A),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          "You have been verified your information\ncompletely. Let's make transactions!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6B7280),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 48.h,
      left: 16.w,
      child: SafeArea(
        child: GestureDetector(
          onTap: NavigationService.goBack,
          child: Icon(
            Icons.arrow_back_ios,
            color: const Color(0xFF1A2B4A),
            size: 24.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: () => _handleContinue(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A2B4A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'Continue To Home',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
