import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

import '../../shared/models/financial_status.dart';

class HomeController {
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
    double annualNetCompensation = _annualIncome - (_annualIncome * 0.08);
    double annualCosts = _monthlyCosts * 12;

    double costPercentage = annualCosts / annualNetCompensation;

    if (costPercentage <= 0.25) {
      return FinancialStatus.healthy;
    } else if (costPercentage <= 0.75) {
      return FinancialStatus.average;
    } else {
      return FinancialStatus.unhealthy;
    }
  }
}
