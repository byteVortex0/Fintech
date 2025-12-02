import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import '../../data/models/onboarding_item.dart';
import '../widgets/onboarding_slide.dart';
import '../widgets/onboarding_indicators.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_get_started.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;
  int _currentIndex = 0;

  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: 'Welcome To Crypto X',
      subtitle: 'Your gateway to secure cryptocurrency trading',
      image: 'assets/images/onboarding_1.png',
    ),
    OnboardingItem(
      title: 'Transaction Security',
      subtitle: 'Bank-level encryption protects your assets',
      image: 'assets/images/onboarding_2.png',
    ),
    OnboardingItem(
      title: 'Fast And Reliable Market Updated',
      subtitle: 'Real-time data from global cryptocurrency markets',
      image: 'assets/images/onboarding_3.png',
    ),
    OnboardingItem(
      title: 'Get Started Now!',
      subtitle: 'Join thousands of traders worldwide',
      image: 'assets/images/onboarding_4.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipOnboarding(BuildContext context) async {
    await _saveOnboardingComplete();
    if (mounted && context.mounted) {
      NavigationService.navigateToAndReplace(context, '/login');
    }
  }

  void _goToLogin(BuildContext context) async {
    await _saveOnboardingComplete();
    if (mounted && context.mounted) {
      NavigationService.navigateToAndReplace(context, '/login');
    }
  }

  void _goToRegister(BuildContext context) async {
    await _saveOnboardingComplete();
    if (mounted && context.mounted) {
      NavigationService.navigateToAndReplace(context, '/register');
    }
  }

  Future<void> _saveOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
  }

  @override
  Widget build(BuildContext context) {
    /// Determines if current slide is the last one to control bottom UI rendering
    /// Slides 1-3: Show Skip button, Indicators, Next button
    /// Slide 4: Show Login and Register buttons
    final isLastPage = _currentIndex == onboardingItems.length - 1;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          /// PageView manages horizontal scrolling through slides
          /// Updates _currentIndex on page change, triggering UI state updates
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemCount: onboardingItems.length,
            itemBuilder: (context, index) {
              return OnboardingSlide(item: onboardingItems[index]);
            },
          ),

          /// Bottom Controls: Dynamic UI based on slide position
          /// Positioned over PageView to maintain persistent navigation options
          Positioned(
            bottom: 40.h,
            left: 24.w,
            right: 24.w,
            child: Column(
              children: [
                /// Slides 1-3: Navigation controls (Skip, Indicators, Next)
                if (!isLastPage)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => _skipOnboarding(context),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      OnboardingIndicators(
                        count: onboardingItems.length,
                        activeIndex: _currentIndex,
                      ),
                      OnboardingNextButton(onPressed: _nextPage),
                    ],
                  )
                /// Final slide: Call-to-action buttons (Login or Register)
                else
                  OnboardingGetStarted(
                    onLogin: () => _goToLogin(context),
                    onRegister: () => _goToRegister(context),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
