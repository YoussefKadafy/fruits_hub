import 'package:fruits_hub/core/services/data_base_service.dart';
import 'package:fruits_hub/core/services/fire_store_service.dart';
import 'package:fruits_hub/features/auth/data/repos/auth_repo_impl.dart';
import 'package:fruits_hub/features/auth/domain/repo/auth_repo.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/signup/register_cubit.dart';
import 'package:fruits_hub/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:fruits_hub/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:fruits_hub/core/services/fire_base_auth_service.dart';

final locator = GetIt.instance;

void setupServiceLocator() {
  // Services
  locator.registerLazySingleton<FireBaseAuthService>(
    () => FireBaseAuthService(),
  );
  locator.registerLazySingleton<DataBaseService>(() => FireStoreService());
  // Repositories
  locator.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      fireBaseAuthService: locator<FireBaseAuthService>(),
      dataBaseService: locator<DataBaseService>(),
    ),
  );
  // Add your repositories here

  // Use Cases
  locator.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(locator<AuthRepo>()),
  );
  // Add your use cases here

  // BLoCs
  locator.registerFactory<RegisterCubit>(
    () => RegisterCubit(locator<AuthRepo>()),
  );
  locator.registerFactory<LoginCubit>(() => LoginCubit(locator<AuthRepo>()));
  locator.registerFactory<ProfileCubit>(
    () => ProfileCubit(locator<SignOutUseCase>()),
  );
  // Add your BLoCs here
}
