import 'package:flutter/material.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_text_field.dart';

class LoginTextFieldsSection extends StatefulWidget {
  const LoginTextFieldsSection({
    super.key,
    required this.onSavedPassword,
    required this.onSavedEmail,
  });
  final void Function(String?)? onSavedPassword, onSavedEmail;
  @override
  State<LoginTextFieldsSection> createState() => _LoginTextFieldsSectionState();
}

class _LoginTextFieldsSectionState extends State<LoginTextFieldsSection> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

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

  late final ValueNotifier<bool> isPasswordVisible;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    isPasswordVisible = ValueNotifier<bool>(true);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    isPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          hintText: 'أدخل البريد الإلكتروني',
          labelText: 'البريد الإلكتروني',
          keyboardType: TextInputType.emailAddress,
          validator: _validateEmail,
          onSaved: widget.onSavedEmail,
        ),

        16.height,

        // Password Field
        ValueListenableBuilder<bool>(
          valueListenable: isPasswordVisible,
          builder: (context, obscure, _) {
            return CustomTextField(
              onSaved: widget.onSavedPassword,
              controller: passwordController,
              hintText: 'ادخل كلمة المرور',
              labelText: 'كلمة المرور',
              validator: _validatePassword,
              prefixIcon: GestureDetector(
                onTap: () => isPasswordVisible.value = !obscure,
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
