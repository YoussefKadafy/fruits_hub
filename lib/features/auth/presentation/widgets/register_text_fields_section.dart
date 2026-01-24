import 'package:flutter/material.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_text_field.dart';

class RegisterTextFieldsSection extends StatelessWidget {
  const RegisterTextFieldsSection({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController nameController,
      emailController,
      passwordController;

  @override
  Widget build(BuildContext context) {
    // ValueNotifier لإظهار/إخفاء الباسورد
    final ValueNotifier<bool> isPasswordObscure = ValueNotifier<bool>(true);
    final ValueNotifier<bool> isConfirmObscure = ValueNotifier<bool>(true);

    return Column(
      children: [
        CustomTextField(
          hintText: 'ادخل الاسم',
          labelText: 'الاسم',
          validator: (value) {
            if (value!.isEmpty) return 'ادخل الاسم';
            return null;
          },
          controller: nameController,
        ),
        16.height,
        CustomTextField(
          controller: emailController,
          hintText: 'ادخل البريد الالكتروني',
          labelText: 'البريد الالكتروني',
          validator: (value) {
            if (value!.isEmpty) return 'ادخل البريد الالكتروني';
            return null;
          },
        ),
        16.height,
        // Password Field
        ValueListenableBuilder<bool>(
          valueListenable: isPasswordObscure,
          builder: (context, obscure, _) {
            return CustomTextField(
              controller: passwordController,
              hintText: 'ادخل كلمة المرور',
              labelText: 'كلمة المرور',
              validator: (value) {
                if (value!.isEmpty) return 'ادخل كلمة المرور';
                return null;
              },
              prefixIcon: GestureDetector(
                onTap: () => isPasswordObscure.value = !obscure,
                child: Icon(obscure ? Icons.visibility_off : Icons.visibility),
              ),
              obscureText: obscure,
            );
          },
        ),
        16.height,
        // Confirm Password Field
        ValueListenableBuilder<bool>(
          valueListenable: isConfirmObscure,
          builder: (context, obscure, _) {
            return CustomTextField(
              controller: TextEditingController(), // استخدم controller مناسب
              hintText: 'تاكيد كلمة المرور',
              labelText: 'تاكيد كلمة المرور',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'تاكيد كلمة المرور';
                } else if (value != passwordController.text) {
                  return 'كلمة المرور غير متطابقة';
                }
                return null;
              },
              prefixIcon: GestureDetector(
                onTap: () => isConfirmObscure.value = !obscure,
                child: Icon(obscure ? Icons.visibility_off : Icons.visibility),
              ),
              obscureText: obscure,
            );
          },
        ),
      ],
    );
  }
}
