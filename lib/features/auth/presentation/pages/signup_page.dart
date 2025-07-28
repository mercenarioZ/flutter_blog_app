import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_pallete.dart';
import 'package:flutter_app/core/utils/snackbar.dart';
import 'package:flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_app/features/auth/presentation/pages/signin_page.dart';
import 'package:flutter_app/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:flutter_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());
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
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            snackBar(context, state.message);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Background gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                    colors: [
                      AppPallete.backgroundColor,
                      Color.fromRGBO(32, 28, 42, 1),
                      Color.fromRGBO(40, 30, 50, 1),
                      Color.fromRGBO(35, 25, 45, 1),
                      Color.fromRGBO(28, 28, 38, 1),
                    ],
                  ),
                ),
              ),

              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      // App Logo/Icon
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              AppPallete.gradient1,
                              AppPallete.gradient2,
                              AppPallete.gradient3,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppPallete.gradient2.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 30,
                              offset: const Offset(5, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person_add_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Welcome text
                      const Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppPallete.whiteColor,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Join our community and start your blogging journey",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppPallete.greyColor.withValues(alpha: 0.8),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Form Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppPallete.borderColor.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppPallete.borderColor,
                            width: 1,
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // Name field
                              AuthInputField(
                                controller: nameController,
                                hintText: "Full Name",
                                icon: Icons.person_outline,
                              ),

                              const SizedBox(height: 20),

                              // Email field
                              AuthInputField(
                                controller: emailController,
                                hintText: "Email Address",
                                icon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                              ),

                              const SizedBox(height: 20),

                              // Password field
                              AuthInputField(
                                controller: passwordController,
                                hintText: "Password",
                                icon: Icons.lock_outline,
                                obscureText: true,
                              ),

                              const SizedBox(height: 20),

                              // Confirm Password field
                              AuthInputField(
                                controller: confirmPasswordController,
                                hintText: "Confirm Password",
                                icon: Icons.lock_outline,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  if (value != passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 30),

                              // Sign up button
                              AuthGradientButton(
                                text: "Create Account",
                                isLoading: state is AuthLoading,
                                onPressed: state is AuthLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<AuthBloc>().add(
                                            AuthSignupEvent(
                                              name: nameController.text.trim(),
                                              email: emailController.text
                                                  .trim(),
                                              password: passwordController.text
                                                  .trim(),
                                              confirmPassword:
                                                  confirmPasswordController.text
                                                      .trim(),
                                            ),
                                          );
                                        }
                                      },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Sign in link
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, LoginPage.route());
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: const TextStyle(
                              color: AppPallete.greyColor,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                  color: AppPallete.gradient3,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
