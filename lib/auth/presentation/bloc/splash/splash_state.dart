part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState([List<dynamic> props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class Initial extends SplashState {}

class ShowOnboarding extends SplashState {}

class GoLogin extends SplashState {}

class GoHome extends SplashState {}

class Error extends SplashState {
  final String message;

  Error(this.message) : super([message]);
}
