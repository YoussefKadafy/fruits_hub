import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';

class UncheckedStep extends StatelessWidget {
  const UncheckedStep({
    super.key,
    required this.title,
    required this.stepNumber,
  });
  final String title;
  final int stepNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 23,
          height: 23,
          decoration: BoxDecoration(
            color: AppColors.grayScale50,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(stepNumber.toString(), style: AppStyles.wight600Size13),
          ),
        ),
        4.width,
        Text(
          title,
          style: AppStyles.wight700Size13.copyWith(color: AppColors.grayScale),
        ),
      ],
    );
  }
}
