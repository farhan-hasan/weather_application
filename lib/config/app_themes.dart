import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightThemeData =
      themeData(lightColorScheme, lightFocusColor, lightAppBarTheme);

  static final lightFocusColor = Colors.black.withOpacity(0.12);

  static const lightColorScheme = ColorScheme(
    primary: Color(0xffe3b5f6),
    onPrimary: Colors.white,
    secondary: Color(0xFFEFF3F3),
    onSecondary: Colors.black,
    error: Colors.redAccent,
    onError: Colors.white,
    background: Color(0xffebe5ff),
    onBackground: Colors.black,
    surface: Color(0xffe3b5f6),
    onSurface: Colors.black,
    brightness: Brightness.light,
  );

  static const AppBarTheme lightAppBarTheme = AppBarTheme(
      backgroundColor: Color(0xFFe0b6ff), foregroundColor: Colors.white);

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
