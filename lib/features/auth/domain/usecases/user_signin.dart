import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/core/usecases/usecases.dart';
import 'package:flutter_app/core/common/entities/user.dart';
import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignin implements UseCase<User, UserSigninParams> {
  final AuthRepository repo;
  const UserSignin(this.repo);

  @override
  Future<Either<Failure, User>> call(UserSigninParams params) async {
    return await repo.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSigninParams {
  final String email;
  final String password;

  UserSigninParams({required this.email, required this.password});
}
