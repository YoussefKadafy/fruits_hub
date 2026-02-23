import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/checked_step.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/unchecked_step.dart';

class CheckoutStep extends StatelessWidget {
  const CheckoutStep({
    super.key,
    required this.title,
    required this.isChecked,
    required this.stepNumber,
  });
  final String title;
  final int stepNumber;
  final bool isChecked;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: CheckedStep(title: title),
      secondChild: UncheckedStep(title: title, stepNumber: stepNumber),
      crossFadeState: isChecked
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 300),
    );
  }
}
