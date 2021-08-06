import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/auth/presentation/bloc/splash/splash_bloc.dart';
import 'package:tasky/core/routes/routes.dart';
import 'package:tasky/service_locator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SplashBloc>()..add(CheckEvent()),
      child: Scaffold(
        body: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is ShowOnboarding) {
              Navigator.popAndPushNamed(context, onboardingPage);
            } else if (state is GoLogin) {
              Navigator.popAndPushNamed(context, signInPage);
            } else if (state is GoHome) {
              Navigator.popAndPushNamed(context, homePage);
            } else if (state is Error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Center(
            child: Image.asset("assets/images/ic_launcher.png",
                width: 72, height: 72),
          ),
        ),
      ),
    );
  }
}
