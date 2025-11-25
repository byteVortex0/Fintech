import 'package:fintech/features/home/presentation/home_screen.dart';
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
import 'package:fintech/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'base_routes.dart';

class AppRoutes {
  static const String onboarding = 'onboarding';
  static const String home = 'home';
  static const String login = 'login';
  static const String register = 'register';
  static const String market = 'market';
  static const String portfolio = 'portfolio';
  static const String settings = 'settings';
  static const String setFingerprint = 'set_fingerprint';
  static const String setFingerprintVerified = 'set_fingerprint_verified';
  static const String setFaceId = 'set_face_id';
  static const String setFaceIdVerified = 'set_face_id_verified';
  static const String faceIdScanning = 'face_id_scanning';
  static const String faceIdVerified = 'face_id_verified';
  static const String touchIdScanning = 'touch_id_scanning';
  static const String touchIdVerified = 'touch_id_verified';

  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    // final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case onboarding:
        return BaseRoutes(page: const OnboardingPage());
      case home:
        return BaseRoutes(page: HomeScreen());
      case login:
        return BaseRoutes(page: const LoginPage());
      case register:
        return BaseRoutes(page: const RegisterPage());
      case setFingerprint:
        return BaseRoutes(page: const SetFingerprintPage());
      case setFingerprintVerified:
        return BaseRoutes(page: const SetFingerprintVerifiedPage());
      case setFaceId:
        return BaseRoutes(page: const SetFaceIdPage());
      case setFaceIdVerified:
        return BaseRoutes(page: const SetFaceIdVerifiedPage());
      case faceIdScanning:
        return BaseRoutes(page: const FaceIdScanningPage());
      case faceIdVerified:
        return BaseRoutes(page: const FaceIdVerifiedPage());
      case touchIdScanning:
        return BaseRoutes(page: const TouchIdScanningPage());
      case touchIdVerified:
        return BaseRoutes(page: const TouchIdVerifiedPage());
      case market:
        // TODO: Implement market screen
        return BaseRoutes(page: const OnboardingPage());
      case portfolio:
        // TODO: Implement portfolio screen
        return BaseRoutes(page: const OnboardingPage());
      case settings:
        // TODO: Implement settings screen
        return BaseRoutes(page: const OnboardingPage());

      default:
        return BaseRoutes(page: const OnboardingPage());
    }
  }
}
