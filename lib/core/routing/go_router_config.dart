import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fintech/features/home/presentation/home_screen.dart';
import 'package:fintech/features/market/presentation/pages/market_screen.dart';
import 'package:fintech/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:fintech/features/login/presentation/pages/login_page.dart';
import 'package:fintech/features/login/presentation/pages/face_id_scanning_page.dart';
import 'package:fintech/features/login/presentation/pages/face_id_verified_page.dart';
import 'package:fintech/features/login/presentation/pages/touch_id_scanning_page.dart';
import 'package:fintech/features/login/presentation/pages/touch_id_verified_page.dart';
import 'package:fintech/features/register/presentation/pages/register_page.dart';
import 'package:fintech/features/register/presentation/pages/set_fingerprint_page.dart';
import 'package:fintech/features/register/presentation/pages/set_fingerprint_verified_page.dart';
import 'package:fintech/features/register/presentation/pages/set_face_id_page.dart';
import 'package:fintech/features/register/presentation/pages/set_face_id_verified_page.dart';
import 'package:fintech/shared/widgets/app_bottom_navigation.dart';

/// GoRouter configuration with two route groups:
/// 1. Auth routes: /onboarding, /login, /register, biometric flows (no navbar)
/// 2. Main routes: /home, /market, /portfolio, /settings (with persistent navbar via ShellRoute)
/// All navigation must use NavigationService (Rule #16)
final goRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    // Auth routes (no navbar)
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/face_id_scanning',
      builder: (context, state) => const FaceIdScanningPage(),
    ),
    GoRoute(
      path: '/face_id_verified',
      builder: (context, state) => const FaceIdVerifiedPage(),
    ),
    GoRoute(
      path: '/touch_id_scanning',
      builder: (context, state) => const TouchIdScanningPage(),
    ),
    GoRoute(
      path: '/touch_id_verified',
      builder: (context, state) => const TouchIdVerifiedPage(),
    ),
    GoRoute(
      path: '/set_fingerprint',
      builder: (context, state) => const SetFingerprintPage(),
    ),
    GoRoute(
      path: '/set_fingerprint_verified',
      builder: (context, state) => const SetFingerprintVerifiedPage(),
    ),
    GoRoute(
      path: '/set_face_id',
      builder: (context, state) => const SetFaceIdPage(),
    ),
    GoRoute(
      path: '/set_face_id_verified',
      builder: (context, state) => const SetFaceIdVerifiedPage(),
    ),

    // Main app routes with persistent bottom navbar
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: AppBottomNavigation(),
        );
      },
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/market',
          builder: (context, state) => const MarketScreen(),
        ),
        GoRoute(
          path: '/portfolio',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Portfolio - Coming Soon')),
          ),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Settings - Coming Soon')),
          ),
        ),
      ],
    ),
  ],
);
