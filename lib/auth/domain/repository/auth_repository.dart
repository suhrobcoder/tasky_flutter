import 'package:dartz/dartz.dart';
import 'package:tasky/core/error/failures.dart';
import 'package:tasky/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Either<Failure, bool> checkUserAuthenticated();
  Future<Either<Failure, UserEntity>> registerUser({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> signInUser({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> googleSignIn();
  Future<Either<Failure, bool>> signOut();
  Future<bool> isFirstTIme();
}
