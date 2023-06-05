import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky/auth/domain/usecase/google_sign_in_user.dart';
import 'package:tasky/auth/domain/usecase/sign_in_user.dart';
import 'package:tasky/auth/domain/usecase/validate_credientals.dart';
import 'package:tasky/core/error/failures.dart';

part 'signin_event.dart';
part 'signin_state.dart';

@injectable
class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final ValidateCredientals validateCredientals;
  final SignInUser signInUser;
  final GoogleSignInUser googleSignInUser;
  SigninBloc(this.validateCredientals, this.signInUser, this.googleSignInUser)
      : super(const SigninInitial("", "")) {
    on<EmailChanged>((event, emit) {
      var result = validateCredientals.execute(
          email: event.email, password: state.password);
      emit(result.fold(
        (l) => InvalidCredientalsState(
            event.email, state.password, l.emailMsg, l.passwordMsg),
        (r) => SigninInitial(event.email, state.password),
      ));
    });
    on<PasswordChanged>((event, emit) {
      var result = validateCredientals.execute(
          email: state.email, password: event.password);
      emit(result.fold(
        (l) => InvalidCredientalsState(
            state.email, event.password, l.emailMsg, l.passwordMsg),
        (r) => SigninInitial(state.email, event.password),
      ));
    });
    on<EmailPasswordSignInEvent>((event, emit) async {
      emit(SigningInState(state.email, state.password));
      var result = await signInUser.execute(
          email: state.email, password: state.password);
      emit(result.fold(
        (l) => state.copyErrorState(l is AuthFailure ? l.message : "Error"),
        (r) => SignedInState(),
      ));
    });
    on<GoogleSignInEvent>((event, emit) async {
      emit(SigningInState(state.email, state.password));
      var result = await googleSignInUser.execute();
      emit(result.fold(
        (l) => state.copyErrorState(l is AuthFailure ? l.message : "Error"),
        (r) => SignedInState(),
      ));
    });
  }
}
