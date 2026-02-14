import 'dart:io';
import 'package:path/path.dart' as path_util;
import 'package:fruits_hub/core/admin/services/storage_service.dart';
import 'package:fruits_hub/core/errors/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService implements StorageService {
  static late Supabase _supabase;
  static Future<void> initialize() async {
    _supabase = await Supabase.initialize(
      url: 'https://iclrvacvsppgpoiuzzym.supabase.co',
      anonKey: 'sb_publishable_dc4T2awlWyBk1Xl-XGA8UA_Gy93Xdj3',
    );
  }

  @override
  Future<String> uploadImage({
    required String path,
    required File imageFile,
  }) async {
    final fileName = path_util.basename(imageFile.path);
    final fileExtension = path_util.extension(imageFile.path);
    final storagePath = '$path/$fileName$fileExtension';

    try {
      await _supabase.client.storage
          .from('fruits-hub')
          .upload(storagePath, imageFile);

      // Get public URL of the uploaded image
      final publicUrl = _supabase.client.storage
          .from('fruits-hub')
          .getPublicUrl(storagePath);

      return publicUrl;
    } catch (e) {
      throw ServerFailure('Failed to upload image: $e');
    }
  }
}
