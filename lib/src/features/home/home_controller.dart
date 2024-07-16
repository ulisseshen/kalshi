import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:kalshi/src/shared/services/financial_calculator_service.dart';

import '../../shared/models/financial_status.dart';

class HomeController {
  HomeController(FinancialCalculatorService calculator) : _calculator = calculator;

  final FinancialCalculatorService _calculator;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final textAnnualIncomeController = TextEditingController();
  final textMonthlyCostsController = TextEditingController();

  double get _annualIncome => formatterAnnual.getUnformattedValue().toDouble();
  double get _monthlyCosts => formatterMonthly.getUnformattedValue().toDouble();

  final formatterAnnual = CurrencyTextInputFormatter.currency(
    locale: 'en_US',
    decimalDigits: 0,
    symbol: '',
  );

  final formatterMonthly = CurrencyTextInputFormatter.currency(
    locale: 'en_US',
    decimalDigits: 0,
    symbol: '',
  );

  String? validateMonthlyAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid amount';
    }

    final amount = formatterMonthly.getUnformattedValue();
    if (amount <= 0) {
      return 'Please, the amount must be greater than zero';
    }

    return null;
  }

  String? validateAnnualIncome(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid amount';
    }

    final amount = formatterAnnual.getUnformattedValue();
    if (amount <= 0) {
      return 'Please, the amount must be greater than zero';
    }

    return null;
  }

  bool isFormValid() {
    return _formKey.currentState?.validate() ?? false;
  }

  FinancialStatus calculateFinancialStatus() {
    final status = _calculator.calculateStatus(_annualIncome, _monthlyCosts);

    return status;
  }
}
