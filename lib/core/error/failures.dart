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

  CredientalsValidationFailure(this.emailMsg, this.passwordMsg)
      : super([emailMsg, passwordMsg]);
}

const defaultErrorMsg = "Something went wrong";
