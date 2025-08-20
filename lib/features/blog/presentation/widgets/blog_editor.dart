import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const BlogEditor({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),

      // Allows for multi-line input,
      maxLines: null,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText cannot be empty';
        }

        return null; // No validation error
      },
    );
  }
}
