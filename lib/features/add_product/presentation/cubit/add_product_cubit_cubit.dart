import 'package:bloc/bloc.dart';
import 'package:fruits_hub/core/admin/repos/images_repos/image_repo.dart';
import 'package:fruits_hub/core/admin/repos/products_repos/products_repo.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';
import 'package:meta/meta.dart';

part 'add_product_cubit_state.dart';

class AddProductCubit extends Cubit<AddProductCubitState> {
  AddProductCubit({required this.productsRepo, required this.imageRepo})
    : super(AddProductCubitInitial());
  final ProductsRepo productsRepo;
  final ImageRepo imageRepo;

  Future<void> addProduct({required ProductEntity addProductEntity}) async {
    emit(AddProductCubitLoading(loadingMessage: 'جاري رفع الصورة...'));
    final imageResult = await imageRepo.uploadImage(
      imageFile: addProductEntity.image,
    );
    imageResult.fold(
      (failure) => emit(
        AddProductCubitFailure(
          errorMessage: 'فشل في رفع الصورة: ' + failure.toString(),
        ),
      ),
      (imageUrl) async {
        addProductEntity.imageUrl = imageUrl;
        emit(AddProductCubitLoading(loadingMessage: 'جاري حفظ المنتج...'));
        final result = await productsRepo.addProduct(
          addProductEntity: addProductEntity,
        );
        result.fold(
          (failure) => emit(
            AddProductCubitFailure(
              errorMessage: 'فشل في حفظ المنتج: ' + failure.toString(),
            ),
          ),
          (_) => emit(AddProductCubitSuccess()),
        );
      },
    );
  }
}
