import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// OnboardingIndicators - Visual progress indicator widget
///
/// Displays pagination dots showing current position in the onboarding carousel.
/// Note: onDotClicked is intentionally disabled because all pagination logic is
/// controlled by OnboardingPage's PageView and Next button.
class OnboardingIndicators extends StatelessWidget {
  final int count;
  final int activeIndex;

  const OnboardingIndicators({
    super.key,
    required this.count,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return SmoothPageIndicator(
          controller: PageController(initialPage: activeIndex),
          count: count,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            spacing: 6,
            activeDotColor: Theme.of(context).colorScheme.primary,
            dotColor: isDark
                ? const Color(0xFF666D80)
                : const Color(0xFFD0D0D0),
          ),
          onDotClicked: (index) {},
        );
      },
    );
  }
}
