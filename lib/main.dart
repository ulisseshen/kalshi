// ignore_for_file: prefer_const_constructors

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xFF001C95),
          background: Colors.white,
          onPrimary: Colors.white,
          surface: Colors.white,
        ),
        textTheme: TextTheme(
          titleMedium: GoogleFonts.workSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF001C95),
          ),
        ),
        cardTheme: CardTheme(
          // color: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 4,
          // margin: const EdgeInsets.all(16),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(16),
          // ),
        ),
        useMaterial3: true,
      ),
      home: PageView(
        children: const [
          MyHomePage(),
          StatusPage(
            status: FinancialStatus.healthy,
          ),
          StatusPage(
            status: FinancialStatus.average,
          ),
          StatusPage(
            status: FinancialStatus.unhealthy,
          ),
        ],
      ),
    );
  }
}

class FinancialCalculator {
  final double annualGrossIncome;
  final double monthlyCosts;

  FinancialCalculator({
    required this.annualGrossIncome,
    required this.monthlyCosts,
  });

  FinancialStatus calculateFinancialStatus() {
    double annualNetCompensation =
        annualGrossIncome - (annualGrossIncome * 0.08);
    double annualCosts = monthlyCosts * 12;

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

class Assets {
  static const String kalshiLogo = 'assets/kalshi_logo.svg';
  static const String kalshiTextLogo = 'assets/kalshi_text_logo.svg';
  static const String padlockIcon = 'assets/icons/padlock.svg';
  static const String dollarSignIcon = 'assets/icons/dollar_sign.svg';
}

class VerticalSpace {
  /// A constant SizedBox with a height of 8.
  static const SizedBox small = SizedBox(height: 8);

  /// A constant SizedBox with a height of 16.
  static const SizedBox medium = SizedBox(height: 16);

  /// A constant SizedBox with a height of 24.
  static const SizedBox large = SizedBox(height: 24);

  /// A constant SizedBox with a height of 32.
  static const SizedBox extraLarge = SizedBox(height: 32);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.onPrimary,
        centerTitle: true,
        title: SvgPicture.asset(Assets.kalshiTextLogo),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _Headline(),
              SizedBox(
                height: 24,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _FinancialForm(),
                ),
              ),
              SizedBox(height: 24),
              _Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusPage extends StatelessWidget {
  const StatusPage({super.key, required this.status});

  final FinancialStatus status;

  String getStatusText() {
    if (status == FinancialStatus.average) {
      return 'Average';
    }

    if (status == FinancialStatus.unhealthy) {
      return 'Unhealthy';
    }

    return 'Healthy';
  }

  String getStatusTitle() {
    if (status == FinancialStatus.average) {
      return 'There is room for improvement.';
    }

    if (status == FinancialStatus.unhealthy) {
      return 'Caution!';
    }

    return 'Congratulations!';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.onPrimary,
        centerTitle: true,
        title: SvgPicture.asset(Assets.kalshiTextLogo),
      ),
      backgroundColor: Color(0xFFF4F8FA),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text.rich(
                  const TextSpan(
                    text: 'Here\'s your ',
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.2,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'financial wellness score.',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ],
                  ),
                  style: GoogleFonts.workSans(
                    color: Color(0xFF001C95),
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              VerticalSpace.large,
              Card(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SvgPicture.asset(Assets.kalshiLogo),
                        VerticalSpace.large,
                        _StatusBar(status: status),
                        VerticalSpace.large,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            getStatusTitle(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.rubik(
                              color: Color(0xFF1E2A32),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                        ),
                        Text(
                          'Your financial wellness score is ',
                          style: GoogleFonts.workSans(
                            color: Color(0xFF4D6475),
                            fontSize: 14,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          getStatusText(),
                          style: GoogleFonts.workSans(
                              color: Color(0xFF4D6475),
                              fontSize: 14,
                              height: 1.2,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        VerticalSpace.extraLarge,
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Return',
                            style: GoogleFonts.workSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side:
                                BorderSide(color: Color(0xFF001C95), width: 2),
                            minimumSize: Size(double.infinity, 56),
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(height: 24),
              _Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

enum FinancialStatus { healthy, average, unhealthy }

class _StatusBar extends StatelessWidget {
  const _StatusBar({required this.status});

  final FinancialStatus status;

  @override
  Widget build(BuildContext context) {
    if (status == FinancialStatus.average) {
      return averageBar();
    } else if (status == FinancialStatus.unhealthy) {
      return unhealthyBar();
    }
    return healthyBar();
  }

  Widget healthyBar() {
    return Stack(
      children: const [
        _OneBar(color: Color(0xFF04C761), slotSize: SlotSize.three),
        _OneBar(color: Color(0xFF04C761), slotSize: SlotSize.two),
        _OneBar(color: Color(0xFF04C761), slotSize: SlotSize.one),
      ],
    );
  }

  Widget averageBar() {
    return Stack(
      children: const [
        _OneBar(color: Color(0xFFE9EEF2), slotSize: SlotSize.three),
        _OneBar(color: Color(0xFFFFC032), slotSize: SlotSize.two),
        _OneBar(color: Color(0xFFFFC032), slotSize: SlotSize.one),
      ],
    );
  }

  Widget unhealthyBar() {
    return Stack(
      children: const [
        _OneBar(color: Color(0xFFE9EEF2), slotSize: SlotSize.three),
        _OneBar(color: Color(0xFFE9EEF2), slotSize: SlotSize.two),
        _OneBar(color: Color(0xFFD32A36), slotSize: SlotSize.one),
      ],
    );
  }
}

enum SlotSize { one, two, three }

class _OneBar extends StatelessWidget {
  const _OneBar({required this.color, required this.slotSize});

  final Color color;
  final SlotSize slotSize;

  int getBarSize() {
    if (slotSize == SlotSize.one) {
      return 1;
    } else if (slotSize == SlotSize.two) {
      return 2;
    } else {
      return 3;
    }
  }

  int getFlex() {
    if (slotSize == SlotSize.one) {
      return 2;
    } else if (slotSize == SlotSize.two) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: getBarSize(),
          child: Stack(
            children: [
              Container(
                height: 16,
                clipBehavior: Clip.hardEdge,
                decoration: ShapeDecoration(
                  color: color,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ],
          ),
        ),
        if (slotSize != SlotSize.three)
          Spacer(
            flex: getFlex(),
          )
      ],
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Text.rich(
        const TextSpan(
          text: 'Let\'s find out your ',
          style: TextStyle(
            fontSize: 18,
            height: 1.2,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'financial wellness score.',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
        style: GoogleFonts.workSans(
          color: Color(0xFF001C95),
          height: 1.2,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _FinancialForm extends StatelessWidget {
  _FinancialForm();

  final _formKey = GlobalKey<FormState>();
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(Assets.kalshiLogo),
        SizedBox(height: 16),
        Text(
          'Financial wellness test',
          textAlign: TextAlign.center,
          style: GoogleFonts.rubik(
            color: Color(0xFF1E2A32),
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
        Text(
          'Enter your financial information below',
          textAlign: TextAlign.center,
          style: GoogleFonts.workSans(
            color: Color(0xFF708797),
            fontSize: 14,
            height: 1.2,
          ),
        ),
        SizedBox(height: 16),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Annual income'),
              TextFormField(
                controller: textAnnualIncomeController,
                style: GoogleFonts.rubik(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: Color(0xFF4D6475),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[formatterAnnual],
                decoration: InputDecoration(
                  hintText: '0,000',
                  hintStyle: GoogleFonts.rubik(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    color: Color(0xFF4D6475).withOpacity(0.5),
                  ),
                  border: OutlineInputBorder(),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                    child: SvgPicture.asset(Assets.dollarSignIcon),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 24,
                  ),
                  constraints: BoxConstraints(
                    minHeight: 56,
                  ),
                ),
                validator: (value) {
                  //is greater than zero;
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid amount';
                  }

                  final amount = formatterAnnual.getUnformattedValue();
                  if (amount <= 0) {
                    return 'Please, the amount must be greater than zero';
                  }

                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Monthly Costs'),
              TextFormField(
                controller: textMonthlyCostsController,
                style: GoogleFonts.rubik(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: Color(0xFF4D6475),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[formatterMonthly],
                decoration: InputDecoration(
                  hintText: '0,000',
                  hintStyle: GoogleFonts.rubik(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    color: Color(0xFF4D6475).withOpacity(0.5),
                  ),
                  border: OutlineInputBorder(),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                    child: SvgPicture.asset(Assets.dollarSignIcon),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 24,
                  ),
                ),
                validator: (value) {
                  //is greater than zero;
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid amount';
                  }

                  final amount = formatterMonthly.getUnformattedValue();
                  if (amount <= 0) {
                    return 'Please, the amount must be greater than zero';
                  }

                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final calculator = FinancialCalculator(
                      annualGrossIncome: _annualIncome,
                      monthlyCosts: _monthlyCosts,
                    );
                    final status = calculator.calculateFinancialStatus();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StatusPage(
                          status: status,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF001C95),
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 56),
                ),
                child: Text(
                  'Continue',
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          VerticalSpace.medium,
          SvgPicture.asset(Assets.padlockIcon),
          VerticalSpace.medium,
          Text(
            'Your financial information is encrypted and secure. We\'ll never share or sell any of your personal data.',
            style: GoogleFonts.workSans(fontSize: 12, color: Color(0xFF708797)),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
