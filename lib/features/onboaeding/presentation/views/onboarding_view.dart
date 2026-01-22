import 'package:flutter/material.dart';
import 'package:fruits_hub/features/onboaeding/presentation/widgets/onboarding_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(bottom: true, top: false, child: OnboardingBody()),
    );
  }
}
