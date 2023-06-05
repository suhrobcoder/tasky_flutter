import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky/auth/domain/usecase/password_reset.dart';
import 'package:tasky/auth/domain/usecase/validate_credientals.dart';
import 'package:tasky/core/error/failures.dart';

part 'passwordreset_event.dart';
part 'passwordreset_state.dart';

@injectable
class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  final ValidateCredientals validateCredientals;
  final PasswordReset passwordReset;

  String email = "";

  PasswordResetBloc(this.validateCredientals, this.passwordReset)
      : super(PasswordresetInitial()) {
    on<EmailChanged>((event, emit) {
      email = event.email;
      var result = validateCredientals.execute(email: email);
      emit(result.fold(
        (l) => InvalidCredientalsState(l.emailMsg),
        (r) => PasswordresetInitial(),
      ));
    });
    on<SendRequest>((event, emit) async {
      emit(SendingRequest());
      var result = await passwordReset.execute(email);
      emit(result.fold(
        (l) => ErrorState(l is AuthFailure ? l.message : "Error"),
        (r) => RequestSent(),
      ));
    });
  }
}
