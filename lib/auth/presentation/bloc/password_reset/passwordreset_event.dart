part of 'passwordreset_bloc.dart';

abstract class PasswordResetEvent extends Equatable {
  @override
  final List<dynamic> props;

  const PasswordResetEvent([this.props = const <dynamic>[]]);
}

class EmailChanged extends PasswordResetEvent {
  final String email;

  EmailChanged(this.email) : super([email]);
}

class SendRequest extends PasswordResetEvent {}
