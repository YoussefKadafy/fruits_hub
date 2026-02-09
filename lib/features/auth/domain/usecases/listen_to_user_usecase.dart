import 'package:fruits_hub/features/auth/domain/entity/user_entity.dart';
import 'package:fruits_hub/features/auth/domain/repo/auth_repo.dart';

class ListenToUserUseCase {
  final AuthRepo repo;

  ListenToUserUseCase({required this.repo});

  Stream<UserEntity> call({required String userId}) {
    return repo.listenToUser(userId: userId);
  }
}
