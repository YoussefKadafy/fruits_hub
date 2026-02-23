import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/shipping_item.dart';

class ShippingSection extends StatelessWidget {
  const ShippingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [ShippingItem()]);
  }
}
