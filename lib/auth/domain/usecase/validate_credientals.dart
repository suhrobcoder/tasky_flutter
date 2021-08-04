import 'package:dartz/dartz.dart';
import 'package:tasky/auth/domain/entity/user_credientals_entity.dart';
import 'package:tasky/core/error/failures.dart';

class ValidateCredientals {
  Either<CredientalsValidationFailure, bool> execute({
    required String email,
    required String password,
    String? passwordRepeat,
  }) {
    var entity = UserCredientalsEntity(
        email: email, password: password, passwordRepeat: passwordRepeat);
    return entity.validate();
  }
}
