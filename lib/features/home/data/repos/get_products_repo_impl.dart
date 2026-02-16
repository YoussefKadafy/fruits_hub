import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruits_hub/core/errors/failure.dart';
import 'package:fruits_hub/core/helpers/backend_endpoints.dart';
import 'package:fruits_hub/core/services/data_base_service.dart';
import 'package:fruits_hub/features/add_product/data/models/add_product_model.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';
import 'package:fruits_hub/features/home/domain/repo/get_products_repo.dart';

class GetProductsRepoImpl implements GetProductsRepo {
  final DataBaseService dataBaseService;

  GetProductsRepoImpl({required this.dataBaseService});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final productsData = await dataBaseService.getData(
        path: BackendEndpoints.productsCollection,
      );

      // Handle null or empty data
      if (productsData == null ||
          (productsData is List && productsData.isEmpty)) {
        return const Right([]);
      }

      // Ensure it's a list
      if (productsData is! List) {
        return const Left(ServerFailure('Invalid data format received'));
      }

      List<ProductModel> products = productsData
          .map((data) => ProductModel.fromJson(Map<String, dynamic>.from(data)))
          .toList();
      List<ProductEntity> productEntities = products
          .map((model) => model.toEntity())
          .toList();

      return Right(productEntities);
    } on FirebaseException catch (e) {
      debugPrint('FirebaseException in getProducts: ${e.code} - ${e.message}');
      return Left(ServerFailure('Database error: ${e.message}'));
    } catch (e) {
      debugPrint('Unexpected error in getProducts: $e');
      return Left(ServerFailure('Failed to fetch products: $e'));
    }
  }
}
