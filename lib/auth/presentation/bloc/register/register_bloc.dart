import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky/auth/domain/usecase/regiser_user.dart';
import 'package:tasky/auth/domain/usecase/validate_credientals.dart';
import 'package:tasky/core/error/failures.dart';

part 'register_event.dart';
part 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ValidateCredientals validateCredientals;
  final RegisterUser registerUser;

  var name = "";
  var email = "";
  var password = "";
  var passwordRepeat = "";

  RegisterBloc(this.registerUser, this.validateCredientals)
      : super(RegisterInitial()) {
    on<NameChanged>((event, emit) {
      name = "";
    });
    on<EmailChanged>((event, emit) {
      email = event.email;
      var result = validateCredientals.execute(
          email: email, password: password, passwordRepeat: passwordRepeat);
      emit(result.fold(
        (l) => InvalidCredientalsState(
            l.emailMsg, l.passwordMsg, l.passwordRepeatMsg),
        (r) => RegisterInitial(),
      ));
    });
    on<PasswordChanged>((event, emit) {
      password = event.password;
      var result = validateCredientals.execute(
          email: email, password: password, passwordRepeat: passwordRepeat);
      emit(result.fold(
        (l) => InvalidCredientalsState(
            l.emailMsg, l.passwordMsg, l.passwordRepeatMsg),
        (r) => RegisterInitial(),
      ));
    });
    on<PasswordRepeatChanged>((event, emit) {
      passwordRepeat = event.passwordRepeat;
      var result = validateCredientals.execute(
          email: email, password: password, passwordRepeat: passwordRepeat);
      emit(result.fold(
        (l) => InvalidCredientalsState(
            l.emailMsg, l.passwordMsg, l.passwordRepeatMsg),
        (r) => RegisterInitial(),
      ));
    });
    on<SignUpEvent>((event, emit) async {
      emit(RegisteringState());
      var result = await registerUser.execute(
          name: name,
          email: email,
          password: password,
          passwordRepeat: passwordRepeat);
      emit(result.fold(
        (l) => ErrorState(l is AuthFailure ? l.message : "Error"),
        (r) => RegisteredState(),
      ));
    });
  }
}
