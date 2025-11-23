import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/utils/fonts/font_weight_helper.dart';

class OnboardingGetStarted extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onRegister;

  const OnboardingGetStarted({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Login Button
        ElevatedButton(
          onPressed: onLogin,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A2B4A),
            minimumSize: Size(double.infinity, 56.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        // Register Button
        OutlinedButton(
          onPressed: onRegister,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFF1A2B4A), width: 2),
            minimumSize: Size(double.infinity, 56.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            'Register',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: const Color(0xFF1A2B4A),
            ),
          ),
        ),
      ],
    );
  }
}
