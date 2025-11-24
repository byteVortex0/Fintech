import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/utils/image_manager.dart';

class SocialLoginSection extends StatelessWidget {
  final VoidCallback onFingerprintPressed;
  final VoidCallback onFaceIdPressed;

  const SocialLoginSection({
    super.key,
    required this.onFingerprintPressed,
    required this.onFaceIdPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24.h),
        _buildDividerRow(),
        SizedBox(height: 24.h),
        _buildIconsRow(),
      ],
    );
  }

  Widget _buildDividerRow() {
    return Row(
      children: [
        Expanded(child: Divider(color: const Color(0xFFD1D5DB), thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Or login with',
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF6B7280),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(child: Divider(color: const Color(0xFFD1D5DB), thickness: 1)),
      ],
    );
  }

  Widget _buildIconsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onFingerprintPressed,
          child: Image.asset(
            ImageManager.finger,
            width: 56.w,
            height: 56.w,
            color: const Color(0xFF6B7280),
          ),
        ),
        SizedBox(width: 60.w),
        GestureDetector(
          onTap: onFaceIdPressed,
          child: Image.asset(
            ImageManager.faceId,
            width: 56.w,
            height: 56.w,
            color: const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }
}
