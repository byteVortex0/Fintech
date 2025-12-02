import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// OnboardingNextButton - Custom circular navigation button
///
/// Provides next slide button for slides 1-3 of onboarding carousel.
/// Uses secondary color for strong CTA visibility as per design guidelines.
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
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Center(
          child: Icon(Icons.arrow_forward, color: Colors.white, size: 24.sp),
        ),
      ),
    );
  }
}
