
import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';

class RowTextWidget extends StatelessWidget {
  const RowTextWidget({
    super.key, required this.actionText, required this.resultText, this.actionColor, this.resultColor,
  });
  final String actionText, resultText;
  final Color? actionColor, resultColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Text(actionText, style: AppStyles.wight700Size13.copyWith(color: actionColor ?? AppColors.grayScale500),),
      Text(resultText, style: AppStyles.wight700Size13.copyWith(color: resultColor ?? AppColors.grayScale950),),
    ],);
  }
}
