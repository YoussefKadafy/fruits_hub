import 'package:fruits_hub/core/routing/app_routes.dart';
import 'package:fruits_hub/features/auth/presentation/views/login_view.dart';
import 'package:fruits_hub/features/onboaeding/presentation/views/onboarding_view.dart';
import 'package:fruits_hub/features/splash/presentation/view/splash_view.dart';
import 'package:go_router/go_router.dart';

class RoutesConfig {
  static final routes = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splash,
        builder: (context, state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: AppRoutes.onboarding,
        builder: (context, state) {
          return const OnboardingView();
        },
      ),
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.login,
        builder: (context, state) {
          return const LoginView();
        },
      ),
    ],
  );
}
