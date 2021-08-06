import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/core/error/failures.dart';

class UserCredientalsEntity extends Equatable {
  final String email;
  final String? password;
  final String? passwordRepeat;

  const UserCredientalsEntity({
    required this.email,
    this.password,
    this.passwordRepeat,
  });

  @override
  List<Object?> get props => [email, password];

  Either<CredientalsValidationFailure, bool> validate() {
    String? emailFailure;
    String? passwordFailure;
    String? passwordRepeatFailure;
    if (!RegExp(emailRegEx).hasMatch(email)) {
      emailFailure = invalidEmailMsg;
    }
    if (passwordRepeat != null && passwordRepeat != password) {
      passwordRepeatFailure = didntMatchPswdMsg;
    }
    if (password != null && (password ?? "").length < 6) {
      passwordFailure = weakPswdMsg;
    }
    if (emailFailure == null &&
        passwordFailure == null &&
        passwordRepeatFailure == null) {
      return const Right(true);
    }
    return Left(CredientalsValidationFailure(
        emailFailure, passwordFailure, passwordRepeatFailure));
  }
}

const emailRegEx =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const invalidEmailMsg = "Enter valid email";
const didntMatchPswdMsg = "Passwords didn't match";
const weakPswdMsg = "Password is weak";
