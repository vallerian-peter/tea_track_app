import 'package:flutter/material.dart';

import '../../../core/storage/storage_manager.dart';

/// Holds and persists the app [ThemeMode].
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode;

  ThemeProvider({ThemeMode? initialMode})
      : _themeMode = initialMode ?? _safeInitialMode();

  static ThemeMode _safeInitialMode() {
    try {
      return StorageManager.themeMode;
    } catch (_) {
      return ThemeMode.system;
    }
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    try {
      StorageManager.setThemeMode(mode);
    } catch (_) {}
    notifyListeners();
  }
}
