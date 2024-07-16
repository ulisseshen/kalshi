import 'package:flutter_test/flutter_test.dart';
import 'package:kalshi/src/shared/models/financial_status.dart';
import 'package:kalshi/src/shared/services/financial_calculator_service.dart';

void main() {
  late FinancialCalculatorService sut;

  setUp(() {
    sut = FinancialCalculatorService();
  });

  test('Should return healthy status when annual income is greater than monthly costs', () {
    final result = sut.calculateStatus(1000, 10);

    expect(result, FinancialStatus.healthy);
  });

  test('Should return medium status when annual income is equal to monthly costs', () {
    final result = sut.calculateStatus(1000, 30);

    expect(result, FinancialStatus.average);
  });

  test('Should return unhealthy status when annual income is less than monthly costs', () {
    final result = sut.calculateStatus(1000, 80);

    expect(result, FinancialStatus.unhealthy);
  });

}
