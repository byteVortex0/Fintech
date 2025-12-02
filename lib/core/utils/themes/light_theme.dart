import 'package:flutter/material.dart';
import 'package:fintech/core/utils/color_manager.dart';

ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: LightColorManager.scaffoldBackground,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF0063F7),
        secondary: Color(0xFF1E3A5F),
        surface: Colors.white,
        error: Color(0xFFFF5252),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: LightColorManager.scaffoldBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF1E3A5F)),
        titleTextStyle: TextStyle(
          color: Color(0xFF1E3A5F),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF1E3A5F)),
        bodyMedium: TextStyle(color: Color(0xFF757575)),
        titleLarge: TextStyle(
          color: Color(0xFF1E3A5F),
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF1E3A5F),
      ),
      cardTheme: const CardThemeData(
        color: Colors.white,
        elevation: 2,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF1A2B4A),
        unselectedItemColor: Color(0xFF9CA3AF),
        elevation: 8,
      ),
    );
