part of 'signin_bloc.dart';

abstract class SigninState extends Equatable {
  final String email;
  final String password;

  const SigninState({this.email = "", this.password = ""});

  @override
  List<Object?> get props => [email, password];

  ErrorState copyErrorState(String errorMsg) {
    return ErrorState(email, password, errorMsg);
  }
}

class SigninInitial extends SigninState {
  const SigninInitial(String email, String password)
      : super(email: email, password: password);
}

class InvalidCredientalsState extends SigninState {
  final String? emailFailure;
  final String? passwordFailure;

  const InvalidCredientalsState(
      String email, String password, this.emailFailure, this.passwordFailure)
      : super(email: email, password: password);

  @override
  List<Object?> get props => super.props + [emailFailure, passwordFailure];
}

class SigningInState extends SigninState {
  const SigningInState(String email, String password)
      : super(email: email, password: password);
}

class SignedInState extends SigninState {}

class ErrorState extends SigninState {
  final String errorMsg;

  const ErrorState(String email, String password, this.errorMsg)
      : super(email: email, password: password);

  @override
  List<Object?> get props => super.props + [errorMsg];
}
