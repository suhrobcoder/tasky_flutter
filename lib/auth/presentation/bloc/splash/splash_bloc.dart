import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/auth/domain/usecase/check_authenticated.dart';
import 'package:tasky/auth/domain/usecase/is_first_time.dart';
import 'package:tasky/core/error/failures.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final IsFirstTime isFirstTime;
  final CheckAuthenticated checkAuthenticated;
  SplashBloc({
    required this.isFirstTime,
    required this.checkAuthenticated,
  }) : super(Initial());

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is CheckEvent) {
      var isFirstRun = await isFirstTime.execute();
      if (isFirstRun) {
        yield ShowOnboarding();
      } else {
        var isAuthenTicated = checkAuthenticated.execute();
        yield isAuthenTicated.fold<SplashState>(
          (l) => Error(defaultErrorMsg),
          (r) => r ? GoHome() : GoLogin(),
        );
      }
    }
  }
}
