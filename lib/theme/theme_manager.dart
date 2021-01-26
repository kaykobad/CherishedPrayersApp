import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  SharedPreferences prefs;
  static bool _isDarkThemeSelected = false;

  void setProperties(bool isDarkMode, SharedPreferences pref) {
    _isDarkThemeSelected = isDarkMode;
    prefs = pref;
  }
  
  ThemeMode currentThemeMode() {
    return _isDarkThemeSelected ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() async {
    _isDarkThemeSelected = !_isDarkThemeSelected;
    await prefs.setBool('isDarkTheme', _isDarkThemeSelected);
    notifyListeners();
  }
}