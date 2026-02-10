import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/errors/failure.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';

abstract class ProductsRepo {
  Future<Either<Failure, void>> addProduct({
    required AddProductEntity addProductEntity,
  });
}
