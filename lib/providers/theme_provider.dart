import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      // access via WidgetsBinding directly if context is not available,
      // though typically this is checked within a build method.
      // For toggle logic, we usually want to know the *explicit* setting.
      // But for "is it dark?", we check the setting.
      // A better "isDarkMode" often requires BuildContext.
      // Here we just return true if explicitly dark.
      return _themeMode == ThemeMode.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
