import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  void _skipOnboarding() async {
    await _saveOnboardingComplete();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('login');
    }
  }

  void _goToLogin() async {
    await _saveOnboardingComplete();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('login');
    }
  }

  void _goToRegister() async {
    await _saveOnboardingComplete();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('register');
    }
  }

  Future<void> _saveOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentIndex == onboardingItems.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // PageView
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
          // Bottom Controls
          Positioned(
            bottom: 40.h,
            left: 24.w,
            right: 24.w,
            child: Column(
              children: [
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
