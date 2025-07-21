import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/core/usecases/usecases.dart';
import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements UseCase<String, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignup(this.authRepository);

  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    // check if password and confirm password match
    if (params.password != params.confirmPassword) {
      return Left(Failure("Passwords do not match"));
    }

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
