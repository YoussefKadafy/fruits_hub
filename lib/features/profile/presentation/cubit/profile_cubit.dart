import 'package:bloc/bloc.dart';
import 'package:fruits_hub/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.signOutUseCase) : super(ProfileInitial());
  final SignOutUseCase signOutUseCase;

  Future<void> signOut() async {
    emit(ProfileLoading());
    final result = await signOutUseCase();
    result.fold(
      (l) => emit(ProfileError(message: l.message)),
      (r) => emit(ProfileSignOutSuccess()),
    );
  }
}
