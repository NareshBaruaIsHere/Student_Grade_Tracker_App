import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF006C4F),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF39656C),
      onSecondary: Color(0xFFFFFFFF),
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      surface: Color(0xFFF4FBF7),
      onSurface: Color(0xFF161D1A),
    ),
    scaffoldBackgroundColor: const Color(0xFFF4FBF7),
    appBarTheme: const AppBarTheme(centerTitle: true),
    cardTheme: const CardThemeData(
      elevation: 1,
      margin: EdgeInsets.symmetric(vertical: 6),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      filled: true,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF4CD9A8),
      onPrimary: Color(0xFF003828),
      secondary: Color(0xFFA0CED6),
      onSecondary: Color(0xFF00363D),
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      surface: Color(0xFF0E1512),
      onSurface: Color(0xFFDCE5E0),
    ),
    scaffoldBackgroundColor: const Color(0xFF0E1512),
    appBarTheme: const AppBarTheme(centerTitle: true),
    cardTheme: const CardThemeData(
      elevation: 1,
      margin: EdgeInsets.symmetric(vertical: 6),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      filled: true,
    ),
  );
}
