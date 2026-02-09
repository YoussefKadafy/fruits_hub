import 'package:fruits_hub/core/services/data_base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService implements DataBaseService {
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
  Future<Map<String, dynamic>> getData({
    required String path,
    required String id,
  }) async {
    final doc = await firestore.collection(path).doc(id).get();
    return doc.data() as Map<String, dynamic>;
  }

  @override
  Future<bool> isUserExist({required String path, required String id}) async {
    final user = await firestore.collection(path).doc(id).get();
    return user.exists;
  }

  @override
  Stream<Map<String, dynamic>> listenToData({
    required String path,
    required String id,
  }) {
    return firestore.collection(path).doc(id).snapshots().map((
      documentSnapshot,
    ) {
      return documentSnapshot.data() as Map<String, dynamic>;
    });
  }
}
