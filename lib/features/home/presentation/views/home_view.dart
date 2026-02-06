import 'package:flutter/material.dart';
import 'package:fruits_hub/features/home/presentation/widgets/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(body: HomeBody()),
    );
  }
}
