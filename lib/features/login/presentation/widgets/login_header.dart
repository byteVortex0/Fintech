import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// LoginHeader - Reusable header widget for biometric pages
///
/// Displays title and subtitle text with responsive styling.
/// Used in biometric scanning pages (face_id_scanning, touch_id_scanning)
/// to provide consistent header formatting across authentication flows.
class LoginHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const LoginHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A2B4A),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF666D80),
          ),
        ),
      ],
    );
  }
}
