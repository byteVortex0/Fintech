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
    return navigatorKey.currentState?.pop();
  }

  // Navigation helpers for common routes
  static void goToLogin() => navigateTo(AppRoutes.login);
  static void goToRegister() => navigateTo(AppRoutes.register);
  static void goToHome() => navigateToAndRemoveUntil(AppRoutes.home);
  static void goToFaceIdScanning() => navigateTo(AppRoutes.faceIdScanning);
  static void goToTouchIdScanning() => navigateTo(AppRoutes.touchIdScanning);
  static void goToFaceIdVerified() => navigateTo(AppRoutes.faceIdVerified);
  static void goToTouchIdVerified() => navigateTo(AppRoutes.touchIdVerified);
  static void goToSetFaceId() => navigateTo(AppRoutes.setFaceId);
  static void goToSetFaceIdVerified() =>
      navigateTo(AppRoutes.setFaceIdVerified);
  static void goToSetFingerprint() => navigateTo(AppRoutes.setFingerprint);
  static void goToSetFingerprintVerified() =>
      navigateTo(AppRoutes.setFingerprintVerified);
  static void goToLoginAndRemoveUntil() =>
      navigateToAndRemoveUntil(AppRoutes.login);
}
