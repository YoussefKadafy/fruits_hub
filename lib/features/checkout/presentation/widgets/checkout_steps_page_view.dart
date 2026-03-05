import 'package:flutter/material.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_item_entity.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/address_input_section.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/review_section.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/shipping_section.dart';

class CheckoutStepsPageView extends StatelessWidget {
  CheckoutStepsPageView({
    super.key,
    required PageController pageController,
    this.selectedShippingIndex,
    this.onShippingSelected,
    this.cartItems,
    this.fullName,
    this.address,
    this.city,
    this.neighborhood,
    this.apartment,
    this.phone,
  }) : _pageController = pageController;

  final PageController _pageController;
  final int? selectedShippingIndex;
  final ValueChanged<int>? onShippingSelected;
  final List<CartItemEntity>? cartItems;
  final String? fullName;
  final String? address;
  final String? city;
  final String? neighborhood;
  final String? apartment;
  final String? phone;

  // Key to access AddressInputSection state
  final GlobalKey<AddressInputSectionState> _addressKey = GlobalKey<AddressInputSectionState>();

  List<Widget> get pages => [
        ShippingSection(
          selectedIndex: selectedShippingIndex,
          onItemSelected: onShippingSelected,
        ),
        AddressInputSection(key: _addressKey),
        const ReviewSection(),
      ];

  bool validateAddressStep() {
    final addressSection = _addressKey.currentState;
    if (addressSection != null) {
      return addressSection.validate();
    }
    return false;
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
