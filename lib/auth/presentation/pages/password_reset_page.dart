import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/auth/presentation/bloc/password_reset/passwordreset_bloc.dart';
import 'package:tasky/auth/presentation/widgets/input_fields.dart';
import 'package:tasky/core/constants/size.dart';
import 'package:tasky/core/routes/routes.dart';
import 'package:tasky/global_widgets/buttons.dart';
import 'package:tasky/service_locator.dart';

class PasswordResetPage extends StatelessWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PasswordResetBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocConsumer<PasswordResetBloc, PasswordResetState>(
              listener: (context, state) {
                if (state is RequestSent) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "Password Reset instructions sent to your email"),
                    ),
                  );
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
                            "Reset Password",
                            style: TextStyle(fontSize: 26.0),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Please enter your email below to recieve \nyour password reset instructions",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 56),
                          EmailInputField(
                            errorText: state is InvalidCredientalsState
                                ? state.emailFailure
                                : null,
                            onChanged: (text) =>
                                BlocProvider.of<PasswordResetBloc>(context)
                                    .add(EmailChanged(text)),
                          ),
                          const SizedBox(height: 48),
                          PrimaryButton(
                            "Send mail",
                            Theme.of(context).primaryColor,
                            () => BlocProvider.of<PasswordResetBloc>(context)
                                .add(SendRequest()),
                            enabled: !(state is InvalidCredientalsState ||
                                state is SendingRequest),
                          ),
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
