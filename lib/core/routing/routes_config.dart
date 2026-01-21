import 'package:fruits_hub/core/routing/app_routes.dart';
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
    ],
  );
}
