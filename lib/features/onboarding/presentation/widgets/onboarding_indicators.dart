import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// OnboardingIndicators - Visual progress indicator widget
///
/// Displays pagination dots showing current position in the onboarding carousel.
/// Uses SmoothPageIndicator with WormEffect for smooth, animated transitions.
/// UI-only component: Navigation is handled by OnboardingPage's PageView controller,
/// not through dot tapping (onDotClicked intentionally disabled).
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
    return SmoothPageIndicator(
      /// PageController with activeIndex keeps indicators synced with current slide
      /// Read-only mode: indicator reflects actual slide position from OnboardingPage
      controller: PageController(initialPage: activeIndex),
      count: count,

      /// WormEffect Configuration:
      /// - Creates smooth, animated worm-like transition between dots
      /// - Blue (#2E5BFF) accent for active dot to match app theme
      /// - Light gray (#D0D0D0) for inactive dots for subtle visual hierarchy
      /// - 8x8 dot size and 6px spacing maintains compact indicator bar
      effect: const WormEffect(
        dotHeight: 8,
        dotWidth: 8,
        spacing: 6,
        activeDotColor: Color(0xFF2E5BFF),
        dotColor: Color(0xFFD0D0D0),
      ),

      /// onDotClicked intentionally disabled (empty callback)
      /// Reason: All pagination logic controlled by OnboardingPage's PageView
      /// and Next button - direct dot tapping would bypass navigation flow
      /// Future: Can be enabled if direct page jumping feature is needed
      onDotClicked: (index) {},
    );
  }
}
