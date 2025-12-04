import 'package:flutter/material.dart';

sealed class LightColorManager {
  LightColorManager._();
  static const Color cardColor = Color(0xFFF7F2FA);
  static const Color screenBackground = Color(0xFFF5F8FE);
  static const Color scaffoldBackground = Color(0xFFF8F9FA);
  static const Color borderColor = Color(0xFF5E5E5E);
}

sealed class DarkColorManager {
  DarkColorManager._();
  static const Color cardColor = Color(0xFF1D1B20);
  static const Color screenBackground = Color(0xFF121212);
  static const Color scaffoldBackground = Color(0xFF181818);
  static const Color borderColor = Color(0xFF3E3E3E);
  static const Color toolbarTextColor = Color(0xFF186C7B);
  static const Color toolbarBackgroundColor = Color(0xFF2C2A30);
  static const Color backgroundColor = Color(0xFF121212);
}
