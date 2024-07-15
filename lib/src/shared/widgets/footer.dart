
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/utils.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          VerticalSpacing.medium,
          SvgPicture.asset(Assets.padlockIcon),
          VerticalSpacing.medium,
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