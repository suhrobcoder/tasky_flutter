part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  @override
  final List<dynamic> props;

  const SigninEvent([this.props = const <dynamic>[]]);
}

class EmailChanged extends SigninEvent {
  final String email;

  EmailChanged(this.email) : super([email]);
}

class PasswordChanged extends SigninEvent {
  final String password;

  PasswordChanged(this.password) : super([password]);
}

class EmailPasswordSignInEvent extends SigninEvent {}

class GoogleSignInEvent extends SigninEvent {}
