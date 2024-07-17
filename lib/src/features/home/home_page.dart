import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              VerticalSpacing.large,
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _FinancialForm(controller),
                ),
              ),
              VerticalSpacing.large,
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
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Text.rich(
        TextSpan(
          text: 'Let\'s find out your ',
          style: textTheme.headlineMedium,
          children: <TextSpan>[
            TextSpan(
              text: 'financial wellness score.',
              style: textTheme.headlineSmall,
            ),
          ],
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
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        SvgPicture.asset(Assets.kalshiLogo),
        VerticalSpacing.medium,
        Text(
          'Financial wellness test',
          textAlign: TextAlign.center,
          style: textTheme.titleMedium,
        ),
        Text(
          'Enter your financial information below',
          textAlign: TextAlign.center,
          style: textTheme.bodySmall,
        ),
        VerticalSpacing.medium,
        Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Annual income'),
              TextFormField(
                key: const Key('annual_income_text_field'),
                controller: controller.textAnnualIncomeController,
                style: textTheme.bodyLarge,
                keyboardType: TextInputType.number,
                inputFormatters: [controller.formatterAnnual],
                decoration: InputDecoration(
                  hintText: '0,000',
                  hintStyle: textTheme.bodyLarge!.copyWith(
                    color: textTheme.bodyLarge!.color!.withOpacity(0.5),
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
              VerticalSpacing.medium,
              const Text('Monthly Costs'),
              TextFormField(
                key: const Key('monthly_costs_text_field'),
                controller: controller.textMonthlyCostsController,
                style: textTheme.bodyLarge,
                keyboardType: TextInputType.number,
                inputFormatters: [controller.formatterMonthly],
                decoration: InputDecoration(
                  hintText: '0,000',
                  hintStyle: textTheme.bodyLarge!.copyWith(
                    color: textTheme.bodyLarge!.color!.withOpacity(0.5),
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
              VerticalSpacing.medium,
              ElevatedButton(
                key: const Key('continue_button'),
                onPressed: () {
                  if (controller.isFormValid()) {
                    final status = controller.calculateFinancialStatus();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        settings: const RouteSettings(name: '/status'),
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
                  textStyle: textTheme.labelLarge,
                ),
                child: const Text('Continue'),
              )
            ],
          ),
        )
      ],
    );
  }
}
