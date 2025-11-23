import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingNextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const OnboardingNextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF1A2B4A),
        ),
        child: Center(
          child: Icon(Icons.arrow_forward, color: Colors.white, size: 24.sp),
        ),
      ),
    );
  }
}
