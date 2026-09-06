import 'package:flutter/material.dart';

class AppDarkTheme {
  static ThemeData theme = ThemeData(
    brightness: Brightness.dark,

    primaryColor: Colors.blue,

    scaffoldBackgroundColor: Color(0xff121212),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),

    cardTheme: const CardThemeData(
      color: Color(0xff1E1E1E),
      elevation: 3,
    ),
  );
}