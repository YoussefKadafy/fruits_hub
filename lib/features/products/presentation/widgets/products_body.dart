import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';
import 'package:fruits_hub/features/home/presentation/cubit/get_products_cubit.dart';
import 'package:fruits_hub/core/utils/products_grid_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsBody extends StatelessWidget {
  const ProductsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsCubit, GetProductsCubitState>(
      builder: (context, state) {
        final List<ProductEntity> products = state is GetProductsCubitSuccess
            ? state.products
            : [];
        final isLoading = state is GetProductsCubitLoading;

        return SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    24.height,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'المنتجات',
                          style: AppStyles.wight700Size16,
                        ),
                      ),
                    ),
                    8.height,
                  ],
                ),
              ),
              ProductsGridList(products: products, isLoading: isLoading),
            ],
          ),
        );
      },
    );
  }
}
