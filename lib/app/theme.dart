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
          titleMedium: GoogleFonts.workSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF001C95),
          ),
        ),
        cardTheme:  const CardTheme(
          surfaceTintColor: Colors.white,
          elevation: 4,
        ),
        useMaterial3: true,
    );
  }

}
