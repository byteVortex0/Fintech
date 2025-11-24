import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/curved_background.dart';

class TouchIdVerifiedPage extends StatelessWidget {
  const TouchIdVerifiedPage({super.key});

  void _handleContinue(BuildContext context) {
    Navigator.of(context).pushNamed('home');
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
                  SizedBox(height: 200.h),
                  _buildCheckIcon(),
                  SizedBox(height: 60.h),
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

  Widget _buildCheckIcon() {
    return Container(
      width: 140.w,
      height: 140.w,
      decoration: const BoxDecoration(
        color: Color(0xFF1A2B4A),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.check, color: Colors.white, size: 70.sp),
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
          "You have been verified your\ninformation completely. Let's make\ntransactions!",
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
          onTap: () => Navigator.of(context).pop(),
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
