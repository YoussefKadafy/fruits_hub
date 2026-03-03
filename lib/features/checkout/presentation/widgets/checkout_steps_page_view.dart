import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/address_input_section.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/shipping_section.dart';

class CheckoutStepsPageView extends StatelessWidget {
  const CheckoutStepsPageView({
    super.key,
    required PageController pageController,
    this.selectedShippingIndex,
    this.onShippingSelected,
  }) : _pageController = pageController;

  final PageController _pageController;
  final int? selectedShippingIndex;
  final ValueChanged<int>? onShippingSelected;

  List<Widget> get pages => [
    ShippingSection(
      selectedIndex: selectedShippingIndex,
      onItemSelected: onShippingSelected,
    ),
    AddressInputSection(),
    SizedBox(),
    SizedBox(),
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 4,
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return pages[index];
      },
    );
  }
}
