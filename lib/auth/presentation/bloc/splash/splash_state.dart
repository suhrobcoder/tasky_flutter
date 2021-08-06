part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  @override
  final List<dynamic> props;

  const SplashState([this.props = const <dynamic>[]]);
}

class Initial extends SplashState {}

class ShowOnboarding extends SplashState {}

class GoLogin extends SplashState {}

class GoHome extends SplashState {}

class Error extends SplashState {
  final String message;

  Error(this.message) : super([message]);
}
