import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruits_hub/core/services/data_base_service.dart';

class AdminFireStoreService implements DataBaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    if (documentId != null) {
      await firestore.collection(path).doc(documentId).set(data);
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future<dynamic> getData({
    required String path,
    String? id,
    Map<String, dynamic>? query,
  }) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<bool> isUserExist({required String path, required String id}) {
    // TODO: implement isUserExist
    throw UnimplementedError();
  }

  @override
  Stream<Map<String, dynamic>> listenToData({
    required String path,
    required String id,
  }) {
    // TODO: implement listenToData
    throw UnimplementedError();
  }
}
