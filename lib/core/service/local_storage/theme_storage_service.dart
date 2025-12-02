import 'package:shared_preferences/shared_preferences.dart';

/// Service for persisting theme preference
class ThemeStorageService {
  static const String _themeKey = 'app_theme_mode';

  /// Save theme mode ('light' or 'dark')
  Future<void> saveTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
  }

  /// Load saved theme mode, defaults to 'light'
  Future<String> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey) ?? 'light';
  }
}
