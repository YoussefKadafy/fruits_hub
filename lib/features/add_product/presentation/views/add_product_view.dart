import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/helpers/service_locator.dart';
import 'package:fruits_hub/features/add_product/presentation/cubit/add_product_cubit_cubit.dart';
import 'package:fruits_hub/features/add_product/presentation/widgets/add_product_body.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('إضافة منتج جديد', style: AppStyles.wight700Size19),
        ),
        body: BlocProvider(
          create: (context) => locator<AddProductCubit>(),
          child: AddProductBody(),
        ),
      ),
    );
  }
}
