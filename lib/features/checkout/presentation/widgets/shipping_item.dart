import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';

class ShippingItem extends StatelessWidget {
  const ShippingItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.payingCount,
    this.isSelected = false,
    this.onTap,
  });

  final String title, subtitle, payingCount;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(

decoration: BoxDecoration(      color: AppColors.grayScale50,
border: Border.all(
  color: isSelected ? AppColors.lightPrimary : Colors.transparent,
),
),      height: 81.h,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 18,
                  width: 18,padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.white : AppColors.grayScale,
                    ),
                    color: isSelected ? AppColors.white : Colors.transparent,
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                         
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightPrimary,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
              10.width,
              Column( crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: AppStyles.wight600Size13),
                  Text(
              subtitle,
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
               '$payingCount جنيه',
              style: AppStyles.wight600Size13.copyWith(
                color: AppColors.lightPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
