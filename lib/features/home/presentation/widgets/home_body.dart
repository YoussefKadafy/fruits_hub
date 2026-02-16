import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/search_text_field.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';
import 'package:fruits_hub/features/home/presentation/cubit/get_products_cubit.dart';
import 'package:fruits_hub/features/home/presentation/widgets/best_seller_headline.dart';
import 'package:fruits_hub/features/home/presentation/widgets/custom_home_app_bar.dart';
import 'package:fruits_hub/features/home/presentation/widgets/featured_items_list.dart';
import 'package:fruits_hub/core/utils/products_grid_list.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

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
                    16.height,
                    CustomHomeAppBar(),
                    24.height,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: SearchTextField(
                        controller: TextEditingController(),
                      ),
                    ),
                    19.height,
                    FeaturedItemsList(),
                    12.height,
                    BestSellerHeadline(),
                    8.height,
                  ],
                ),
              ),
              if (isLoading)
                SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                ProductsGridList(products: products),
            ],
          ),
        );
      },
    );
  }
}
