import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/routing/app_routes.dart';
import 'package:go_router/go_router.dart';

class HaveAnAccount extends StatelessWidget {
  const HaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontFamily: 'Cairo'),
        children: [
          TextSpan(
            text: 'تمتلك حساب بالفعل؟',
            style: AppStyles.wight600Size16.copyWith(
              color: AppColors.grayScale,
            ),
          ),
          TextSpan(
            text: ' تسجيل الدخول',
            style: AppStyles.wight600Size16.copyWith(color: AppColors.primary),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushReplacementNamed(AppRoutes.login);
              },
          ),
        ],
      ),
    );
  }
}
