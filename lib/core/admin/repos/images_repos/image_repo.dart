import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/errors/failure.dart';

abstract class ImageRepo {
  Future<Either<Failure, String>> uploadImage({required File imageFile});
}
