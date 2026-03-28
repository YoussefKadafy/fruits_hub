import 'package:flutter/material.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/address_entity.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/address_input_section.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/review_section.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/shipping_section.dart';

class CheckoutStepsPageView extends StatefulWidget {
  const CheckoutStepsPageView({
    super.key,
    required PageController pageController,
    this.selectedShippingIndex,
    this.onShippingSelected,
    required this.cart,
    this.address,
    this.isPayCash,  this.onStepTapped,
  }) : _pageController = pageController;
final void Function(int)? onStepTapped;
  final PageController _pageController;
  final int? selectedShippingIndex;
  final ValueChanged<int>? onShippingSelected;
  final CartEntity cart;
  final AddressEntity? address;
  final bool? isPayCash;

  @override
  State<CheckoutStepsPageView> createState() => CheckoutStepsPageViewState();
}

class CheckoutStepsPageViewState extends State<CheckoutStepsPageView> {
  final GlobalKey<AddressInputSectionState> _addressKey = GlobalKey<AddressInputSectionState>();

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
      itemCount: 3,
      controller: widget._pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return ShippingSection(
              selectedIndex: widget.selectedShippingIndex,
              onItemSelected: widget.onShippingSelected,
            );
          case 1:
            return AddressInputSection(key: _addressKey);
          case 2:
            return ReviewSection( onEditStep:  widget.onStepTapped,
              pageController: widget._pageController,
              cart: widget.cart,
              address: widget.address,
              isPayCash: widget.isPayCash,
              selectedShippingIndex: widget.selectedShippingIndex,
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
