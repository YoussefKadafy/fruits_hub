import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/features/add_product/presentation/widgets/add_product_body.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('إضافة منتج جديد', style: AppStyles.wight700Size19),
        ),
        body: const AddProductBody(),
      ),
    );
  }
}
