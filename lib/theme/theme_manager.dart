import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  static bool _isDarkThemeSelected = false;

  ThemeMode currentThemeMode() {
    return _isDarkThemeSelected ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    _isDarkThemeSelected = !_isDarkThemeSelected;
    notifyListeners();
  }
}