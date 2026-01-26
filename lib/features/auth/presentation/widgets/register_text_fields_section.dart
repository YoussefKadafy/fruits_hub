import 'package:flutter/material.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_text_field.dart';

class RegisterTextFieldsSection extends StatefulWidget {
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
  State<RegisterTextFieldsSection> createState() =>
      _RegisterTextFieldsSectionState();
}

class _RegisterTextFieldsSectionState extends State<RegisterTextFieldsSection> {
  late final TextEditingController confirmPasswordController;
  late final ValueNotifier<bool> isPasswordObscure;
  late final ValueNotifier<bool> isConfirmObscure;

  @override
  void initState() {
    super.initState();
    confirmPasswordController = TextEditingController();
    isPasswordObscure = ValueNotifier<bool>(true);
    isConfirmObscure = ValueNotifier<bool>(true);
  }

  @override
  void dispose() {
    confirmPasswordController.dispose();
    isPasswordObscure.dispose();
    isConfirmObscure.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hintText: 'ادخل الاسم',
          labelText: 'الاسم',
          validator: (value) {
            if (value == null || value.isEmpty) return 'ادخل الاسم';
            if (value.length < 3) return 'الاسم يجب أن يكون 3 أحرف على الأقل';
            return null;
          },
          controller: widget.nameController,
        ),
        16.height,
        CustomTextField(
          controller: widget.emailController,
          hintText: 'ادخل البريد الالكتروني',
          labelText: 'البريد الالكتروني',
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) return 'ادخل البريد الالكتروني';
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value)) {
              return 'البريد الالكتروني غير صحيح';
            }
            return null;
          },
        ),
        16.height,
        ValueListenableBuilder<bool>(
          valueListenable: isPasswordObscure,
          builder: (context, obscure, _) {
            return CustomTextField(
              controller: widget.passwordController,
              hintText: 'ادخل كلمة المرور',
              labelText: 'كلمة المرور',
              validator: (value) {
                if (value == null || value.isEmpty) return 'ادخل كلمة المرور';
                if (value.length < 6) {
                  return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                }
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
        ValueListenableBuilder<bool>(
          valueListenable: isConfirmObscure,
          builder: (context, obscure, _) {
            return CustomTextField(
              controller: confirmPasswordController,
              hintText: 'تاكيد كلمة المرور',
              labelText: 'تاكيد كلمة المرور',
              validator: (value) {
                if (value == null || value.isEmpty) return 'تاكيد كلمة المرور';
                if (value != widget.passwordController.text) {
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
