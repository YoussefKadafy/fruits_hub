import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/helpers/service_locator.dart';
import 'package:fruits_hub/core/utils/notification_circle.dart';
import 'package:fruits_hub/features/home/domain/repo/get_products_repo.dart';
import 'package:fruits_hub/features/home/presentation/cubit/get_products_cubit.dart';
import 'package:fruits_hub/features/products/presentation/widgets/products_body.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              splashColor: AppColors.green50,
              onPressed: () {},
              icon: NotificationCircle(),
            ),
          ],
          title: Text('المنتجات', style: AppStyles.wight700Size19),
        ),
        body: BlocProvider(
          create: (context) =>
              GetProductsCubit(getProductsRepo: locator<GetProductsRepo>())
                ..getProducts(),
          child: ProductsBody(),
        ),
      ),
    );
  }
}
