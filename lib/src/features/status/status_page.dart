import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/models/financial_status.dart';
import '../../shared/widgets/footer.dart';
import '../../utils/utils.dart';

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
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.onPrimary,
        centerTitle: true,
        title: SvgPicture.asset(Assets.kalshiTextLogo),
      ),
      backgroundColor: const Color(0xFFF4F8FA),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text.rich(
                  TextSpan(
                    text: 'Here\'s your ',
                    style: textTheme.headlineSmall,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'financial wellness score.',
                        style: textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              VerticalSpacing.large,
              Card(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SvgPicture.asset(Assets.kalshiLogo),
                        VerticalSpacing.large,
                        _StatusBar(status: status),
                        VerticalSpacing.large,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            getStatusTitle(),
                            textAlign: TextAlign.center,
                            style: textTheme.titleMedium!.copyWith(height: 1.5),
                          ),
                        ),
                        Text(
                          'Your financial wellness score is ',
                          style: textTheme.bodyMedium!.copyWith(height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          getStatusText(),
                          style: textTheme.labelMedium,
                          textAlign: TextAlign.center,
                        ),
                        VerticalSpacing.extraLarge,
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: Color(0xFF001C95), width: 2),
                            minimumSize: const Size(double.infinity, 56),
                            textStyle: textTheme.labelLarge,
                          ),
                          child: const Text('Return'),
                        ),
                      ],
                    )),
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

class _StatusBar extends StatelessWidget {
  const _StatusBar({required this.status});

  final FinancialStatus status;

  @override
  Widget build(BuildContext context) {
    if (status == FinancialStatus.average) {
      return const _AverageBar();
    }

    if (status == FinancialStatus.unhealthy) {
      return const _UnhealthyBar();
    }

    return const _HelthyBar();
  }
}

class _HelthyBar extends StatelessWidget {
  const _HelthyBar();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _OneBar(color: Color(0xFF04C761), slotSize: _SlotSize.three),
        _OneBar(color: Color(0xFF04C761), slotSize: _SlotSize.two),
        _OneBar(color: Color(0xFF04C761), slotSize: _SlotSize.one),
      ],
    );
  }
}

class _AverageBar extends StatelessWidget {
  const _AverageBar();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _OneBar(color: Color(0xFFE9EEF2), slotSize: _SlotSize.three),
        _OneBar(color: Color(0xFFFFC032), slotSize: _SlotSize.two),
        _OneBar(color: Color(0xFFFFC032), slotSize: _SlotSize.one),
      ],
    );
  }
}

class _UnhealthyBar extends StatelessWidget {
  const _UnhealthyBar();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _OneBar(color: Color(0xFFE9EEF2), slotSize: _SlotSize.three),
        _OneBar(color: Color(0xFFE9EEF2), slotSize: _SlotSize.two),
        _OneBar(color: Color(0xFFD32A36), slotSize: _SlotSize.one),
      ],
    );
  }
}

enum _SlotSize { one, two, three }

class _OneBar extends StatelessWidget {
  const _OneBar({required this.color, required this.slotSize});

  final Color color;
  final _SlotSize slotSize;

  int getBarSize() {
    if (slotSize == _SlotSize.one) {
      return 1;
    } else if (slotSize == _SlotSize.two) {
      return 2;
    } else {
      return 3;
    }
  }

  int getFlex() {
    if (slotSize == _SlotSize.one) {
      return 2;
    }
    if (slotSize == _SlotSize.two) {
      return 1;
    }

    throw Exception('Should not be called at SlotSize.three');
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
                decoration: ShapeDecoration(
                  color: color,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ],
          ),
        ),
        if (slotSize != _SlotSize.three)
          Spacer(
            flex: getFlex(),
          )
      ],
    );
  }
}
