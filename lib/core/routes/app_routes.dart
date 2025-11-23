import 'package:fintech/features/home/presentation/home_screen.dart';
import 'package:fintech/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'base_routes.dart';

class AppRoutes {
  static const String onboarding = 'onboarding';
  static const String home = 'home';
  static const String login = 'login';
  static const String register = 'register';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case onboarding:
        return BaseRoutes(page: const OnboardingPage());
      case home:
        return BaseRoutes(page: HomeScreen());
      case login:
        return BaseRoutes(page: const Placeholder()); // TODO: Create login page
      case register:
        return BaseRoutes(page: const Placeholder()); // TODO: Create register page

      default:
        return BaseRoutes(page: const OnboardingPage());
    }
  }
}
