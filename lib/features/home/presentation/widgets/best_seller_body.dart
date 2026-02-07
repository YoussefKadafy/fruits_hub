import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/products_grid_list.dart';

class BestSellerBody extends StatelessWidget {
  const BestSellerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              24.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('الأكثر مبيعاً', style: AppStyles.wight700Size16),
                ),
              ),
              8.height,
            ],
          ),
        ),
        ProductsGridList(),
      ],
    );
  }
}
