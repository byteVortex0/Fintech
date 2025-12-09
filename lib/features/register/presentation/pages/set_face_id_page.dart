import '../../../../core/utils/image_manager.dart';
import '../../../../core/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../login/presentation/widgets/curved_background.dart';

class SetFaceIdPage extends StatelessWidget {
  const SetFaceIdPage({super.key});

  void _handleSkip(BuildContext context) =>
      NavigationService.navigateToAndRemoveUntil(context, '/login');

  void _handleContinue(BuildContext context) =>
      NavigationService.navigateTo(context, '/face_id_scanning');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    _buildHeader(context),
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

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'Set Your Face ID',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Add your face ID to make your account\nmore secure.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyMedium?.color,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildFaceIdSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(32.w),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isDark ? const Color(0xFF3E3E3E) : const Color(0xFFE5E7EB),
              width: 1,
            ),
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
              color: Theme.of(context).textTheme.bodyLarge?.color,
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
                side: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                ),
              ),
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.secondary,
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
                backgroundColor: Theme.of(context).colorScheme.secondary,
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
