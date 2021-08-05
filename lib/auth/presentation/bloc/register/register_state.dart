part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  @override
  final List<dynamic> props;

  const RegisterState([this.props = const <dynamic>[]]);
}

class RegisterInitial extends RegisterState {}

class InvalidCredientalsState extends RegisterState {
  final String? emailFailure;
  final String? passwordFailure;
  final String? passwordRepeatFailure;

  InvalidCredientalsState(
      this.emailFailure, this.passwordFailure, this.passwordRepeatFailure)
      : super([emailFailure, passwordFailure, passwordRepeatFailure]);
}

class RegisteringState extends RegisterState {}

class ErrorState extends RegisterState {
  final String errorMsg;

  ErrorState(this.errorMsg) : super([errorMsg]);
}

class RegisteredState extends RegisterState {}
