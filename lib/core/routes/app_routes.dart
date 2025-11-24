import 'package:fintech/features/home/presentation/home_screen.dart';
import 'package:fintech/features/login/presentation/pages/login_page.dart';
import 'package:fintech/features/login/presentation/pages/face_id_scanning_page.dart';
import 'package:fintech/features/login/presentation/pages/face_id_verified_page.dart';
import 'package:fintech/features/login/presentation/pages/touch_id_scanning_page.dart';
import 'package:fintech/features/login/presentation/pages/touch_id_verified_page.dart';
import 'package:fintech/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'base_routes.dart';

class AppRoutes {
  static const String onboarding = 'onboarding';
  static const String home = 'home';
  static const String login = 'login';
  static const String register = 'register';
  static const String faceIdScanning = 'face_id_scanning';
  static const String faceIdVerified = 'face_id_verified';
  static const String touchIdScanning = 'touch_id_scanning';
  static const String touchIdVerified = 'touch_id_verified';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case onboarding:
        return BaseRoutes(page: const OnboardingPage());
      case home:
        return BaseRoutes(page: HomeScreen());
      case login:
        return BaseRoutes(page: const LoginPage());
      case register:
        return BaseRoutes(
          page: const Placeholder(),
        ); // TODO: Create register page
      case faceIdScanning:
        return BaseRoutes(page: const FaceIdScanningPage());
      case faceIdVerified:
        return BaseRoutes(page: const FaceIdVerifiedPage());
      case touchIdScanning:
        return BaseRoutes(page: const TouchIdScanningPage());
      case touchIdVerified:
        return BaseRoutes(page: const TouchIdVerifiedPage());

      default:
        return BaseRoutes(page: const OnboardingPage());
    }
  }
}
