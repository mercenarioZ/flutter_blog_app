import 'package:flutter/material.dart';
import 'package:flutter_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_app/core/common/entities/user.dart';
import 'package:flutter_app/core/usecases/usecases.dart';
import 'package:flutter_app/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_app/features/auth/domain/usecases/user_signin.dart';
import 'package:flutter_app/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserSignin _userSignin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignup userSignup,
    required UserSignin userSignin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  }) : _userSignup = userSignup,
       _userSignin = userSignin,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthSignupEvent>(_onAuthSignupEvent);
    on<AuthSigninEvent>(_onAuthSigninEvent);
    on<AuthCurrentUserEvent>(_onAuthCurrentUserEvent);
  }

  void _onAuthCurrentUserEvent(
    AuthCurrentUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final response = await _currentUser(
      const NoParams(),
    ); // actually no params needed

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
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
      (user) => _emitAuthSuccess(user, emit),
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
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  // Helper method to handle successful authentication
  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    emit(AuthSuccess(user));
    _appUserCubit.updateUser(user);
  }
}
