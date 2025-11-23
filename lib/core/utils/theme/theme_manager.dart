import 'package:flutter/material.dart';

import 'color_theme_extension.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    extensions: const <ThemeExtension<dynamic>>[ColorThemeExtension.light],
  );

  static ThemeData darkTheme = ThemeData(
    extensions: const <ThemeExtension<dynamic>>[ColorThemeExtension.dark],
  );
}
