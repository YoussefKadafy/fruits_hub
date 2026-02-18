import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';

class NumberOfProductsInCart extends StatelessWidget {
  const NumberOfProductsInCart({super.key, required this.numberOfProducts});
  final int numberOfProducts;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      color: AppColors.green50,
      child: Center(
        child: Text(
          'لديك $numberOfProducts منتجات في سلة التسوق',
          style: AppStyles.wight400Size13.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
