import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_Item_entity.dart';
import 'package:fruits_hub/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fruits_hub/features/home/presentation/widgets/fruite_item.dart';

class ProductsGridList extends StatelessWidget {
  final List<ProductEntity> products;
  final bool isLoading;

  const ProductsGridList({
    super.key,
    required this.products,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 163 / 214,
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: isLoading ? 6 : products.length,
        itemBuilder: (context, index) {
          if (isLoading) {
            return const FruitItem(enabled: true);
          }
          return FruitItem(
            product: products[index],
            enabled: false,
            onTap: () {
              context.read<CartCubit>().addToCart(
                theCartItem: CartItemEntity(product: products[index]),
              );
            },
          );
        },
      ),
    );
  }
}
