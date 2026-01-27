import 'package:fruits_hub/features/auth/data/repos/auth_repo_impl.dart';
import 'package:fruits_hub/features/auth/domain/repo/auth_repo.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/signup/register_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:fruits_hub/core/services/fire_base_auth_service.dart';

final locator = GetIt.instance;

void setupServiceLocator() {
  // Services
  locator.registerSingleton<FireBaseAuthService>(FireBaseAuthService());

  // Repositories
  locator.registerSingleton<AuthRepo>(
    AuthRepoImpl(fireBaseAuthService: locator<FireBaseAuthService>()),
  );
  // Add your repositories here

  // Use Cases
  // Add your use cases here

  // BLoCs
  locator.registerSingleton<RegisterCubit>(RegisterCubit(locator<AuthRepo>()));
  locator.registerSingleton<LoginCubit>(LoginCubit(locator<AuthRepo>()));
  // Add your BLoCs here
}
