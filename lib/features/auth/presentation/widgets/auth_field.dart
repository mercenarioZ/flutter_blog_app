import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? extraValidator;

  const AuthField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.extraValidator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      controller: controller,

      // The validator is used to validate the input field
      // If the validator is not provided, a default one is used
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'It\'s a bit empty here, please fill it in';
        }

        if (extraValidator != null) {
          return extraValidator!(value);
        }

        return null;
      },
      obscureText: obscureText,
    );
  }
}
