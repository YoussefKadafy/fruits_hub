import 'package:flutter/material.dart';
import 'package:fruits_hub/features/cart/presentation/widgets/cart_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('السلة')),
      body: CartBody(),
    );
  }
}
