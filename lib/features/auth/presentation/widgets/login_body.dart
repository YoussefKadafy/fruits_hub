import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/routing/app_routes.dart';
import 'package:fruits_hub/core/utils/custom_button.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/divider_or.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/do_not_have_account.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/forget_password.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/login_text_fields_section.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/social_buttons_section.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  String? email, password;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.pushReplacementNamed(AppRoutes.home);
        }
        if (state is LoginError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginLoading,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  24.height,

                  LoginTextFieldsSection(
                    onSavedEmail: (value) {
                      email = value;
                    },
                    onSavedPassword: (value) {
                      password = value;
                    },
                  ),

                  16.height,

                  ForgetPassword(),

                  33.height,

                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context.read<LoginCubit>().loginUser(
                          email: email!,
                          password: password!,
                        );
                      } else {
                        setState(() {
                          autovalidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                    text: 'تسجيل الدخول',
                    backgroundColor: AppColors.primary,
                    textColor: Colors.white,
                  ),

                  37.height,
                  DoNotHaveAccountYet(),
                  33.height,
                  // Or Divider
                  OrDivider(),

                  16.height,

                  // Social Login Buttons
                  SocialButtonsSection(),

                  24.height,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
