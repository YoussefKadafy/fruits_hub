import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/checkout_body.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الدفع')),
      body: SafeArea(child: CheckoutBody()),
    );
  }
}
