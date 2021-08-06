import 'package:dartz/dartz.dart';
import 'package:tasky/auth/domain/repository/auth_repository.dart';
import 'package:tasky/core/error/failures.dart';

class PasswordReset {
  final AuthRepository authRepository;

  PasswordReset(this.authRepository);

  Future<Either<Failure, bool>> execute(String email) async {
    return await authRepository.passwordReset(email);
  }
}
