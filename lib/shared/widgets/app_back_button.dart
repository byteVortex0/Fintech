import 'package:flutter/material.dart';
import 'package:fintech/core/navigation/navigation_service.dart';

/// Shared back button widget for consistent navigation across the app
class AppBackButton extends StatelessWidget {
  final Color? iconColor;

  const AppBackButton({super.key, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: iconColor ?? Theme.of(context).iconTheme.color,
      ),
      onPressed: () => NavigationService.goBack(context),
    );
  }
}
