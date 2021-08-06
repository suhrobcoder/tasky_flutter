import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/auth/domain/usecase/regiser_user.dart';
import 'package:tasky/auth/domain/usecase/validate_credientals.dart';
import 'package:tasky/core/error/failures.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ValidateCredientals validateCredientals;
  final RegisterUser registerUser;
  RegisterBloc(this.registerUser, this.validateCredientals)
      : super(RegisterInitial());

  var name = "";
  var email = "";
  var password = "";
  var passwordRepeat = "";

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is NameChanged) {
      name = ""; // TODO
    } else if (event is EmailChanged) {
      email = event.email;
      var result = validateCredientals.execute(
          email: email, password: password, passwordRepeat: passwordRepeat);
      yield result.fold(
        (l) => InvalidCredientalsState(
            l.emailMsg, l.passwordMsg, l.passwordRepeatMsg),
        (r) => RegisterInitial(),
      );
    } else if (event is PasswordChanged) {
      password = event.password;
      var result = validateCredientals.execute(
          email: email, password: password, passwordRepeat: passwordRepeat);
      yield result.fold(
        (l) => InvalidCredientalsState(
            l.emailMsg, l.passwordMsg, l.passwordRepeatMsg),
        (r) => RegisterInitial(),
      );
    } else if (event is PasswordRepeatChanged) {
      passwordRepeat = event.passwordRepeat;
      var result = validateCredientals.execute(
          email: email, password: password, passwordRepeat: passwordRepeat);
      yield result.fold(
        (l) => InvalidCredientalsState(
            l.emailMsg, l.passwordMsg, l.passwordRepeatMsg),
        (r) => RegisterInitial(),
      );
    } else if (event is SignUpEvent) {
      yield RegisteringState();
      var result = await registerUser.execute(
          name: name,
          email: email,
          password: password,
          passwordRepeat: passwordRepeat);
      yield result.fold(
        (l) => ErrorState(l is AuthFailure ? l.message : "Error"),
        (r) => RegisteredState(),
      );
    }
  }
}
