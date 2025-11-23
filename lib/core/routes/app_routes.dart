import 'package:fintech/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'base_routes.dart';

class AppRoutes {
  static const String home = 'home';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case home:
        return BaseRoutes(page: HomeScreen());

      default:
        return BaseRoutes(page: HomeScreen());
    }
  }
}
