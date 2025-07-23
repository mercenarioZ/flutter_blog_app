import 'package:flutter/material.dart';
import 'package:flutter_app/features/auth/domain/entities/user.dart';
import 'package:flutter_app/features/auth/domain/usecases/user_signin.dart';
import 'package:flutter_app/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserSignin _userSignin;

  AuthBloc({required UserSignup userSignup, required UserSignin userSignin})
    : _userSignup = userSignup,
      _userSignin = userSignin,
      super(AuthInitial()) {
    on<AuthSignupEvent>(_onAuthSignupEvent);
    on<AuthSigninEvent>(_onAuthSigninEvent);
  }

  void _onAuthSigninEvent(
    AuthSigninEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final response = await _userSignin(
      UserSigninParams(email: event.email, password: event.password),
    );

    response.fold(
      (onLeft) => emit(AuthFailure(onLeft.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthSignupEvent(
    AuthSignupEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final response = await _userSignup(
      UserSignupParams(
        name: event.name,
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      ),
    );

    response.fold(
      (onLeft) => emit(AuthFailure(onLeft.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
