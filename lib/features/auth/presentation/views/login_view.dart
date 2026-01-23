import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_bar_title.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/login_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: AppBarTitle(title: 'تسجيل الدخول')),
        body: LoginBody(),
      ),
    );
  }
}
