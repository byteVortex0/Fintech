import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
      controller: PageController(initialPage: activeIndex),
      count: count,
      effect: const WormEffect(
        dotHeight: 8,
        dotWidth: 8,
        spacing: 6,
        activeDotColor: Color(0xFF2E5BFF),
        dotColor: Color(0xFFD0D0D0),
      ),
      onDotClicked: (index) {},
    );
  }
}
