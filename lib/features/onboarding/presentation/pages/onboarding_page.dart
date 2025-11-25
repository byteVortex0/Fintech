import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fintech/core/routes/app_routes.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import '../../data/models/onboarding_item.dart';
import '../widgets/onboarding_slide.dart';
import '../widgets/onboarding_indicators.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_get_started.dart';

/// OnboardingPage - Main orchestrator for the onboarding flow
///
/// This page serves as the state management hub for the complete onboarding experience.
/// Responsibilities:
/// - Manages PageView navigation through 4 onboarding slides
/// - Tracks current slide index for dynamic UI updates (Skip/Indicators/Next buttons)
/// - Handles navigation to Login or Register based on user choice
/// - Persists onboarding completion status to SharedPreferences
/// - Controls conditional UI rendering (Skip/Indicators vs Get Started buttons)
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  /// Controls PageView scroll position and animations
  /// Must be disposed in lifecycle to prevent memory leaks
  late PageController _pageController;

  /// Tracks current slide index (0-3) for UI state and navigation logic
  /// Updated via PageView.onPageChanged callback
  int _currentIndex = 0;

  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: 'Welcome To Crypto X',
      subtitle: 'Your gateway to secure cryptocurrency trading',
      image: 'assets/images/onboarding/1.png',
    ),
    OnboardingItem(
      title: 'Transaction Security',
      subtitle: 'Bank-level encryption protects your assets',
      image: 'assets/images/onboarding/2.png',
    ),
    OnboardingItem(
      title: 'Fast And Reliable Market Updated',
      subtitle: 'Real-time data from global cryptocurrency markets',
      image: 'assets/images/onboarding/3.png',
    ),
    OnboardingItem(
      title: 'Get Started Now!',
      subtitle: 'Join thousands of traders worldwide',
      image: 'assets/images/onboarding/4.png',
    ),
  ];

  /// Widget lifecycle initialization
  /// Initializes PageController for managing PageView transitions
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  /// Widget lifecycle cleanup
  /// Disposes PageController to free resources and prevent memory leaks
  /// Must be called before parent dispose
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Animates to next slide in PageView
  /// Only allows pagination if not on the last slide
  void _nextPage() {
    if (_currentIndex < onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Navigation flow: Skip button on slides 1-3
  /// Pattern: Save completion state → Check widget mounted → Navigate
  /// Uses NavigationService to prevent back-navigation to onboarding
  void _skipOnboarding() async {
    await _saveOnboardingComplete();
    if (mounted) {
      NavigationService.navigateToAndReplace(AppRoutes.login);
    }
  }

  /// Navigation flow: Login button on final slide
  /// Pattern: Save completion state → Check widget mounted → Navigate to Login
  /// Uses NavigationService to prevent back-navigation to onboarding
  void _goToLogin() async {
    await _saveOnboardingComplete();
    if (mounted) {
      NavigationService.navigateToAndReplace(AppRoutes.login);
    }
  }

  /// Navigation flow: Register button on final slide
  /// Pattern: Save completion state → Check widget mounted → Navigate to Register
  /// Uses NavigationService to prevent back-navigation to onboarding
  void _goToRegister() async {
    await _saveOnboardingComplete();
    if (mounted) {
      NavigationService.navigateToAndReplace(AppRoutes.register);
    }
  }

  /// Persists onboarding completion status to SharedPreferences
  /// This prevents re-showing onboarding screen on app restart
  /// Called before any navigation to ensure state is saved even if navigation fails
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
      backgroundColor: Colors.white,
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
                        onPressed: _skipOnboarding,
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xFF2E5BFF),
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
                    onLogin: _goToLogin,
                    onRegister: _goToRegister,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
