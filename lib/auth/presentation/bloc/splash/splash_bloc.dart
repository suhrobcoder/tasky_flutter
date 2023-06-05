import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky/auth/domain/usecase/check_authenticated.dart';
import 'package:tasky/auth/domain/usecase/is_first_time.dart';
import 'package:tasky/core/error/failures.dart';

part 'splash_event.dart';
part 'splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final IsFirstTime isFirstTime;
  final CheckAuthenticated checkAuthenticated;
  SplashBloc({
    required this.isFirstTime,
    required this.checkAuthenticated,
  }) : super(Initial()) {
    on<CheckEvent>((event, emit) async {
      var isFirstRun = await isFirstTime.execute();
      if (isFirstRun) {
        emit(ShowOnboarding());
      } else {
        var isAuthenTicated = checkAuthenticated.execute();
        emit(isAuthenTicated.fold<SplashState>(
          (l) => Error(defaultErrorMsg),
          (r) => r ? GoHome() : GoLogin(),
        ));
      }
    });
  }
}
