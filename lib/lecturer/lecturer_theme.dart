import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LecturerTheme {
  // Colors
  static const maroon = Color(0xFF6F0000); // background
  static const surface = Color(0xFFF2F1ED); // cards/inputs
  static const text = Color(0xFF161616);    // main text
  static const green = Color(0xFF025F20);   // accent for approve
  static const radius = 20.0;

  static ThemeData theme() {
    final base = ThemeData(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: maroon,
      colorScheme: ColorScheme.fromSeed(
        seedColor: maroon,
        primary: maroon,
        onPrimary: Colors.white,
        secondary: green,
        surface: surface,
        onSurface: text,
        background: maroon,
        onBackground: Colors.white,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: const TextStyle(color: Color(0xFF666666)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: green,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
      textTheme: GoogleFonts.aliceTextTheme(base.textTheme).apply(
        bodyColor: text,
        displayColor: text,
      ),
    );
  }
}
