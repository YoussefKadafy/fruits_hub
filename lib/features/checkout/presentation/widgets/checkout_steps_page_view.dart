import 'package:flutter/material.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/address_entity.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/address_input_section.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/review_section.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/shipping_section.dart';

class CheckoutStepsPageView extends StatelessWidget {
  CheckoutStepsPageView({
    super.key,
    required PageController pageController,
    this.selectedShippingIndex,
    this.onShippingSelected,
    required this.cart,
    this.address,
    this.isPayCash,
  }) : _pageController = pageController;

  final PageController _pageController;
  final int? selectedShippingIndex;
  final ValueChanged<int>? onShippingSelected;
  final CartEntity cart;
  final AddressEntity? address;
  final bool? isPayCash;
  
  // Key to access AddressInputSection state
  final GlobalKey<AddressInputSectionState> _addressKey = GlobalKey<AddressInputSectionState>();

  List<Widget> get pages => [
        ShippingSection(
          selectedIndex: selectedShippingIndex,
          onItemSelected: onShippingSelected,
        ),
        AddressInputSection(key: _addressKey),
        ReviewSection(cart: cart, address: address, isPayCash: isPayCash),
      ];

  bool validateAddressStep() {
    final addressSection = _addressKey.currentState;
    if (addressSection != null) {
      return addressSection.validate();
    }
    return false;
  }

  AddressEntity? getAddress() {
    final addressSection = _addressKey.currentState;
    if (addressSection != null) {
      return addressSection.getAddress();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: pages.length,
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return pages[index];
      },
    );
  }
}
