import 'package:flutter/material.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';
import 'package:fruits_hub/features/home/presentation/widgets/fruite_item.dart';

class ProductsGridList extends StatelessWidget {
  final List<ProductEntity> products;

  const ProductsGridList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 163 / 214,
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: products.isEmpty ? 6 : products.length,
        itemBuilder: (context, index) {
          if (products.isEmpty) {
            return FruitItem();
          }
          return FruitItem(product: products[index]);
        },
      ),
    );
  }
}
