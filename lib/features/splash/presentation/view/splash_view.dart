import 'package:flutter/material.dart';
import 'package:fruits_hub/core/routing/app_routes.dart';
import 'package:fruits_hub/features/splash/presentation/widgets/splash_body.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(bottom: true, top: false, child: SplashBody()),
    );
  }

  void navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.pushReplacementNamed(AppRoutes.onboarding);
      }
    });
  }
}
