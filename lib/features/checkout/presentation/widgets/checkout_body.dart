import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/helpers/app_keys.dart';
import 'package:fruits_hub/core/utils/custom_button.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/address_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/checkout_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/paypal_payment_entity/paypal_payment_entity.dart';
import 'package:fruits_hub/features/checkout/presentation/cubits/orders_cubit/orders_cubit.dart';
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
    this.address,
    required this.isPayCash,
    required this.onAddressChange,
    required this.onPayCashChange,
  }) : _pageController = pageController;
  final AddressEntity? address;
  final bool? isPayCash;
  final ValueChanged<bool> onPayCashChange;
  final ValueChanged<AddressEntity?> onAddressChange;
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
  final GlobalKey<CheckoutStepsPageViewState> _pageViewKey = GlobalKey();

  bool _validateCurrentStep() {
    final currentStep = widget.currentStep;
    final pageView = _pageViewKey.currentState;

    // Step 1: Shipping
    if (currentStep == 1) {
      if (_selectedShippingIndex == null) {
        return false;
      }
    }
    // Step 2: Address
    if (currentStep == 2) {
      if (pageView == null) return false;
      return pageView.validateAddressStep();
    }
    // Step 3: Review (always valid as it's the final step)
    if (currentStep == 3) {
      return true;
    }
    return true;
  }

  void _handleNextWithValidation() {
    // Save data when moving from step to step
    final pageView = _pageViewKey.currentState;

    // Step 1: Save shipping selection (isPayCash)
    if (widget.currentStep == 1) {
      widget.onPayCashChange(_selectedShippingIndex == 0);
    }

    if (widget.currentStep == 2 && pageView != null) {
      widget.onAddressChange(pageView.getAddress());
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
            child: CheckoutStepsPageView(onAddressChanged: widget.onAddressChange,
              onStepTapped: widget.onStepTapped,
              cart: widget.cart,
              address:  widget.address,
              isPayCash:  widget.isPayCash,
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
widget.currentStep < 3
    ? CustomButton(
        text: 'التالي',
        backgroundColor: AppColors.primary,
        textColor: AppColors.white,
        onPressed: _handleNextWithValidation,
      )
    : (widget.isPayCash == true)
        ? CustomButton(
            text: 'تم التاكيد',
            backgroundColor: AppColors.primary,
            textColor: AppColors.white,
            onPressed: _handleNextWithValidation,
          )
        : CustomButton(
            text: 'ادفع عبر PayPal',
            backgroundColor: AppColors.primary,
            textColor: AppColors.white,
            onPressed: () => _processPayPalPayment(context),
          ),
          20.height,
        ],
      ),
    );
  }
  void _processPayPalPayment(BuildContext context ) {

  final orderEntity= context.read<CheckoutEntity>();
  final paypal= PayPalPaymentEntity.fromEntity( orderEntity);
 final orderCubit= context.read<OrdersCubit>();
  

    Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PaypalCheckoutView(
                    sandboxMode: true,
                    clientId: AppKeys.kPayPalClientId,
                    secretKey: AppKeys.kPayPalSecretKey,
                    transactions:  [
                   paypal.toJson()
                    ],
                    note: "Contact us for any questions on your order.",
                 onSuccess: (Map params) async {
  Navigator.pop(context); // اقفل PayPal أولاً
  if (!context.mounted) return;
   orderCubit.addOrder(checkoutEntity: orderEntity);
   ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('تم الدفع بنجاح')),
  );
  // هنا تكمّل منطق حفظ الـ order في Supabase
  // context.read<YourCubit>().placeOrder(params);
  
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('تم الدفع بنجاح')),
  );
},
                    onError: (error) {
                      log("onError: $error");
                        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('حدث خطأ أثناء الدفع: $error' )));
                     log( "onError: $error");
                     log( "onError: ${error is Exception ? (error).toString() : error.toString()}");
                      Navigator.pop(context);
                    },
                    onCancel: () {
                      log('cancelled:');
                    },
                  ),
                ));
  }
  
}
