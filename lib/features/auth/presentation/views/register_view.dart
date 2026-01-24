import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_bar_title.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/register_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: AppBarTitle(title: 'حساب جديد')),
        body: RegisterBody(),
      ),
    );
  }
}
