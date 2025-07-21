part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  AuthSignUpEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
