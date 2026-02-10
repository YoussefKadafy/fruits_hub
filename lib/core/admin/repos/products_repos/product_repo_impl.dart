import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/admin/repos/products_repos/products_repo.dart';
import 'package:fruits_hub/core/errors/failure.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';

class ProductImpl implements ProductsRepo {
  @override
  Future<Either<Failure, void>> addProduct({
    required AddProductEntity addProductEntity,
  }) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }
}
