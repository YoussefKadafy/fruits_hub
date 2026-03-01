import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_button.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/checkout_steps.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/checkout_steps_page_view.dart';

class CheckoutBody extends StatefulWidget {
  const CheckoutBody({super.key});

  @override
  State<CheckoutBody> createState() => _CheckoutBodyState();
}

class _CheckoutBodyState extends State<CheckoutBody> {
  late PageController _pageController;
  int? _selectedShippingIndex;

  @override
  void initState() {
    _pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          20.height,
          const CheckoutSteps(isChecked: true),
          32.height,
          Expanded(
            child: CheckoutStepsPageView(
              pageController: _pageController,
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
            onPressed: () {},
          ),
          20.height,
        ],
      ),
    );
  }
}
