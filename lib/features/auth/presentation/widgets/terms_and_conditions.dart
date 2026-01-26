import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_check_box.dart';

class TermsAndConditionsSection extends StatelessWidget {
  const TermsAndConditionsSection({super.key, required this.isChecked});

  final ValueNotifier<bool> isChecked;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ValueListenableBuilder<bool>(
            valueListenable: isChecked,
            builder: (context, value, _) {
              return CustomCheckbox(
                value: value,
                onChanged: (value) {
                  isChecked.value = value;
                },
              );
            },
          ),
        ),
        8.width,
        SizedBox(
          width: 287.w,
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontFamily: 'Cairo'),
              children: [
                TextSpan(
                  text: 'من خلال إنشاء حساب، توافق على ',
                  style: AppStyles.wight600Size13.copyWith(
                    color: AppColors.grayScale,
                  ),
                ),
                TextSpan(
                  text: 'الشروط والأحكام الخاصة بالتطبيق',
                  style: AppStyles.wight600Size13.copyWith(
                    color: AppColors.mintGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
