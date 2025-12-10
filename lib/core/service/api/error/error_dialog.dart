import 'package:flutter/material.dart';
import 'error_model.dart';

/// Reusable error dialog widget for displaying friendly error messages
///
/// Shows errors with an optional retry button. Customizable title, message, and actions.
class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;
  final bool showRetry;

  const ErrorDialog({
    super.key,
    required this.message,
    this.title = 'Error',
    this.onRetry,
    this.onDismiss,
    this.showRetry = true,
  });

  /// Factory constructor to create dialog from ErrorModel
  factory ErrorDialog.fromErrorModel({
    required ErrorModel errorModel,
    VoidCallback? onRetry,
    VoidCallback? onDismiss,
    String? customTitle,
  }) {
    return ErrorDialog(
      title: customTitle ?? 'Error',
      message: errorModel.userMessage,
      onRetry: (errorModel.isRetryable && onRetry != null) ? onRetry : null,
      onDismiss: onDismiss,
      showRetry: errorModel.isRetryable,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: Text(message, style: const TextStyle(fontSize: 14)),
      actions: [
        if (showRetry && onRetry != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onRetry?.call();
            },
            child: const Text('Retry'),
          ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onDismiss?.call();
          },
          child: const Text('Dismiss'),
        ),
      ],
    );
  }

  /// Show the error dialog
  static Future<void> show({
    required BuildContext context,
    required String message,
    String title = 'Error',
    VoidCallback? onRetry,
    VoidCallback? onDismiss,
    bool showRetry = true,
  }) {
    return showDialog(
      context: context,
      builder: (_) => ErrorDialog(
        title: title,
        message: message,
        onRetry: onRetry,
        onDismiss: onDismiss,
        showRetry: showRetry,
      ),
    );
  }

  /// Show error dialog from ErrorModel
  static Future<void> showFromErrorModel({
    required BuildContext context,
    required ErrorModel errorModel,
    VoidCallback? onRetry,
    VoidCallback? onDismiss,
    String? customTitle,
  }) {
    return showDialog(
      context: context,
      builder: (_) => ErrorDialog.fromErrorModel(
        errorModel: errorModel,
        onRetry: onRetry,
        onDismiss: onDismiss,
        customTitle: customTitle,
      ),
    );
  }
}
