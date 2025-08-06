import 'package:flutter/material.dart';
import 'package:guruh2/core/theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = true;

  bool get isDark => _isDark;
  ThemeData get currentTheme => _isDark ? AppTheme.dark : AppTheme.light;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
