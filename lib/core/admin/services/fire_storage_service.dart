import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fruits_hub/core/admin/services/storage_service.dart';
import 'package:fruits_hub/core/errors/failure.dart';
import 'package:path/path.dart' as path_util;

class FireStorageService implements StorageService {
  final storage = FirebaseStorage.instance;

  @override
  Future<String> uploadImage({
    required String path,
    required File imageFile,
  }) async {
    final ref = storage.ref();
    final fileName = path_util.basename(imageFile.path);
    final fileExtension = path_util.extension(imageFile.path);
    final storagePath = '$path/$fileName$fileExtension';
    final fileRef = ref.child(storagePath);
    try {
      await fileRef.putFile(imageFile);
      final downloadUrl = await fileRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw ServerFailure('Failed to upload image: $e');
    }
  }
}
