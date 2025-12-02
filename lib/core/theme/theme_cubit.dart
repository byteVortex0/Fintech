import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech/core/service/local_storage/theme_storage_service.dart';

/// Simple Cubit for managing theme state (light/dark mode)
class ThemeCubit extends Cubit<bool> {
  final ThemeStorageService _storageService;

  /// Constructor: false = light mode, true = dark mode
  ThemeCubit(this._storageService) : super(false);

  /// Load saved theme preference on app start
  Future<void> loadSavedTheme() async {
    final savedTheme = await _storageService.loadTheme();
    emit(savedTheme == 'dark');
  }

  /// Toggle between light and dark mode
  Future<void> toggleTheme() async {
    final newTheme = !state;
    emit(newTheme);
    await _storageService.saveTheme(newTheme ? 'dark' : 'light');
  }

  /// Set specific theme mode
  Future<void> setTheme(bool isDark) async {
    emit(isDark);
    await _storageService.saveTheme(isDark ? 'dark' : 'light');
  }
}
