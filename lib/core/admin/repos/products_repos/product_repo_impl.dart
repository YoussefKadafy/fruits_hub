import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/admin/repos/products_repos/products_repo.dart';
import 'package:fruits_hub/core/admin/services/admin_fire_store_service.dart';
import 'package:fruits_hub/core/errors/failure.dart';
import 'package:fruits_hub/core/helpers/backend_endpoints.dart';
import 'package:fruits_hub/features/add_product/data/models/add_product_model.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';

class ProductImpl implements ProductsRepo {
  final AdminFireStoreService adminFireStoreService;

  ProductImpl({required this.adminFireStoreService});
  @override
  Future<Either<Failure, void>> addProduct({
    required AddProductEntity addProductEntity,
  }) async {
    try {
      final result = await adminFireStoreService.addData(
        path: BackendEndpoints.addProductsCollection,
        data: AddProductModel.fromEntity(addProductEntity).toJson(),
      );

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
