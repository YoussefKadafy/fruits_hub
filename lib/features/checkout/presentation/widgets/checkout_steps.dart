import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/checkout_step.dart';

class CheckoutSteps extends StatelessWidget {
  const CheckoutSteps({super.key, required this.isChecked});
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        4,
        (index) => Expanded(
          child: CheckoutStep(
            title: stepsData()[index],
            isChecked: isChecked,
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
