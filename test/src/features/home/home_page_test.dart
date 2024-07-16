import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalshi/src/features/home/home_controller.dart';
import 'package:kalshi/src/features/home/home_page.dart';
import 'package:kalshi/src/shared/services/financial_calculator_service.dart';

class NavigationObserverSpy extends NavigatorObserver {
  final List<String> _routeNames = [];

  List<String> get routeNames => _routeNames;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeNames.add(route.settings.name!);
  }
}

void main() {
  late HomeController controller;

  setUp(() => controller = HomeController(FinancialCalculatorService()));

  testWidgets(
      'Should show erro message when amount is empty in the both fields',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: HomePage(controller: controller)));

    await tester.tap(find.byKey(const Key('continue_button')));
    await tester.pump();

    expect(find.text('Please enter a valid amount'), findsNWidgets(2));
  });

  testWidgets('Should show erro message when amount is zero in the both fields',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: HomePage(controller: controller)));

    await tester.enterText(
        find.byKey(const Key('annual_income_text_field')), '0');
    await tester.enterText(
        find.byKey(const Key('monthly_costs_text_field')), '0');

    await tester.tap(find.byKey(const Key('continue_button')));
    await tester.pump();

    expect(find.text('Please, the amount must be greater than zero'),
        findsNWidgets(2));
  });

  testWidgets(
      'Should show erro message when amount is empty in the annual income field',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: HomePage(controller: controller)));

    await tester.enterText(
        find.byKey(const Key('monthly_costs_text_field')), '1000');

    await tester.tap(find.byKey(const Key('continue_button')));
    await tester.pump();

    expect(find.text('Please enter a valid amount'), findsOneWidget);
  });

  testWidgets(
      'Should show erro message when amount is zero in the annual income field',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: HomePage(controller: controller)));

    await tester.enterText(
        find.byKey(const Key('annual_income_text_field')), '0');
    await tester.enterText(
        find.byKey(const Key('monthly_costs_text_field')), '1000');

    await tester.tap(find.byKey(const Key('continue_button')));
    await tester.pump();

    expect(find.text('Please, the amount must be greater than zero'),
        findsOneWidget);
  });

  testWidgets(
      'Should show erro message when amount is empty in the monthly costs field',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: HomePage(controller: controller)));

    await tester.enterText(
        find.byKey(const Key('annual_income_text_field')), '1000');

    await tester.tap(find.byKey(const Key('continue_button')));
    await tester.pump();

    expect(find.text('Please enter a valid amount'), findsOneWidget);
  });

  testWidgets(
      'Should show erro message when amount is zero in the monthly costs field',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: HomePage(controller: controller)));

    await tester.enterText(
        find.byKey(const Key('annual_income_text_field')), '1000');
    await tester.enterText(
        find.byKey(const Key('monthly_costs_text_field')), '0');

    await tester.tap(find.byKey(const Key('continue_button')));
    await tester.pump();

    expect(find.text('Please, the amount must be greater than zero'),
        findsOneWidget);
  });

  testWidgets('Should clear erro message when amount is valid',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: HomePage(controller: controller)));

    await tester.enterText(
        find.byKey(const Key('annual_income_text_field')), '0');
    await tester.enterText(
        find.byKey(const Key('monthly_costs_text_field')), '0');

    await tester.tap(find.byKey(const Key('continue_button')));
    await tester.pump();

    expect(find.text('Please, the amount must be greater than zero'),
        findsNWidgets(2));

    await tester.enterText(
        find.byKey(const Key('annual_income_text_field')), '1000');
    await tester.enterText(
        find.byKey(const Key('monthly_costs_text_field')), '1000');

    await tester.tap(find.byKey(const Key('continue_button')));
    await tester.pump();

    expect(find.text('Please, the amount must be greater than zero'),
        findsNothing);
  });

  testWidgets('Should navigate to the next page when the form is valid',
      (WidgetTester tester) async {
    final observer = NavigationObserverSpy();

    await tester.pumpWidget(MaterialApp(
      home: HomePage(controller: controller),
      navigatorObservers: [observer],
    ));

    await tester.enterText(
        find.byKey(const Key('annual_income_text_field')), '1000');
    await tester.enterText(
        find.byKey(const Key('monthly_costs_text_field')), '1000');

    await tester.tap(find.byKey(const Key('continue_button')));
    await tester.pumpAndSettle();

    expect(observer.routeNames.last, '/status');
  });
}
