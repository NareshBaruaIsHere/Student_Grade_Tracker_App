import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  ThemeMode _themeMode = ThemeMode.light;

  int get selectedIndex => _selectedIndex;
  ThemeMode get themeMode => _themeMode;

  void changeTab(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}