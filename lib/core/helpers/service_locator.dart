import 'package:fruits_hub/core/admin/repos/products_repos/product_repo_impl.dart';
import 'package:fruits_hub/core/admin/repos/products_repos/products_repo.dart';
import 'package:fruits_hub/core/admin/repos/images_repos/image_repo.dart';
import 'package:fruits_hub/core/admin/repos/images_repos/images_repo_impl.dart';
import 'package:fruits_hub/core/admin/services/fire_storage_service.dart';
import 'package:fruits_hub/core/admin/services/storage_service.dart';
import 'package:fruits_hub/core/admin/services/admin_fire_store_service.dart';
import 'package:fruits_hub/core/admin/services/supabase_service.dart';
import 'package:fruits_hub/core/services/data_base_service.dart';
import 'package:fruits_hub/core/services/fire_store_service.dart';
import 'package:fruits_hub/features/auth/data/repos/auth_repo_impl.dart';
import 'package:fruits_hub/features/auth/domain/repo/auth_repo.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/signup/register_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fruits_hub/features/auth/domain/usecases/listen_to_user_usecase.dart';
import 'package:fruits_hub/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:fruits_hub/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:fruits_hub/features/add_product/presentation/cubit/add_product_cubit_cubit.dart';
import 'package:fruits_hub/features/home/data/repos/get_products_repo_impl.dart';
import 'package:fruits_hub/features/home/domain/repo/get_products_repo.dart';
import 'package:fruits_hub/features/home/presentation/cubit/get_products_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:fruits_hub/core/services/fire_base_auth_service.dart';

final locator = GetIt.instance;

void setupServiceLocator() {
  // Services
  locator.registerLazySingleton<FireBaseAuthService>(
    () => FireBaseAuthService(),
  );
  locator.registerLazySingleton<StorageService>(() => SupabaseService());

  locator.registerLazySingleton<DataBaseService>(() => FireStoreService());
  locator.registerLazySingleton<AdminFireStoreService>(
    () => AdminFireStoreService(),
  );

  // Repositories
  locator.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      fireBaseAuthService: locator<FireBaseAuthService>(),
      dataBaseService: locator<DataBaseService>(),
    ),
  );
  locator.registerLazySingleton<ProductsRepo>(
    () => ProductImpl(adminFireStoreService: locator<AdminFireStoreService>()),
  );
  locator.registerLazySingleton<ImageRepo>(
    () => ImagesRepoImpl(storageService: locator<StorageService>()),
  );
  locator.registerLazySingleton<GetProductsRepo>(
    () => GetProductsRepoImpl(dataBaseService: locator<DataBaseService>()),
  );
  // Add your repositories here

  // Use Cases
  locator.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(locator<AuthRepo>()),
  );
  locator.registerLazySingleton<ListenToUserUseCase>(
    () => ListenToUserUseCase(repo: locator<AuthRepo>()),
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
  locator.registerFactory<AuthCubit>(
    () => AuthCubit(listenToUserUseCase: locator<ListenToUserUseCase>()),
  );
  locator.registerFactory<AddProductCubit>(
    () => AddProductCubit(
      productsRepo: locator<ProductsRepo>(),
      imageRepo: locator<ImageRepo>(),
    ),
  );
  locator.registerLazySingleton<GetProductsCubit>(
    () => GetProductsCubit(getProductsRepo: locator<GetProductsRepo>()),
  );
  // Add your BLoCs here
}
