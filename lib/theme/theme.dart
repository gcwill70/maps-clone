import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: const Color(0xFFFF9900),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      toggleableActiveColor: const Color(0xFFFF9900),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      primaryColor: const Color(0xFFFF9900),
      backgroundColor: const Color(0xFF323234),
      textTheme: Typography().white,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
      ),
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        accentColor: const Color(0xFFFF9900),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(color: Colors.black),
          primary: const Color(0xFFFF9900),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: const Color(0xFF323234),
          side: const BorderSide(
            color: Colors.transparent,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          alignment: Alignment.centerLeft,
          textStyle: const TextStyle(
            fontSize: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        circularTrackColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
      ),
    );
  }
}
