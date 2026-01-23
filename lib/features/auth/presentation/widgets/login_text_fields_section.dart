import 'package:flutter/material.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_text_field.dart';

class LoginTextFieldsSection extends StatefulWidget {
  const LoginTextFieldsSection({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required this.emailValidator,
    required this.passwordValidator,
  }) : _emailController = emailController,
       _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final String? Function(String?) emailValidator, passwordValidator;

  @override
  State<LoginTextFieldsSection> createState() => _LoginTextFieldsSectionState();
}

class _LoginTextFieldsSectionState extends State<LoginTextFieldsSection> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: widget._emailController,
          hintText: 'أدخل البريد الإلكتروني',
          labelText: 'البريد الإلكتروني',
          keyboardType: TextInputType.emailAddress,
          validator: widget.emailValidator,
        ),

        16.height,

        // Password Field
        CustomTextField(
          controller: widget._passwordController,
          hintText: 'أدخل كلمة المرور',
          labelText: 'كلمة المرور',
          obscureText: !_isPasswordVisible,
          validator: widget.passwordValidator,

          prefixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            onPressed: () {
              _isPasswordVisible = !_isPasswordVisible;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
