import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/core/error/failures.dart';

class UserCredientalsEntity extends Equatable {
  final String email;
  final String password;
  final String passwordRepeat;

  const UserCredientalsEntity({
    required this.email,
    required this.password,
    required this.passwordRepeat,
  });

  @override
  List<Object?> get props => [email, password];

  Either<CredientalsValidationFailure, bool> validate() {
    String? emailFailure;
    String? passwordFailure;
    if (!RegExp(emailRegEx).hasMatch(email)) {
      emailFailure = invalidEmailMsg;
    }
    if (password != passwordRepeat) {
      passwordFailure = didntMatchPswdMsg;
    }
    if (password.length < 6) {
      passwordFailure = weakPswdMsg;
    }
    if (emailFailure == null && passwordFailure == null) {
      return const Right(true);
    }
    return Left(CredientalsValidationFailure(emailFailure, passwordFailure));
  }
}

const emailRegEx =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const invalidEmailMsg = "Enter valid email";
const didntMatchPswdMsg = "Passwords didn't match";
const weakPswdMsg = "Password is weak";
