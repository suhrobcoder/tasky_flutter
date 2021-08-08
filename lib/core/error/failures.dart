import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final List<dynamic> properties;
  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => properties;
}

class AuthFailure extends Failure {
  final String message;

  AuthFailure({this.message = defaultErrorMsg}) : super([message]);
}

class CredientalsValidationFailure extends Failure {
  final String? emailMsg;
  final String? passwordMsg;
  final String? passwordRepeatMsg;

  CredientalsValidationFailure(
      this.emailMsg, this.passwordMsg, this.passwordRepeatMsg)
      : super([emailMsg, passwordMsg, passwordRepeatMsg]);
}

class DatabaseFailure extends Failure {
  final String message;

  DatabaseFailure(this.message) : super([message]);
}

const defaultErrorMsg = "Something went wrong";
