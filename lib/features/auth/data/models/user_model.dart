import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_hub/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.name, required super.email, required super.userId});
  factory UserModel.fromFirebase(User user) => UserModel(
    name: user.displayName ?? 'no name',
    email: user.email ?? 'no email',
    userId: user.uid,
  );
}
