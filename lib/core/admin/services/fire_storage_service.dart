import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fruits_hub/core/admin/services/storage_service.dart';
import 'package:fruits_hub/core/errors/failure.dart';

class FireStorageService implements StorageService {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Future<String> uploadImage({
    required String path,
    required File imageFile,
  }) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = _storage.ref().child('$path/$fileName');

      await storageRef.putFile(imageFile);

      final downloadUrl = await storageRef.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw ServerFailure('Failed to upload image: $e');
    }
  }
}
