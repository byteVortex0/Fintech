import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/onboarding_item.dart';
import 'package:fintech/core/utils/fonts/font_weight_helper.dart';

/// OnboardingSlide - Individual slide widget for PageView carousel
///
/// Each slide displays an image and accompanying text content.
/// Used in OnboardingPage's PageView.builder for carousel rendering.
/// Designed to work responsively across different screen sizes.
class OnboardingSlide extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingSlide({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /// SafeArea prevents content overlap with system UI (notches, status bars)
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Image Section: 60% of available space (flex: 3)
              /// Using Flex ensures consistent image area across different screen heights
              /// BoxFit.contain preserves aspect ratio without clipping
              /// Max height 300.h prevents oversized images on larger devices
              Expanded(
                flex: 3,
                child: Center(
                  child: Image.asset(
                    item.image,
                    height: 300.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              /// Text Section: 40% of available space (flex: 2)
              /// Flex ratio 3:2 balances visual hierarchy between image and text
              /// Responsive typography using flutter_screenutil (.sp for font sizes)
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// Slide title with bold weight and larger size for prominence
                    /// height: 1.3 provides tight line spacing for headers
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeightHelper.bold,
                        color: const Color(0xFF1A2B4A),
                        height: 1.3,
                      ),
                    ),
                    /// Vertical spacing between title and description
                    SizedBox(height: 16.h),
                    /// Slide subtitle with regular weight and muted color for supporting text
                    /// height: 1.5 provides comfortable line spacing for body text
                    Text(
                      item.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.regular,
                        color: const Color(0xFF666D80),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
