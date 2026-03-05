import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_button.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_item_entity.dart';
import 'package:fruits_hub/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/checkout_steps_verification.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/checkout_steps_page_view.dart';

class CheckoutBody extends StatefulWidget {
  const CheckoutBody({
    super.key,
    required PageController pageController,
    this.currentStep = 1,
    this.onNextPressed,
    this.onStepTapped,
  }) : _pageController = pageController;

  final PageController _pageController;
  final int currentStep;
  final VoidCallback? onNextPressed;
  final void Function(int)? onStepTapped;

  @override
  State<CheckoutBody> createState() => _CheckoutBodyState();
}

class _CheckoutBodyState extends State<CheckoutBody> {
  int? _selectedShippingIndex;
  final GlobalKey<dynamic> _pageViewKey = GlobalKey();
  
  // Address fields
  String? _fullName;
  String? _address;
  String? _city;
  String? _neighborhood;
  String? _apartment;
  String? _phone;

  List<CartItemEntity> get _cartItems {
    try {
      final cartCubit = context.read<CartCubit>();
      return cartCubit.cart.items;
    } catch (e) {
      return [];
    }
  }

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
              key: _pageViewKey,
              pageController: widget._pageController,
              selectedShippingIndex: _selectedShippingIndex,
              onShippingSelected: (index) {
                setState(() {
                  _selectedShippingIndex = index;
                });
              },
              cartItems: _cartItems,
              fullName: _fullName,
              address: _address,
              city: _city,
              neighborhood: _neighborhood,
              apartment: _apartment,
              phone: _phone,
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
