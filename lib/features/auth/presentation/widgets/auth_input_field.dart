import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_pallete.dart';

class AuthInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const AuthInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppPallete.whiteColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppPallete.greyColor.withValues(alpha: 0.7),
        ),
        prefixIcon: Icon(icon, color: AppPallete.gradient2),
        filled: true,
        fillColor: AppPallete.backgroundColor.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppPallete.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppPallete.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppPallete.gradient2, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppPallete.errorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      validator: validator ?? _defaultValidator,
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    if (hintText.toLowerCase().contains('email')) {
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return 'Please enter a valid email';
      }
    }

    if (hintText.toLowerCase().contains('password') &&
        !hintText.toLowerCase().contains('confirm')) {
      if (value.length < 6) {
        return 'Password must be at least 6 characters';
      }
    }

    if (hintText.toLowerCase().contains('name')) {
      if (value.length < 2) {
        return 'Name must be at least 2 characters';
      }
    }

    return null;
  }
}
