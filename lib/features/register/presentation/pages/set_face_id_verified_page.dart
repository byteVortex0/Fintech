import '../../../../core/utils/image_manager.dart';
import '../../../../core/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Face ID verification success confirmation
class SetFaceIdVerifiedPage extends StatelessWidget {
  const SetFaceIdVerifiedPage({super.key});

  void _handleContinue(BuildContext context) =>
      NavigationService.navigateToAndRemoveUntil(context, '/login');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(),
          _buildContent(context),
          _buildBackButton(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return SizedBox.expand(
      child: Image.asset(
        ImageManager.faceIdBg,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            _buildFaceIdCard(),
            SizedBox(height: 32.h),
            _buildVerifiedText(),
            const Spacer(),
            _buildContinueButton(context),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }

  Widget _buildFaceIdCard() {
    return Builder(
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 48.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCheckIcon(context),
            SizedBox(height: 16.h),
            Text(
              'Face ID',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckIcon(BuildContext context) {
    return Container(
      width: 70.w,
      height: 70.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 2.5,
        ),
      ),
      child: Icon(
        Icons.check,
        color: Theme.of(context).colorScheme.secondary,
        size: 40.sp,
      ),
    );
  }

  Widget _buildVerifiedText() {
    return Column(
      children: [
        Text(
          "You're Ready!",
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(
            'Face ID has been set up successfully',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SizedBox(
        width: double.infinity,
        height: 52.h,
        child: ElevatedButton(
          onPressed: () => _handleContinue(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26.r),
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

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 48.h,
      left: 16.w,
      child: SafeArea(
        child: GestureDetector(
          onTap: () => NavigationService.goBack(context),
          child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24.sp),
        ),
      ),
    );
  }
}
