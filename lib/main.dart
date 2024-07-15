import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalshi/src/features/home/home_controller.dart';

import 'src/features/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Kalshi App',
      theme: ThemeData(
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
      ),
      home: HomePage(controller: HomeController(),),
    );
  }
}