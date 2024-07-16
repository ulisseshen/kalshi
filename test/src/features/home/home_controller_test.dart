import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalshi/src/features/home/home_controller.dart';
import 'package:kalshi/src/features/home/home_page.dart';
import 'package:kalshi/src/shared/models/financial_status.dart';
import 'package:kalshi/src/shared/services/financial_calculator_service.dart';

class FinancialCalculatorServiceSpy extends FinancialCalculatorService {
  int callCount = 0;
  @override
  FinancialStatus calculateStatus(double annualIncome, double monthlyCosts) {
    callCount++;
    return FinancialStatus.healthy;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late HomeController sut;
  late FinancialCalculatorServiceSpy calculator;

  setUp(() {
    calculator = FinancialCalculatorServiceSpy();
    sut = HomeController(calculator);
  });

  test('Should validate monthly amount', () {
    String? result = sut.validateMonthlyAmount(null);

    expect(result, 'Please enter a valid amount');

    result = sut.validateMonthlyAmount('');

    expect(result, 'Please enter a valid amount');

    result = sut.validateMonthlyAmount('0');

    expect(result, 'Please, the amount must be greater than zero');
  });

  test('Should validate annual income', () {
    String? result = sut.validateAnnualIncome(null);

    expect(result, 'Please enter a valid amount');

    result = sut.validateAnnualIncome('');

    expect(result, 'Please enter a valid amount');

    result = sut.validateAnnualIncome('0');

    expect(result, 'Please, the amount must be greater than zero');
  });

  testWidgets('Should test isFormValid()', (tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage(controller: sut)));

    bool result = sut.isFormValid();

    expect(result, false);

    await tester.enterText(
        find.byKey(const Key('annual_income_text_field')), '1000');

    result = sut.isFormValid();

    expect(result, false);

    await tester.enterText(
        find.byKey(const Key('monthly_costs_text_field')), '1000');

    await tester.pumpAndSettle();

    result = sut.isFormValid();

    expect(result, true);
  });

  test('Should call calculate the financial status', () {

    sut.calculateFinancialStatus();

    expect(calculator.callCount, 1);

    sut.calculateFinancialStatus();

    expect(calculator.callCount, 2);

  });
}
