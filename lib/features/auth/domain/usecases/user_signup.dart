import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/core/usecases/usecases.dart';
import 'package:flutter_app/core/common/entities/user.dart';
import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements UseCase<User, UserSignupParams> {
  final AuthRepository repo;
  const UserSignup(this.repo);

  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async {
    return await repo.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
      confirmPassword: params.confirmPassword,
    );
  }
}

class UserSignupParams {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  UserSignupParams({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
