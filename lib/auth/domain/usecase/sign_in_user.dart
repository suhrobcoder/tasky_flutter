import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky/auth/domain/entity/user_credientals_entity.dart';
import 'package:tasky/auth/domain/entity/user_entity.dart';
import 'package:tasky/auth/domain/repository/auth_repository.dart';
import 'package:tasky/core/error/failures.dart';

@injectable
class SignInUser {
  final AuthRepository authRepository;

  SignInUser(this.authRepository);

  Future<Either<Failure, UserEntity>> execute({
    required String email,
    required String password,
  }) async {
    var userCredientals =
        UserCredientalsEntity(email: email, password: password);
    var validate = userCredientals.validate();
    return validate.fold<Future<Either<Failure, UserEntity>>>(
      (l) => Future.value(Left(l)),
      (r) async =>
          (await authRepository.signInUser(email: email, password: password))
              .fold((l) => Left(l), (r) => Right(r)),
    );
  }
}
