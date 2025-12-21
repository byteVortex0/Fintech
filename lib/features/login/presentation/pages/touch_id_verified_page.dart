import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/navigation/navigation_service.dart';
import '../widgets/curved_background.dart';

class TouchIdVerifiedPage extends StatelessWidget {
  const TouchIdVerifiedPage({super.key});

  void _handleContinue(BuildContext context) =>
      NavigationService.navigateToAndRemoveUntil(context, '/home');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
    return Builder(
      builder: (context) => Container(
        width: 140.w,
        height: 140.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.check, color: Colors.white, size: 70.sp),
      ),
    );
  }

  Widget _buildVerifiedText() {
    return Builder(
      builder: (context) => Column(
        children: [
          Text(
            "You're verified",
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "You have been verified your\ninformation completely. Let's make\ntransactions!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 48.h,
      left: 16.w,
      child: SafeArea(
        child: GestureDetector(
          onTap: () => NavigationService.goBack(context),
          child: Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color, size: 24.sp),
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
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
          elevation: 0,
        ),
        child: Text(
          'Continue To Home',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
