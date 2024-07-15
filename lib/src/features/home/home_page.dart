import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalshi/src/features/home/home_controller.dart';

import '../../shared/widgets/footer.dart';
import '../../utils/utils.dart';
import '../status/status_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.controller});

  final HomeController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController get controller => widget.controller;

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Headline(),
              const SizedBox(
                height: 24,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _FinancialForm(controller),
                ),
              ),
              const SizedBox(height: 24),
              const Footer(),
            ],
          ),
        ),
      ),
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
          color: const Color(0xFF001C95),
          height: 1.2,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _FinancialForm extends StatelessWidget {
  const _FinancialForm(this.controller);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(Assets.kalshiLogo),
        const SizedBox(height: 16),
        Text(
          'Financial wellness test',
          textAlign: TextAlign.center,
          style: GoogleFonts.rubik(
            color: const Color(0xFF1E2A32),
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
        Text(
          'Enter your financial information below',
          textAlign: TextAlign.center,
          style: GoogleFonts.workSans(
            color: const Color(0xFF708797),
            fontSize: 14,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Annual income'),
              TextFormField(
                controller: controller.textAnnualIncomeController,
                style: GoogleFonts.rubik(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: const Color(0xFF4D6475),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [controller.formatterAnnual],
                decoration: InputDecoration(
                  hintText: '0,000',
                  hintStyle: GoogleFonts.rubik(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    color: const Color(0xFF4D6475).withOpacity(0.5),
                  ),
                  border: const OutlineInputBorder(),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                    child: SvgPicture.asset(Assets.dollarSignIcon),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    maxHeight: 24,
                  ),
                  constraints: const BoxConstraints(
                    minHeight: 56,
                  ),
                ),
                validator: controller.validateAnnualIncome,
              ),
              const SizedBox(height: 16),
              const Text('Monthly Costs'),
              TextFormField(
                controller: controller.textMonthlyCostsController,
                style: GoogleFonts.rubik(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: const Color(0xFF4D6475),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [controller.formatterMonthly],
                decoration: InputDecoration(
                  hintText: '0,000',
                  hintStyle: GoogleFonts.rubik(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    color: const Color(0xFF4D6475).withOpacity(0.5),
                  ),
                  border: const OutlineInputBorder(),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                    child: SvgPicture.asset(Assets.dollarSignIcon),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    maxHeight: 24,
                  ),
                ),
                validator: controller.validateMonthlyAmount,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (controller.isFormValid()) {
                    final status = controller.calculateFinancialStatus();
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
                  backgroundColor: const Color(0xFF001C95),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
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
