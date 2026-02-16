import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/helpers/service_locator.dart';
import 'package:fruits_hub/features/home/domain/repo/get_products_repo.dart';
import 'package:fruits_hub/features/home/presentation/cubit/get_products_cubit.dart';
import 'package:fruits_hub/features/home/presentation/widgets/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GetProductsCubit(getProductsRepo: locator<GetProductsRepo>())
            ..getBestSellingProducts(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: const Scaffold(body: HomeBody()),
      ),
    );
  }
}
