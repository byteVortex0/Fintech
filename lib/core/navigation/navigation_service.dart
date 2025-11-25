import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

/// Centralized navigation service for the entire app
/// Provides context-free navigation using a global navigator key
/// All navigation throughout the app should use this service for consistency
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> navigateToAndReplace(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> navigateToAndRemoveUntil(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  static void goBack() {
    navigatorKey.currentState?.pop();
  }

  // Navigation helpers for common routes
  static Future<dynamic> goToLogin() => navigateTo(AppRoutes.login);
  static Future<dynamic> goToRegister() => navigateTo(AppRoutes.register);
  static Future<dynamic> goToHome() => navigateToAndRemoveUntil(AppRoutes.home);
  static Future<dynamic> goToFaceIdScanning() =>
      navigateTo(AppRoutes.faceIdScanning);
  static Future<dynamic> goToTouchIdScanning() =>
      navigateTo(AppRoutes.touchIdScanning);
  static Future<dynamic> goToFaceIdVerified() =>
      navigateTo(AppRoutes.faceIdVerified);
  static Future<dynamic> goToTouchIdVerified() =>
      navigateTo(AppRoutes.touchIdVerified);
}

