import 'package:flutter/material.dart';
import 'package:flutter_app/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;

  AuthBloc({required UserSignup userSignup})
    : _userSignup = userSignup,
      super(AuthInitial()) {
    on<AuthSignUpEvent>((event, emit) async {
      final response = await _userSignup(
        UserSignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword,
        ),
      );

      response.fold(
        (onLeft) => emit(AuthFailure(onLeft.message)),
        (userId) => emit(AuthSuccess(userId)),
      );
    });
  }
}
