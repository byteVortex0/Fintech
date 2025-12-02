import 'package:flutter/material.dart';
import 'package:fintech/core/utils/color_manager.dart';

ThemeData get darkTheme => ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DarkColorManager.scaffoldBackground,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF0063F7),
    secondary: Color(0xFF5B8DEF),
    surface: Color(0xFF1D1B20),
    error: Color(0xFFFF5252),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: DarkColorManager.scaffoldBackground,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Color(0xFFB0B0B0)),
    titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  cardTheme: const CardThemeData(
    color: DarkColorManager.cardColor,
    elevation: 2,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1D1B20),
    selectedItemColor: Color(0xFF0063F7),
    unselectedItemColor: Color(0xFF757575),
    elevation: 8,
  ),
);
