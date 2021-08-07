import 'package:dartz/dartz.dart';
import 'package:tasky/core/error/failures.dart';
import 'package:tasky/auth/domain/repository/auth_repository.dart';

class CheckAuthenticated {
  final AuthRepository authRepository;

  CheckAuthenticated(this.authRepository);

  Either<Failure, bool> execute() {
    return authRepository.checkUserAuthenticated();
  }
}