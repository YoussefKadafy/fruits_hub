import 'package:flutter/material.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_Item_entity.dart';
import 'package:fruits_hub/features/cart/presentation/widgets/cart_item.dart';

class ProductsInCartListView extends StatelessWidget {
  const ProductsInCartListView({
    super.key,
    required this.cartItems,
    required this.totalPrice,
  });
  final List<CartItemEntity> cartItems;
  final num totalPrice;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return CartItem(cartItem: item, totalPrice: totalPrice);
        },
      ),
    );
  }
}
