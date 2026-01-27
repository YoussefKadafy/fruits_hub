import 'package:bloc/bloc.dart';
import 'package:fruits_hub/features/auth/domain/entity/user_entity.dart';
import 'package:fruits_hub/features/auth/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepo) : super(RegisterInitial());
  final AuthRepo authRepo;

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(RegisterLoading());
    final result = await authRepo.createUserWithEmailPassword(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (l) => emit(RegisterError(l.message)),
      (r) => emit(RegisterSuccess(r)),
    );
  }
}
