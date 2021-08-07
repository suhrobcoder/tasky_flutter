import 'package:tasky/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tasky/auth/domain/repository/auth_repository.dart';

class SignOut {
  final AuthRepository authRepository;

  SignOut(this.authRepository);

  Future<Either<Failure, bool>> execute() async {
    return await authRepository.signOut();
  }
}