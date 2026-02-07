import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_hub/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.userId,
    required super.role,
  });
  factory UserModel.fromFirebase(User user) => UserModel(
    name: user.displayName ?? 'no name',
    email: user.email ?? 'no email',
    userId: user.uid,
    role: 'user', // 👈 placeholder مؤقت
  );

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    name: map['name'] ?? '',
    email: map['email'] ?? '',
    userId: map['userId'] ?? '',
    role: map['role'] ?? 'user', // 👈
  );
}
