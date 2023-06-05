import 'package:flutter/material.dart';

class EmailInputField extends StatelessWidget {
  final Function(String) onChanged;
  final String? errorText;
  const EmailInputField({required this.onChanged, this.errorText, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.alternate_email_rounded),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
          errorText: errorText,
          labelText: "Email"),
      onChanged: (text) => onChanged(text),
    );
  }
}

class PasswordInputField extends StatefulWidget {
  final String labelText;
  final Function(String) onChanged;
  final String? errorText;

  const PasswordInputField(
      {required this.labelText,
      required this.onChanged,
      this.errorText,
      Key? key})
      : super(key: key);

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key_rounded),
        suffixIcon: IconButton(
          onPressed: () => setState(() => showPassword = !showPassword),
          icon: Icon(showPassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
        labelText: widget.labelText,
        errorText: widget.errorText,
      ),
      onChanged: (text) => widget.onChanged(text),
      obscureText: !showPassword,
      enableSuggestions: false,
      autocorrect: false,
    );
  }
}
