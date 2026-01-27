import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/routing/app_routes.dart';
import 'package:go_router/go_router.dart';

class DoNotHaveAccountYet extends StatelessWidget {
  const DoNotHaveAccountYet({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "لا تمتلك حساب؟ ",
          style: AppStyles.wight600Size16.copyWith(color: AppColors.grayScale),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: () {
            context.pushReplacementNamed(AppRoutes.register);
          },
          child: Text(
            ' قم بإنشاء حساب',
            style: AppStyles.wight600Size16.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
