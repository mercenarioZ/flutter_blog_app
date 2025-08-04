part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignupEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  AuthSignupEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

final class AuthSigninEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSigninEvent({required this.email, required this.password});
}

final class AuthCurrentUserEvent extends AuthEvent {}
