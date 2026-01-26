import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_button.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/signup/signup_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/have_an_account.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/register_text_fields_section.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/terms_and_conditions.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool showTermsError = false;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    isChecked = ValueNotifier(false);
    isChecked.addListener(() {
      if (isChecked.value && showTermsError) {
        setState(() {
          showTermsError = false;
        });
      }
    });
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
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {}
        if (state is SignupError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignupLoading,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  children: [
                    24.height,
                    RegisterTextFieldsSection(
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    16.height,
                    TermsAndConditionsSection(
                      isChecked: isChecked,
                      isError: showTermsError,
                    ),
                    30.height,
                    CustomButton(
                      text: 'إنشاء حساب جديد',
                      backgroundColor: AppColors.primary,
                      textColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (isChecked.value == true) {
                            autovalidateMode = AutovalidateMode.disabled;
                            showTermsError = false;
                            context.read<SignupCubit>().signupUser(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                            );
                          } else {
                            showTermsError = true;
                          }
                        } else {
                          autovalidateMode = AutovalidateMode.always;
                        }
                      },
                    ),
                    26.height,
                    HaveAnAccount(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
