import '../models/financial_status.dart';

class FinancialCalculatorService {
  FinancialStatus calculateStatus(double annualIncome, double monthlyCosts) {
    double annualNetCompensation = annualIncome - (annualIncome * 0.08);
    double annualCosts = monthlyCosts * 12;

    double costPercentage = annualCosts / annualNetCompensation;

    if (costPercentage <= 0.25) {
      return FinancialStatus.healthy;
    }

    if (costPercentage <= 0.75) {
      return FinancialStatus.average;
    }

    return FinancialStatus.unhealthy;
  }
}