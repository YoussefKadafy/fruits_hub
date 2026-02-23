import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';

class ShippingItem extends StatelessWidget {
  const ShippingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grayScale50,
      height: 81.h,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.grayScale),
                ),
              ),
              10.width,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('الدفع عند الاستلام', style: AppStyles.wight600Size13),
                  Text(
                    'التسليم من المكان',
                    style: AppStyles.wight400Size13.copyWith(
                      color: AppColors.grayScale,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '45 جنيه',
              style: AppStyles.wight600Size13.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
