import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// OnboardingNextButton - Custom circular navigation button
///
/// Provides next slide button for slides 1-3 of onboarding carousel.
/// Uses GestureDetector for tap detection (custom ripple feedback if needed).
/// Circular design (60x60) matches modern onboarding UI patterns.
class OnboardingNextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const OnboardingNextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    /// GestureDetector handles tap events with custom Container styling
    /// Provides flexibility for adding ripple effects or haptic feedback if needed
    return GestureDetector(
      onTap: onPressed,

      /// Circular button container (60x60 responsive size)
      /// Dark navy color (#1A2B4A) for strong CTA visibility
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF1A2B4A),
        ),

        /// Center-aligned arrow icon for next page navigation
        child: Center(
          child: Icon(Icons.arrow_forward, color: Colors.white, size: 24.sp),
        ),
      ),
    );
  }
}
