import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/utils/image_manager.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import '../widgets/curved_background.dart';

class TouchIdScanningPage extends StatelessWidget {
  const TouchIdScanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        onTap: () => NavigationService.goBack(context),
        child: Icon(
          Icons.arrow_back_ios,
          color: Theme.of(context).iconTheme.color,
          size: 24.sp,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Builder(
      builder: (context) => Text(
        'Touch ID sensor to verify yourself',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 26.sp,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).textTheme.bodyLarge?.color,
          height: 1.3,
        ),
      ),
    );
  }

  Widget _buildFingerprintIcon(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationService.navigateTo(context, '/touch_id_verified'),
      child: Image.asset(
        ImageManager.finger,
        width: 160.w,
        height: 160.w,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Builder(
      builder: (context) => Text(
        'Please verify your identity using touch\nID and it will proceed automatically.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyMedium?.color,
          height: 1.5,
        ),
      ),
    );
  }
}
