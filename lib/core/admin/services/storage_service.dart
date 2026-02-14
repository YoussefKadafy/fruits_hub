import 'dart:io';

abstract class StorageService {
  Future<String> uploadImage({required String path, required File imageFile});
}
