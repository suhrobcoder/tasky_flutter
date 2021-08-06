import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/auth/domain/usecase/password_reset.dart';
import 'package:tasky/auth/domain/usecase/validate_credientals.dart';
import 'package:tasky/core/error/failures.dart';

part 'passwordreset_event.dart';
part 'passwordreset_state.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  final ValidateCredientals validateCredientals;
  final PasswordReset passwordReset;
  PasswordResetBloc(this.validateCredientals, this.passwordReset)
      : super(PasswordresetInitial());

  String email = "";

  @override
  Stream<PasswordResetState> mapEventToState(
    PasswordResetEvent event,
  ) async* {
    if (event is EmailChanged) {
      email = event.email;
      var result = validateCredientals.execute(email: email);
      yield result.fold(
        (l) => InvalidCredientalsState(l.emailMsg),
        (r) => PasswordresetInitial(),
      );
    } else if (event is SendRequest) {
      yield SendingRequest();
      var result = await passwordReset.execute(email);
      yield result.fold(
        (l) => ErrorState(l is AuthFailure ? l.message : "Error"),
        (r) => RequestSent(),
      );
    }
  }
}
