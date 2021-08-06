import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/auth/presentation/bloc/register/register_bloc.dart';
import 'package:tasky/auth/presentation/widgets/input_fields.dart';
import 'package:tasky/core/constants/size.dart';
import 'package:tasky/core/routes/routes.dart';
import 'package:tasky/global_widgets/buttons.dart';
import 'package:tasky/service_locator.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisteredState) {
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
                            "Create Account",
                            style: TextStyle(fontSize: 26.0),
                          ),
                          const SizedBox(height: 56),
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(Icons.person_outline_rounded),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                labelText: "Name"),
                            onChanged: (text) =>
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(NameChanged(text)),
                            autovalidateMode: AutovalidateMode.always,
                            validator: (text) {
                              if (text?.isEmpty == true) {
                                return "Enter your name";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          EmailInputField(
                            errorText: state is InvalidCredientalsState
                                ? state.emailFailure
                                : null,
                            onChanged: (text) =>
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(EmailChanged(text)),
                          ),
                          const SizedBox(height: 16),
                          PasswordInputField(
                            labelText: "Password",
                            errorText: state is InvalidCredientalsState
                                ? state.passwordFailure
                                : null,
                            onChanged: (text) =>
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(PasswordChanged(text)),
                          ),
                          const SizedBox(height: 16),
                          PasswordInputField(
                            labelText: "Confirm Password",
                            errorText: state is InvalidCredientalsState
                                ? state.passwordRepeatFailure
                                : null,
                            onChanged: (text) =>
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(PasswordRepeatChanged(text)),
                          ),
                          const SizedBox(height: 48),
                          PrimaryButton(
                            "Sign Up",
                            Theme.of(context).primaryColor,
                            () => BlocProvider.of<RegisterBloc>(context)
                                .add(SignUpEvent()),
                            enabled: !(state is InvalidCredientalsState ||
                                state is RegisteringState),
                          ),
                          const SizedBox(height: 48),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Already have an account? ",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                                TextSpan(
                                  text: "Sign In",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.popAndPushNamed(
                                          context, signInPage);
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
