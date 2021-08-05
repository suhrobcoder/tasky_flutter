part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  final List<dynamic> props;

  const RegisterEvent([this.props = const <dynamic>[]]);
}

class NameChanged extends RegisterEvent {
  final String name;

  NameChanged(this.name) : super([name]);
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged(this.email) : super([email]);
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged(this.password) : super([password]);
}

class PasswordRepeatChanged extends RegisterEvent {
  final String passwordRepeat;

  PasswordRepeatChanged(this.passwordRepeat) : super([passwordRepeat]);
}

class SignUpEvent extends RegisterEvent {}
