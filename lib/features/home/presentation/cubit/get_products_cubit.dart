import 'package:bloc/bloc.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';
import 'package:fruits_hub/features/home/domain/repo/get_products_repo.dart';

part 'get_products_cubit_state.dart';

class GetProductsCubit extends Cubit<GetProductsCubitState> {
  GetProductsCubit({required this.getProductsRepo})
    : super(GetProductsCubitInitial());

  final GetProductsRepo getProductsRepo;

  Future<void> getProducts() async {
    emit(GetProductsCubitLoading());
    final result = await getProductsRepo.getProducts();
    result.fold(
      (failure) => emit(GetProductsCubitFailure(errorMessage: failure.message)),
      (products) => emit(GetProductsCubitSuccess(products: products)),
    );
  }

  Future<void> getBestSellingProducts() async {
    emit(GetProductsCubitLoading());
    final result = await getProductsRepo.getProductsBestSelling();
    result.fold(
      (failure) => emit(GetProductsCubitFailure(errorMessage: failure.message)),
      (products) => emit(GetProductsCubitSuccess(products: products)),
    );
  }
}
