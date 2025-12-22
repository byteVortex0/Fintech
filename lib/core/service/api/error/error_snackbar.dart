import 'package:flutter/material.dart';
import 'error_model.dart';

/// Reusable error snackbar widget with optional retry action
///
/// Shows error message in snackbar with customizable duration and retry button
class ErrorSnackbar {
  /// Show error snackbar with message
  static void show({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onRetry,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: onRetry != null
            ? SnackBarAction(
                label: 'Retry',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  onRetry.call();
                },
              )
            : null,
      ),
    );
  }

  /// Show error snackbar from ErrorModel
  static void showFromErrorModel({
    required BuildContext context,
    required ErrorModel errorModel,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onRetry,
  }) {
    final shouldShowRetry = errorModel.isRetryable && onRetry != null;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorModel.userMessage),
        duration: duration,
        action: shouldShowRetry
            ? SnackBarAction(
                label: 'Retry',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  onRetry.call();
                },
              )
            : null,
      ),
    );
  }

  /// Hide current snackbar
  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  /// Show error with custom styling
  static void showStyled({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onRetry,
    Color backgroundColor = const Color(0xFFD32F2F),
    TextStyle? textStyle,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textStyle ?? const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        action: onRetry != null
            ? SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  onRetry.call();
                },
              )
            : null,
      ),
    );
  }
}
