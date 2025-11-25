import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/utils/image_manager.dart';
import 'package:fintech/core/routes/app_routes.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import '../widgets/curved_background.dart';

class TouchIdScanningPage extends StatelessWidget {
  const TouchIdScanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FC),
      body: Stack(
        children: [
          const CurvedBackground(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                children: [
                  _buildBackButton(context),
                  SizedBox(height: 60.h),
                  _buildTitle(),
                  const Spacer(),
                  _buildFingerprintIcon(context),
                  const Spacer(),
                  _buildSubtitle(),
                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: NavigationService.goBack,
        child: Icon(
          Icons.arrow_back_ios,
          color: const Color(0xFF1A2B4A),
          size: 24.sp,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Touch ID sensor to verify yourself',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF1A2B4A),
        height: 1.3,
      ),
    );
  }

  Widget _buildFingerprintIcon(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationService.navigateTo(AppRoutes.touchIdVerified),
      child: Image.asset(
        ImageManager.finger,
        width: 160.w,
        height: 160.w,
        color: const Color(0xFF6B7280),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Please verify your identity using touch\nID and it will proceed automatically.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF374151),
        height: 1.5,
      ),
    );
  }
}
