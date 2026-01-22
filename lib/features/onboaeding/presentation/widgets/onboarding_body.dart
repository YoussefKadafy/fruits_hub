import 'package:flutter/material.dart';
import 'package:fruits_hub/features/onboaeding/presentation/widgets/page_view_section.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Expanded(child: PageViewSection())],
    );
  }
}
