import 'package:flutter/material.dart';

import 'app/theme.dart';
import 'src/features/home/home_page.dart';
import 'src/features/home/home_controller.dart';
import 'src/shared/services/financial_calculator_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Kalshi App',
      theme: AppTheme.data,
      home: HomePage(controller: HomeController(FinancialCalculatorService())),
    );
  }
}
