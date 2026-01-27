// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:fruits_hub/core/errors/failure.dart';
import 'package:fruits_hub/core/services/fire_base_auth_service.dart';
import 'package:fruits_hub/features/auth/data/models/user_model.dart';
import 'package:fruits_hub/features/auth/domain/entity/user_entity.dart';
import 'package:fruits_hub/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  FireBaseAuthService fireBaseAuthService;
  AuthRepoImpl({required this.fireBaseAuthService});

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await fireBaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Right(UserModel.fromFirebase(user));
    } catch (e) {
      log('Unexpected error in createUserWithEmailAndPassword: $e');

      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await fireBaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(UserModel.fromFirebase(user));
    } catch (e) {
      log('Unexpected error in repo loginWithEmailAndPassword: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() async {
    try {
      final user = await fireBaseAuthService.signInWithGoogle();
      return Right(UserModel.fromFirebase(user));
    } catch (e) {
      log('Unexpected error in repo loginWithGoogle: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
