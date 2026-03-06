import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/routing/app_routes.dart';
import 'package:fruits_hub/core/utils/custom_button.dart';
import 'package:fruits_hub/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fruits_hub/features/cart/presentation/widgets/number_of_products_in_cart.dart';
import 'package:fruits_hub/features/cart/presentation/widgets/products_in_cart_list_view.dart';
import 'package:go_router/go_router.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {
    num totalPrce = context.watch<CartCubit>().totalPrice;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        16.height,
        NumberOfProductsInCart(
          numberOfProducts: context.watch<CartCubit>().cart.items.length,
        ),
        24.height,

        ProductsInCartListView(
          cartItems: context.watch<CartCubit>().cart.items,
          totalPrice: totalPrce,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: CustomButton(
            text: 'الدفع $totalPrce جنيه',
            backgroundColor: AppColors.primary,
            textColor: AppColors.white,
            onPressed: () {if(context.read<CartCubit>().cart.items.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(        backgroundColor: Colors.red,

                  content: Text('السلة فارغة'),
                ),
              );
            }else{
              context.pushNamed(AppRoutes.payment ,extra: context.read<CartCubit>().cart );
            }},
          ),
        ),
        40.height,
      ],
    );
  }
}
