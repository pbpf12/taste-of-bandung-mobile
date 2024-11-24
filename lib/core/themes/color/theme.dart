import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  final CookieRequest _request;

  ThemeProvider(this._request) {
    _loadTheme();
  }

  bool get isDarkMode => _isDarkMode;

  ThemeData get themeData => _isDarkMode ? ThemeData.dark() : ThemeData.light();

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    await _saveTheme();
  }

  Future<void> _loadTheme() async {
    final storedTheme = _request.local.getString('theme_mode');
    _isDarkMode = (storedTheme == 'dark');
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    await _request.local.setString('theme_mode', _isDarkMode ? 'dark' : 'light');
  }
}
