import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        style: TextButton.styleFrom(overlayColor: AppColors.lightPrimary),
        onPressed: () {
          // Navigate to forgot password screen
        },
        child: Text(
          'نسيت كلمة المرور؟',
          style: AppStyles.wight600Size16.copyWith(color: AppColors.mintGreen),
        ),
      ),
    );
  }
}
