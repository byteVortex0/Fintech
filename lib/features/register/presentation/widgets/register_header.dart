import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// RegisterHeader - Reusable header widget for registration page
///
/// Displays title and descriptive text to introduce the signup flow.
/// Used in RegisterPage as the topmost section.
class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Create Your Account',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A2B4A),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Sign up to enjoy the best managing experience!',
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
}
