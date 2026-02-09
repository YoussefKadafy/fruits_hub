import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fruits_hub/core/errors/failure.dart';
import 'package:fruits_hub/core/helpers/backend_endpoints.dart';
import 'package:fruits_hub/core/helpers/shared_prefs.dart';
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
  Stream<UserEntity> listenToUser({required String userId}) {
    return dataBaseService
        .listenToData(path: BackendEndpoints.usersCollection, id: userId)
        .map((userData) {
          final userEntity = UserEntity.fromMap(userData);
          // Cache user data in SharedPreferences for offline fallback
          SharedPrefs.saveUserData(userEntity);
          return userEntity;
        })
        .handleError((error) {
          // Fallback to SharedPreferences if Firestore stream fails
          final cachedUserEntity = SharedPrefs.getUserEntity();
          if (cachedUserEntity != null) {
            return cachedUserEntity;
          }
          throw error;
        });
  }

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
      final userEntity = UserEntity(
        role: 'user',
        name: name,
        email: user.email!,
        userId: user.uid,
      );
      await addUserData(user: userEntity);
      final savedUserEntity = await getUserData(userId: user.uid);
      await SharedPrefs.saveUserData(savedUserEntity);

      return Right(savedUserEntity);
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
      final userEntity = await getUserData(userId: user.uid);
      await SharedPrefs.saveUserData(userEntity);

      return Right(userEntity);
    } catch (e) {
      log('Unexpected error in repo loginWithEmailAndPassword: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() async {
    try {
      final user = await fireBaseAuthService.signInWithGoogle();
      final userEntity = UserModel.fromFirebase(user);
      final isUserExist = await dataBaseService.isUserExist(
        path: BackendEndpoints.usersCollection,
        id: user.uid,
      );
      UserEntity entity;
      if (isUserExist) {
        entity = await getUserData(userId: user.uid);
      } else {
        await addUserData(user: userEntity);
        entity = await getUserData(userId: user.uid);
      }
      await SharedPrefs.saveUserData(entity);
      return Right(entity);
    } catch (e) {
      log('Unexpected error in repo loginWithGoogle: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithFacebook() async {
    try {
      final user = await fireBaseAuthService.signInWithFacebook();
      final userEntity = UserModel.fromFirebase(user);
      await SharedPrefs.saveUserData(userEntity);
      return Right(userEntity);
    } catch (e) {
      log('Unexpected error in repo loginWithFacebook: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<dynamic> addUserData({required UserEntity user}) async {
    return await dataBaseService.addData(
      path: BackendEndpoints.usersCollection,
      data: user.toMap(),
      documentId: user.userId,
    );
  }

  @override
  Future<UserEntity> getUserData({required String userId}) async {
    final userData = await dataBaseService.getData(
      path: BackendEndpoints.usersCollection,
      id: userId,
    );

    return UserEntity.fromMap(userData);
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await fireBaseAuthService.signOut();
      return const Right(null);
    } catch (e) {
      log('Unexpected error in repo signOut: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
