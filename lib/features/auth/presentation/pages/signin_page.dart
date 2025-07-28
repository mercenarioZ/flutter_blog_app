import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_pallete.dart';
import 'package:flutter_app/core/utils/snackbar.dart';
import 'package:flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter_app/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:flutter_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  // controller for email input, this can be used to retrieve the email input value
  final formKey = GlobalKey<FormState>();

  // dispose the controllers when the widget is removed from the widget tree -> avoid memory leaks
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.3, 0.6, 1],
                    colors: [
                      AppPallete.backgroundColor,
                      Color.fromRGBO(45, 35, 45, 1),
                      Color.fromRGBO(40, 35, 50, 1),
                      Color.fromRGBO(30, 30, 40, 1),
                    ],
                  ),
                ),
              ),

              // Main content
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),

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
                              color: AppPallete.gradient1.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 30,
                              offset: const Offset(5, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.article_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Welcome text
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppPallete.whiteColor,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Sign in to continue your blogging journey",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppPallete.greyColor.withValues(alpha: 0.8),
                        ),
                      ),

                      const SizedBox(height: 50),

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
                          key: formKey,
                          child: Column(
                            children: [
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

                              const SizedBox(height: 30),

                              // Sign in button
                              AuthGradientButton(
                                text: "Sign In",
                                isLoading: state is AuthLoading,
                                onPressed: state is AuthLoading
                                    ? null
                                    : () {
                                        if (formKey.currentState!.validate()) {
                                          context.read<AuthBloc>().add(
                                            AuthSigninEvent(
                                              email: emailController.text
                                                  .trim(),
                                              password: passwordController.text
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

                      // Sign up link
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            SignUpPage.route(),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(
                              color: AppPallete.greyColor,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
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
