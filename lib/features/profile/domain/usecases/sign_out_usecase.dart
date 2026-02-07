import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/errors/failure.dart';
import 'package:fruits_hub/features/auth/domain/repo/auth_repo.dart';

class SignOutUseCase {
  final AuthRepo authRepo;

  SignOutUseCase(this.authRepo);

  Future<Either<Failure, void>> call() async {
    return await authRepo.signOut();
  }
}
