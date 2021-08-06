import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/auth/presentation/bloc/signin/signin_bloc.dart';
import 'package:tasky/auth/presentation/widgets/input_fields.dart';
import 'package:tasky/core/constants/size.dart';
import 'package:tasky/core/routes/routes.dart';
import 'package:tasky/global_widgets/buttons.dart';
import 'package:tasky/service_locator.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SigninBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocConsumer<SigninBloc, SigninState>(
              listener: (context, state) {
                if (state is SignedInState) {
                  Navigator.popAndPushNamed(context, homePage);
                } else if (state is ErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMsg)),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.chevron_left_rounded),
                          iconSize: 56.0,
                          splashRadius: 36.0,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Column(
                        children: [
                          const SizedBox(height: 48),
                          const Text(
                            "Welcome back to Tasky.",
                            style: TextStyle(fontSize: 26.0),
                          ),
                          const SizedBox(height: 4.0),
                          const Text(
                            "get your day back to plan",
                            style:
                                TextStyle(fontSize: 22, color: Colors.black54),
                          ),
                          const SizedBox(height: 56),
                          EmailInputField(
                            errorText: state is InvalidCredientalsState
                                ? state.emailFailure
                                : null,
                            onChanged: (text) =>
                                BlocProvider.of<SigninBloc>(context)
                                    .add(EmailChanged(text)),
                          ),
                          const SizedBox(height: 16),
                          PasswordInputField(
                            labelText: "Password",
                            errorText: state is InvalidCredientalsState
                                ? state.passwordFailure
                                : null,
                            onChanged: (text) =>
                                BlocProvider.of<SigninBloc>(context)
                                    .add(PasswordChanged(text)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, forgotPasswordPage),
                                  child: const Text("FORGOT")),
                            ],
                          ),
                          const SizedBox(height: 48),
                          PrimaryButton(
                            "Sign in",
                            Theme.of(context).primaryColor,
                            () => BlocProvider.of<SigninBloc>(context)
                                .add(EmailPasswordSignInEvent()),
                            enabled: !(state is InvalidCredientalsState ||
                                state is SigningInState),
                          ),
                          const SizedBox(height: 16),
                          GoogleSignInButton(
                            state is! SigningInState,
                            () => BlocProvider.of<SigninBloc>(context)
                                .add(GoogleSignInEvent()),
                          ),
                          const SizedBox(height: 48),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                                TextSpan(
                                  text: "Sign Up",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.popAndPushNamed(
                                          context, registerPage);
                                    },
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24.0),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  final bool enabled;
  final Function onClick;
  const GoogleSignInButton(this.enabled, this.onClick, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.7,
      height: 64.0,
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? () => onClick() : null,
          borderRadius: BorderRadius.circular(16.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Image.asset("assets/images/google_light.png",
                      width: 24, height: 24),
                ),
                const Center(
                  child: Text(
                    "Sign in with Google",
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
