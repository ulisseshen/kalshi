import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get data {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF001C95),
        background: Colors.white,
        onPrimary: Colors.white,
        surface: Colors.white,
      ),
      textTheme: TextTheme(
        headlineMedium: GoogleFonts.workSans(
          color: const Color(0xFF001C95),
          fontSize: 18,
          height: 1.2,
        ),
        headlineSmall: GoogleFonts.workSans(
          color: const Color(0xFF001C95),
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        titleMedium: GoogleFonts.rubik(
          color: const Color(0xFF1E2A32),
          fontSize: 20,
          fontWeight: FontWeight.w500,
          height: 1.2,
        ),
        bodySmall: GoogleFonts.workSans(
          color: const Color(0xFF708797),
          fontSize: 14,
          height: 1.2,
        ),
        bodyLarge: GoogleFonts.rubik(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          height: 1.2,
          color: const Color(0xFF4D6475),
        ),
        labelLarge: GoogleFonts.workSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      ),
      cardTheme: const CardTheme(
        surfaceTintColor: Colors.white,
        elevation: 4,
      ),
      useMaterial3: true,
    );
  }
}
