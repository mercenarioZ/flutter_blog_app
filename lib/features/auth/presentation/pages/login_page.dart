import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_pallete.dart';
import 'package:flutter_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter_app/features/auth/presentation/widgets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controller for email input, this can be used to retrieve the email input value
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // controller for email input, this can be used to retrieve the email input value
  final _formKey = GlobalKey<FormState>();

  // dispose the controllers when the widget is removed from the widget tree -> avoid memory leaks
  @override
  void dispose() {
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
              const Text("Log in", style: TextStyle(fontSize: 48)),
              const Text(
                "Welcome back, please log in",
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 30),

              // Form fields can be added here
              AuthField(hintText: "Email", controller: emailController),
              const SizedBox(height: 15),

              AuthField(
                hintText: "Password",
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 30),

              // Gradient Login button
              AuthGradientButton(
                buttonText: "Sign in",
                onPressed: () {
                  // display a message (example)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Sign in button pressed!")),
                  );
                },
              ),

              // Sign in link
              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  // navigate to sign up
                  Navigator.push(context, SignUpPage.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,

                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppPallete.gradient3,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
