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
  Future<dynamic> getData({
    required String path,
    String? id,
    Map<String, dynamic>? query,
  }) async {
    if (id != null) {
      final doc = await firestore.collection(path).doc(id).get();
      return doc.data() ?? {};
    } else {
      if (query != null) {
        Query<Map<String, dynamic>> collectionQuery = firestore.collection(
          path,
        );

        if (query['orderBy'] != null) {
          collectionQuery = collectionQuery.orderBy(
            query['orderBy'],
            descending: query['descending'] ?? false,
          );
        }

        if (query['limit'] != null) {
          collectionQuery = collectionQuery.limit(query['limit']);
        }

        final snapshot = await collectionQuery.get();
        return snapshot.docs.map((doc) => doc.data()).toList();
      } else {
        final snapshot = await firestore.collection(path).get();
        return snapshot.docs.map((doc) => doc.data()).toList();
      }
    }
  }

  @override
  Future<bool> isUserExist({required String path, required String id}) async {
    final user = await firestore.collection(path).doc(id).get();
    return user.exists;
  }

  @override
  Stream<Map<String, dynamic>> listenToData({
    required String path,
    String? id,
  }) {
    return firestore.collection(path).doc(id).snapshots().map((
      documentSnapshot,
    ) {
      return documentSnapshot.data() as Map<String, dynamic>;
    });
  }
}
