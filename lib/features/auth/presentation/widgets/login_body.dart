import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_button.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/login_text_fields_section.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/social_buttons_section.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'البريد الإلكتروني غير صحيح';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            24.height,

            LoginTextFieldsSection(
              emailController: _emailController,
              passwordController: _passwordController,
              emailValidator: _validateEmail,
              passwordValidator: _validatePassword,
            ),

            16.height,

            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  // Navigate to forgot password screen
                },
                child: Text(
                  'نسيت كلمة المرور؟',
                  style: AppStyles.wight600Size16.copyWith(
                    color: AppColors.mintGreen,
                  ),
                ),
              ),
            ),

            33.height,

            CustomButton(
              onPressed: () {},
              text: 'تسجيل الدخول',
              backgroundColor: AppColors.primary,
              textColor: Colors.white,
            ),

            37.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "لا تمتلك حساب؟ ",
                  style: AppStyles.wight600Size16.copyWith(
                    color: AppColors.grayScale,
                  ),
                ),
                Text(
                  ' قم بإنشاء حساب',
                  style: AppStyles.wight600Size16.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            33.height,
            // Or Divider
            Row(
              children: [
                const Expanded(child: Divider(color: Color(0xffDDDFDF))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('أو', style: AppStyles.wight600Size16),
                ),
                const Expanded(child: Divider(color: Color(0xffDDDFDF))),
              ],
            ),

            16.height,

            // Social Login Buttons
            SocialButtonsSection(),

            24.height,
          ],
        ),
      ),
    );
  }
}
