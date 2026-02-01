import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_hub/core/errors/custom_exception.dart';

import 'package:fruits_hub/core/errors/failure.dart';
import 'package:fruits_hub/core/helpers/backend_endpoints.dart';
import 'package:fruits_hub/core/services/data_base_service.dart';
import 'package:fruits_hub/core/services/fire_base_auth_service.dart';
import 'package:fruits_hub/features/auth/data/models/user_model.dart';
import 'package:fruits_hub/features/auth/domain/entity/user_entity.dart';
import 'package:fruits_hub/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  FireBaseAuthService fireBaseAuthService;
  DataBaseService dataBaseService;

  AuthRepoImpl({
    required this.fireBaseAuthService,
    required this.dataBaseService,
  });

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    User? user;
    try {
      user = await fireBaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userEntity = UserModel.fromFirebase(user);

      await addUserData(user: userEntity);

      return Right(userEntity);
    } catch (e) {
      if (user != null) {
        await fireBaseAuthService.deleteUser();
      }

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

  @override
  Future<Either<Failure, UserEntity>> loginWithFacebook() async {
    try {
      final user = await fireBaseAuthService.signInWithFacebook();
      return Right(UserModel.fromFirebase(user));
    } catch (e) {
      log('Unexpected error in repo loginWithFacebook: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<dynamic> addUserData({required UserEntity user}) {
    try {
      return dataBaseService.addData(
        path: BackendEndpoints.usersCollection,
        data: user.toMap(),
      );
    } catch (e) {
      log('Unexpected error in repo addData: $e');
      throw CustomException(e.toString());
    }
  }
}
