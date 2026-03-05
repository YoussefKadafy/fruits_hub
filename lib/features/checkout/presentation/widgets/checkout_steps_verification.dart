import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/checkout_step.dart';

class CheckoutStepsVerification extends StatelessWidget {
  const CheckoutStepsVerification({super.key, this.currentStep = 1, this.onStepTapped});
  final int currentStep;
  final void Function(int)? onStepTapped;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        stepsData().length,
        (index) => Expanded(
          child: CheckoutStep(
            title: stepsData()[index],
            isChecked: index < currentStep,
            stepNumber: index + 1,
            onTap: () => onStepTapped?.call(index + 1),
          ),
        ),
      ),
    );
  }

  List<String> stepsData() {
    return ['الشحن', 'العنوان', 'المراجعة'];
  }
}
