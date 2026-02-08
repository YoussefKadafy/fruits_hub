import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/helpers/service_locator.dart';
import 'package:fruits_hub/core/routing/app_routes.dart';
import 'package:fruits_hub/features/add_product/presentation/views/add_product_view.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/signup/register_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/views/login_view.dart';
import 'package:fruits_hub/features/auth/presentation/views/register_view.dart';
import 'package:fruits_hub/features/home/presentation/views/best_seller_view.dart';
import 'package:fruits_hub/features/main/presentation/views/main_view.dart';
import 'package:fruits_hub/features/onboaeding/presentation/views/onboarding_view.dart';
import 'package:fruits_hub/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:fruits_hub/features/profile/presentation/views/profile_view.dart';
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
          return BlocProvider(
            create: (context) => locator<LoginCubit>(),
            child: const LoginView(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.register,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => locator<RegisterCubit>(),
            child: RegisterView(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        builder: (context, state) {
          return const MainView();
        },
      ),
      GoRoute(
        path: AppRoutes.bestSeller,
        name: AppRoutes.bestSeller,
        builder: (context, state) {
          return const BestSellerView();
        },
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: AppRoutes.profile,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => locator<ProfileCubit>(),
            child: const ProfileView(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.addProduct,
        name: AppRoutes.addProduct,
        builder: (context, state) {
          return const AddProductView();
        },
      ),
    ],
  );
}
