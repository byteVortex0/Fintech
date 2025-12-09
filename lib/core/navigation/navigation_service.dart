import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Centralized navigation service using GoRouter (Rule #16)
///
/// CRITICAL RULE: ALL navigation in the app MUST use this service
/// - NEVER use Navigator.of(context) directly
/// - NEVER use hardcoded route strings - use AppRoutes constants
/// - Ensures consistent navigation behavior across the entire app
/// - Handles GoRouter context-based navigation methods
sealed class NavigationService {
  NavigationService._();

  /// Push route to navigation stack (allows back navigation)
  static void navigateTo(BuildContext context, String path) =>
      context.push(path);

  /// Replace current route (no back to previous screen)
  static void navigateToAndReplace(BuildContext context, String path) =>
      context.go(path);

  /// Navigate and clear entire stack (used for logout, login -> home)
  static void navigateToAndRemoveUntil(BuildContext context, String path) =>
      context.go(path);

  /// Navigate back if navigation stack allows
  static void goBack(BuildContext context) {
    if (context.canPop()) context.pop();
  }

  // Navigation helpers for common routes
  static void goToLogin(BuildContext context) => navigateTo(context, '/login');
  static void goToRegister(BuildContext context) =>
      navigateTo(context, '/register');
  static void goToHome(BuildContext context) =>
      navigateToAndRemoveUntil(context, '/home');
  static void goToFaceIdScanning(BuildContext context) =>
      navigateTo(context, '/face_id_scanning');
  static void goToTouchIdScanning(BuildContext context) =>
      navigateTo(context, '/touch_id_scanning');
  static void goToFaceIdVerified(BuildContext context) =>
      navigateTo(context, '/face_id_verified');
  static void goToTouchIdVerified(BuildContext context) =>
      navigateTo(context, '/touch_id_verified');
  static void goToSetFaceId(BuildContext context) =>
      navigateTo(context, '/set_face_id');
  static void goToSetFaceIdVerified(BuildContext context) =>
      navigateTo(context, '/set_face_id_verified');
  static void goToSetFingerprint(BuildContext context) =>
      navigateTo(context, '/set_fingerprint');
  static void goToSetFingerprintVerified(BuildContext context) =>
      navigateTo(context, '/set_fingerprint_verified');
}
