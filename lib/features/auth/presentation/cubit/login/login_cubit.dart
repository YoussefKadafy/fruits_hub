import 'package:bloc/bloc.dart';
import 'package:fruits_hub/features/auth/domain/entity/user_entity.dart';
import 'package:fruits_hub/features/auth/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());
  final AuthRepo authRepo;
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final result = await authRepo.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (l) => emit(LoginError(message: l.message)),
      (r) => emit(LoginSuccess(r)),
    );
  }
}
