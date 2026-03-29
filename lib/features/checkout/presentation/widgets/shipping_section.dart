import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/features/checkout/domain/entity/address_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/checkout_entity.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/shipping_item.dart';

class ShippingSection extends StatelessWidget {
  const ShippingSection({
    super.key,
    this.selectedIndex,
    this.onItemSelected, this.onAddressChanged,
  });

  final int? selectedIndex;
  final ValueChanged<int>? onItemSelected;
  final ValueChanged<AddressEntity?>? onAddressChanged;

  @override
  Widget build(BuildContext context) {
   var checkoutEntity = context.read<CheckoutEntity>();
    return Column(
      children: [
        ShippingItem(
          title: 'الدفع عند الاستلام',
          subtitle: 'التقليم من المكان',
          payingCount: '45',
          isSelected: selectedIndex == 0,
          onTap: () { 
            checkoutEntity.isPayCash = true;
            
            onItemSelected?.call(0);
          
   } ),
        8.height,
        ShippingItem(
          title: 'الدفع اونلاين',
          subtitle: 'يرجى تحديد طريقة الدفع',
          payingCount: ' 45',
          isSelected: selectedIndex == 1,
          onTap: () { onItemSelected?.call(1);
          checkoutEntity.isPayCash = false;
          
  }),
      ],
    );
  }
}
