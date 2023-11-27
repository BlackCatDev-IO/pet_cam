import 'package:flutter/material.dart';

class AppTheme {
  static const mainThemeColor = Color.fromARGB(255, 34, 29, 40);
  
  static final theme = ThemeData(
    scaffoldBackgroundColor: mainThemeColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: mainThemeColor,
      foregroundColor: Colors.white,
    ),
    navigationBarTheme: const NavigationBarThemeData(
      surfaceTintColor: Colors.white,
      backgroundColor: mainThemeColor,
      labelTextStyle: MaterialStatePropertyAll(
        TextStyle(color: Colors.white),
      ),
    ),
  );
}
