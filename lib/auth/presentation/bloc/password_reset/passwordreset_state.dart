part of 'passwordreset_bloc.dart';

abstract class PasswordResetState extends Equatable {
  @override
  final List<dynamic> props;

  const PasswordResetState([this.props = const <dynamic>[]]);
}

class PasswordresetInitial extends PasswordResetState {}

class InvalidCredientalsState extends PasswordResetState {
  final String? emailFailure;

  InvalidCredientalsState(this.emailFailure) : super([emailFailure]);
}

class SendingRequest extends PasswordResetState {}

class RequestSent extends PasswordResetState {}

class ErrorState extends PasswordResetState {
  final String errorMsg;

  ErrorState(this.errorMsg) : super([errorMsg]);
}
