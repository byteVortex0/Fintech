import 'package:flutter/material.dart';

import '../color_manager.dart';

class ColorThemeExtension extends ThemeExtension<ColorThemeExtension> {
  final Color? bgColor;

  const ColorThemeExtension({required this.bgColor});

  @override
  ThemeExtension<ColorThemeExtension> copyWith({Color? bgColor}) {
    return ColorThemeExtension(bgColor: bgColor ?? this.bgColor);
  }

  @override
  ThemeExtension<ColorThemeExtension> lerp(
    covariant ThemeExtension<ColorThemeExtension>? other,
    double t,
  ) {
    if (other is! ColorThemeExtension) {
      return this;
    }
    return ColorThemeExtension(bgColor: Color.lerp(bgColor, other.bgColor, t));
  }

  static const ColorThemeExtension light = ColorThemeExtension(
    bgColor: Colors.white,
  );

  static const ColorThemeExtension dark = ColorThemeExtension(
    bgColor: DarkColorManager.bgColor,
  );
}
