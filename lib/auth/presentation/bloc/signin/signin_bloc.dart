import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/auth/domain/usecase/google_sign_in_user.dart';
import 'package:tasky/auth/domain/usecase/sign_in_user.dart';
import 'package:tasky/auth/domain/usecase/validate_credientals.dart';
import 'package:tasky/core/error/failures.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final ValidateCredientals validateCredientals;
  final SignInUser signInUser;
  final GoogleSignInUser googleSignInUser;
  SigninBloc(this.validateCredientals, this.signInUser, this.googleSignInUser)
      : super(const SigninInitial("", ""));

  @override
  Stream<SigninState> mapEventToState(
    SigninEvent event,
  ) async* {
    if (event is EmailChanged) {
      var result = validateCredientals.execute(
          email: event.email, password: state.password);
      yield result.fold(
        (l) => InvalidCredientalsState(
            event.email, state.password, l.emailMsg, l.passwordMsg),
        (r) => SigninInitial(event.email, state.password),
      );
    } else if (event is PasswordChanged) {
      var result = validateCredientals.execute(
          email: state.email, password: event.password);
      yield result.fold(
        (l) => InvalidCredientalsState(
            state.email, event.password, l.emailMsg, l.passwordMsg),
        (r) => SigninInitial(state.email, event.password),
      );
    } else if (event is EmailPasswordSignInEvent) {
      yield SigningInState(state.email, state.password);
      var result = await signInUser.execute(
          email: state.email, password: state.password);
      print("Bloc: " + state.toString());
      print(state.email + ":" + state.password);
      print(result.toString());
      yield result.fold(
        (l) => state.copyErrorState(l is AuthFailure ? l.message : "Error"),
        (r) => SignedInState(),
      );
    } else if (event is GoogleSignInEvent) {
      yield SigningInState(state.email, state.password);
      var result = await googleSignInUser.execute();
      yield result.fold(
        (l) => state.copyErrorState(l is AuthFailure ? l.message : "Error"),
        (r) => SignedInState(),
      );
    }
  }

  @override
  Stream<Transition<SigninEvent, SigninState>> transformEvents(
      Stream<SigninEvent> events,
      TransitionFunction<SigninEvent, SigninState> transitionFn) {
    events.listen((event) {
      print(event);
    });
    return super.transformEvents(events, transitionFn);
  }
}
