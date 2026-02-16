abstract class DataBaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });
  Future<dynamic> getData({
    required String path,
    String? id,
    Map<String, dynamic>? query,
  });
  Future<bool> isUserExist({required String path, required String id});
  Stream<Map<String, dynamic>> listenToData({
    required String path,
    required String id,
  });
}
