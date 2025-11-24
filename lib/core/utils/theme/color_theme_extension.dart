import 'package:flutter/material.dart';

import '../color_manager.dart';

class ColorThemeExtension extends ThemeExtension<ColorThemeExtension> {
  final Color? backgroundColor;

  const ColorThemeExtension({required this.backgroundColor});

  @override
  ThemeExtension<ColorThemeExtension> copyWith({Color? backgroundColor}) {
    return ColorThemeExtension(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  ThemeExtension<ColorThemeExtension> lerp(
    covariant ThemeExtension<ColorThemeExtension>? other,
    double t,
  ) {
    if (other is! ColorThemeExtension) {
      return this;
    }
    return ColorThemeExtension(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
    );
  }

  static const ColorThemeExtension light = ColorThemeExtension(
    backgroundColor: Colors.white,
  );

  static const ColorThemeExtension dark = ColorThemeExtension(
    backgroundColor: DarkColorManager.backgroundColor,
  );
}
