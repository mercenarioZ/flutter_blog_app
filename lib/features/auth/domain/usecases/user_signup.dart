import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/core/usecases/usecases.dart';
import 'package:flutter_app/features/auth/domain/entities/user.dart';
import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignup(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
      confirmPassword: params.confirmPassword,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
