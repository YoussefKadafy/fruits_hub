import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_button.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/checkout_steps.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/checkout_steps_page_view.dart';

class CheckoutBody extends StatefulWidget {
  const CheckoutBody({
    super.key,
    required PageController pageController,
    this.currentStep = 1,
    this.onNextPressed,
  }) : _pageController = pageController;

  final PageController _pageController;
  final int currentStep;
  final VoidCallback? onNextPressed;

  @override
  State<CheckoutBody> createState() => _CheckoutBodyState();
}

class _CheckoutBodyState extends State<CheckoutBody> {
  int? _selectedShippingIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          20.height,
          CheckoutStepsVerification(currentStep: widget.currentStep),
          32.height,
          Expanded(
            child: CheckoutStepsPageView(
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
          CustomButton(
            text: 'التالي',
            backgroundColor: AppColors.primary,
            textColor: AppColors.white,
            onPressed: widget.onNextPressed,
          ),
          20.height,
        ],
      ),
    );
  }
}
