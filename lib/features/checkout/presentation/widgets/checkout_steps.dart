import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/checkout_step.dart';

class CheckoutStepsVerification extends StatelessWidget {
  const CheckoutStepsVerification({super.key, this.currentStep = 0});
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        4,
        (index) => Expanded(
          child: CheckoutStep(
            title: stepsData()[index],
            isChecked: index < currentStep,
            stepNumber: index + 1,
          ),
        ),
      ),
    );
  }

  List<String> stepsData() {
    return ['الشحن', 'العنوان', 'الدفع', 'المراجعة'];
  }
}
