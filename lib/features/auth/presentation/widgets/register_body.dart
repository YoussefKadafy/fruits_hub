import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/routing/app_routes.dart';
import 'package:fruits_hub/core/utils/custom_button.dart';
import 'package:fruits_hub/core/utils/custom_check_box.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/register_text_fields_section.dart';
import 'package:go_router/go_router.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final ValueNotifier<bool> isChecked;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    isChecked = ValueNotifier(false);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    isChecked.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            24.height,
            RegisterTextFieldsSection(
              nameController: nameController,
              emailController: emailController,
              passwordController: passwordController,
            ),
            16.height,
            Row(
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
            ),
            30.height,
            CustomButton(
              text: 'إنشاء حساب جديد',
              backgroundColor: AppColors.primary,
              textColor: Colors.white,
              onPressed: () {},
            ),
            26.height,
            RichText(
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
                    style: AppStyles.wight600Size16.copyWith(
                      color: AppColors.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.pushReplacementNamed(AppRoutes.login);
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
