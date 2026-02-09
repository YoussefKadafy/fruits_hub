import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fruits_hub/core/helpers/shared_prefs.dart';
import 'package:fruits_hub/features/auth/domain/entity/user_entity.dart';
import 'package:fruits_hub/features/auth/domain/usecases/listen_to_user_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ListenToUserUseCase listenToUserUseCase;
  Stream<UserEntity>? _userStream;
  StreamSubscription<UserEntity>? _userSubscription;

  AuthCubit({required this.listenToUserUseCase}) : super(AuthInitial());

  void startListeningToUser(String userId) {
    emit(AuthLoading());

    // Get initial user data from local storage
    final cachedUser = SharedPrefs.getUserEntity();
    if (cachedUser != null) {
      emit(AuthAuthenticated(cachedUser));
    }

    // Cancel previous stream subscription if it exists
    stopListeningToUser();

    _userStream = listenToUserUseCase.call(userId: userId);

    _userSubscription = _userStream!.listen(
      (userEntity) {
        emit(AuthAuthenticated(userEntity));
      },
      onError: (error) {
        emit(AuthError('Failed to listen to user updates: $error'));
      },
    );
  }

  void stopListeningToUser() {
    _userSubscription?.cancel();
    _userSubscription = null;
    _userStream = null;
  }

  @override
  Future<void> close() {
    stopListeningToUser();
    return super.close();
  }
}
