import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_button.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/address_entity.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/checkout_steps_verification.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/checkout_steps_page_view.dart';

class CheckoutBody extends StatefulWidget {
  const CheckoutBody({
    super.key,
    required PageController pageController,
    this.currentStep = 1,
    this.onNextPressed,
    this.onStepTapped, 
    required this.cart,
  }) : _pageController = pageController;

  final PageController _pageController;
  final int currentStep;
  final VoidCallback? onNextPressed;
  final void Function(int)? onStepTapped;
  final CartEntity cart;
  
  @override
  State<CheckoutBody> createState() => _CheckoutBodyState();
}

class _CheckoutBodyState extends State<CheckoutBody> {
  int? _selectedShippingIndex;
  final GlobalKey<dynamic> _pageViewKey = GlobalKey();
  
  // Address fields
  AddressEntity? _address; 

  bool _validateCurrentStep() {
    final currentStep = widget.currentStep;
    final pageView = _pageViewKey.currentWidget as CheckoutStepsPageView;
    
    // Step 1: Shipping
    if (currentStep == 1) {
      if (_selectedShippingIndex == null) {
        return false;
      }
    }
    // Step 2: Address
    if (currentStep == 2) {
      return pageView.validateAddressStep();
    }
    return true;
  }

  void _handleNextWithValidation() {
    // Save address when moving from step 2 to step 3
    if (widget.currentStep == 2) {
      final pageView = _pageViewKey.currentWidget as CheckoutStepsPageView;
      _address = pageView.getAddress();
    }
    
    if (_validateCurrentStep()) {
      widget.onNextPressed?.call();
    } else {
      _showValidationError();
    }
  }

  void _showValidationError() {
    String message;
    if (widget.currentStep == 1) {
      message = 'يرجى اختيار طريقة الشحن';
    } else if (widget.currentStep == 2) {
      message = 'يرجى إدخال العنوان بشكل صحيح';
    } else {
      message = 'يرجى إكمال البيانات المطلوبة';
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          20.height,
          CheckoutStepsVerification(
            currentStep: widget.currentStep,
            onStepTapped: widget.onStepTapped,
          ),
          32.height,
          Expanded(
            child: CheckoutStepsPageView(
              cart: widget.cart,
              address: _address,
              key: _pageViewKey,
              pageController: widget._pageController,
              selectedShippingIndex: _selectedShippingIndex,
              onShippingSelected: (index) {
                setState(() {
                  _selectedShippingIndex = index;
                });
              },
            ),
          ),
          20.height,
 widget.currentStep < 3 ?
          CustomButton(
            text: 'التالي',
            backgroundColor: AppColors.primary,
            textColor: AppColors.white,
            onPressed: _handleNextWithValidation,
          )
          : CustomButton(
            text: 'ادفع عبر PayPal',
            backgroundColor: AppColors.primary,
            textColor: AppColors.white,
            onPressed: _handleNextWithValidation,
          ),
          20.height,
        ],
      ),
    );
  }
}
