import 'dart:io';
import 'package:path/path.dart' as path_util;
import 'package:fruits_hub/core/admin/services/storage_service.dart';
import 'package:fruits_hub/core/errors/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService implements StorageService {
  static const String _supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String _supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
  );
  static late Supabase _supabase;
  static Future<void> initialize() async {
    _supabase = await Supabase.initialize(
      url: _supabaseUrl.isNotEmpty
          ? _supabaseUrl
          : 'https://iclrvacvsppgpoiuzzym.supabase.co',
      anonKey: _supabaseAnonKey.isNotEmpty ? _supabaseAnonKey : '',
    );
  }

  @override
  Future<String> uploadImage({
    required String path,
    required File imageFile,
  }) async {
    final fileName = path_util.basename(imageFile.path);
    final storagePath = '$path/$fileName';

    try {
      await Supabase.instance.client.storage
          .from('fruits-hub')
          .upload(storagePath, imageFile);

      final publicUrl = Supabase.instance.client.storage
          .from('fruits-hub')
          .getPublicUrl(storagePath);

      return publicUrl;
    } catch (e) {
      throw ServerFailure('Failed to upload image: $e');
    }
  }
}
