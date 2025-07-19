import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;

  const AuthField({super.key, required this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter something here';
        }

        return null;
      },
    );
  }
}
