import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/checked_step.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/unchecked_step.dart';

class CheckoutStep extends StatelessWidget {
  const CheckoutStep({
    super.key,
    required this.title,
    required this.isChecked,
    required this.stepNumber,
    this.onTap,
  });
  final String title;
  final int stepNumber;
  final bool isChecked;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedCrossFade(
        firstChild: CheckedStep(title: title),
        secondChild: UncheckedStep(title: title, stepNumber: stepNumber),
        crossFadeState: isChecked
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}
