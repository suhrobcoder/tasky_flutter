import 'package:dartz/dartz.dart';
import 'package:tasky/auth/domain/entity/user_entity.dart';
import 'package:tasky/auth/domain/repository/auth_repository.dart';
import 'package:tasky/core/error/failures.dart';

class GoogleSignInUser {
  final AuthRepository authRepository;

  GoogleSignInUser(this.authRepository);

  Future<Either<Failure, UserEntity>> execute() {
    return authRepository.googleSignIn();
  }
}
