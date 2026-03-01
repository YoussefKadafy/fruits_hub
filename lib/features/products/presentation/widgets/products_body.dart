import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/app_styles/app_assets.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/headline_and_action.dart';
import 'package:fruits_hub/core/utils/search_text_field.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';
import 'package:fruits_hub/features/home/presentation/cubit/get_products_cubit.dart';
import 'package:fruits_hub/core/utils/products_grid_list.dart';
import 'package:svg_flutter/svg.dart';

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
                    SearchTextField(controller: TextEditingController()),
                    16.height,
                    HeadlineAndAction(
                      headline: 'منتجاتنا',
                      action: SvgPicture.asset(AppAssets.assetsIconsFilter2),
                      onTap: () {},
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
