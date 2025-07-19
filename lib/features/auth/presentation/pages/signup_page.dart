import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_pallete.dart';
import 'package:flutter_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter_app/features/auth/presentation/widgets/auth_gradient_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // controller for email input, this can be used to retrieve the email input value
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // controller for email input, this can be used to retrieve the email input value
  final _formKey = GlobalKey<FormState>();

  // dispose the controllers when the widget is removed from the widget tree -> avoid memory leaks
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sign up", style: TextStyle(fontSize: 48)),
              const Text(
                "Create a new account here",
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 30),

              // Form fields can be added here
              const AuthField(hintText: "Name"),
              const SizedBox(height: 15),

              const AuthField(hintText: "Email"),
              const SizedBox(height: 15),

              const AuthField(hintText: "Password"),
              const SizedBox(height: 15),

              const AuthField(hintText: "Confirm your password"),
              const SizedBox(height: 30),

              AuthGradientButton(
                buttonText: "Sign Up",
                onPressed: () {
                  // display a message (example)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Sign Up button pressed!")),
                  );
                },
              ),

              // Sign in link
              const SizedBox(height: 20),

              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: Theme.of(context).textTheme.titleMedium,

                  children: [
                    TextSpan(
                      text: 'Sign in',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppPallete.gradient3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
