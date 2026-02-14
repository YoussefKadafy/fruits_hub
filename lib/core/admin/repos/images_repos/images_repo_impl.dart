import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/admin/repos/images_repos/image_repo.dart';
import 'package:fruits_hub/core/admin/services/storage_service.dart';
import 'package:fruits_hub/core/errors/failure.dart';
import 'package:fruits_hub/core/helpers/backend_endpoints.dart';

class ImagesRepoImpl implements ImageRepo {
  final StorageService storageService;

  ImagesRepoImpl({required this.storageService});
  @override
  Future<Either<Failure, String>> uploadImage({required File imageFile}) async {
    try {
      final result = await storageService.uploadImage(
        path: BackendEndpoints.imagesFolder,
        imageFile: imageFile,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
