import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightThemeData =
      themeData(lightColorScheme, lightFocusColor, lightAppBarTheme);

  static final lightFocusColor = Colors.black.withOpacity(0.12);

  static var lightColorScheme = ColorScheme(
    primary: Colors.deepPurple[300] ?? Colors.white,
    onPrimary: Colors.white,
    secondary: Colors.deepPurple[200] ?? Colors.white,
    onSecondary: Colors.black,
    error: Colors.redAccent,
    onError: Colors.white,
    background: const Color(0xffebe5ff),
    onBackground: Colors.black,
    surface: Colors.deepPurple[300] ?? Colors.white,
    onSurface: Colors.white,
    brightness: Brightness.light,
  );

  static const AppBarTheme lightAppBarTheme = AppBarTheme(
      backgroundColor: Color(0xffebe5ff), foregroundColor: Colors.white);

  static ThemeData themeData(
      ColorScheme colorscheme, Color focusColor, AppBarTheme appBarTheme) {
    return ThemeData(
      colorScheme: colorscheme,
      canvasColor: colorscheme.background,
      scaffoldBackgroundColor: colorscheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      appBarTheme: appBarTheme,
    );
  }
}
