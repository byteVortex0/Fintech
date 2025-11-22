import 'package:flutter/material.dart';

import '../utils/theme/color_theme_extension.dart';

extension ContextExtension on BuildContext {
  //Colors
  ColorThemeExtension get color =>
      Theme.of(this).extension<ColorThemeExtension>()!;

  //Navigator
  void pop() => Navigator.of(this).pop();

  Future<dynamic> pushNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
  }) => Navigator.of(
    this,
  ).pushNamedAndRemoveUntil(routeName, arguments: arguments, (route) => false);
}
