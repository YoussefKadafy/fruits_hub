import 'package:flutter/material.dart';
import 'package:fruits_hub/core/helpers/shared_prefs.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/address_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/checkout_entity.dart';
import 'package:fruits_hub/features/checkout/presentation/cubits/orders_cubit/orders_cubit.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/add_orders_bloc_builder.dart';
import 'package:fruits_hub/features/checkout/presentation/widgets/checkout_body.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key, required this.cartItems});
  final CartEntity cartItems;
  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late PageController _pageController;
  int _currentStep = 1;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<String> stepsData() {
    return ['الشحن', 'العنوان', 'المراجعة'];
  }

  void _handleBack() {
    if (_currentStep > 1) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  void _handleNext() {
       if (_currentStep == 3) {
      final entity = CheckoutEntity(
        cartItems: widget.cartItems,
        uId: SharedPrefs.getUserEntity()!.userId,
        address: _address,
        isPayCash: _isPayCash,
      );

      context.read<OrdersCubit>().addOrder(
        checkoutEntity: entity,
      );
      return;
    }

    // ✅ OTHERWISE → GO NEXT
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    setState(() {
      _currentStep++;
    });
  }

  AddressEntity? _address;
  bool? _isPayCash;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stepsData()[_currentStep - 1]),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _handleBack,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Provider.value(
            value: CheckoutEntity(
              cartItems: widget.cartItems,
              uId: SharedPrefs.getUserEntity()!.userId,
              address: _address,
              isPayCash: _isPayCash,
            ),
            child: AddOrdersBlocBuilder(
              child: CheckoutBody(
                cart: widget.cartItems,
                pageController: _pageController,
                currentStep: _currentStep,
                onNextPressed: _handleNext,
                onStepTapped: (step) {
                  step <= _currentStep
                      ? setState(() {
                          _currentStep = step;
                          _pageController.animateToPage(
                            step - 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        })
                      : null;
                },
                address: _address,
                isPayCash: _isPayCash,
                onAddressChange: (AddressEntity? value) {
                  setState(() {
                    _address = value;
                  });
                },
                onPayCashChange: (value) {
                  setState(() {
                    _isPayCash = value;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
