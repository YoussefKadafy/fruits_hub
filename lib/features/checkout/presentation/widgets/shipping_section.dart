import 'package:flutter/material.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/shipping_item.dart';

class ShippingSection extends StatelessWidget {
  const ShippingSection({
    super.key,
    this.selectedIndex,
    this.onItemSelected,
  });

  final int? selectedIndex;
  final ValueChanged<int>? onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShippingItem(
          title: 'الدفع عند الاستلام',
          subtitle: 'التقليم من المكان',
          payingCount: '45',
          isSelected: selectedIndex == 0,
          onTap: () => onItemSelected?.call(0),
        ),
        8.height,
        ShippingItem(
          title: 'الدفع اونلاين',
          subtitle: 'يرجى تحديد طريقة الدفع',
          payingCount: '45',
          isSelected: selectedIndex == 1,
          onTap: () => onItemSelected?.call(1),
        ),
      ],
    );
  }
}
