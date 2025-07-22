import 'package:flutter_app/core/error/exceptions.dart';
import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  const AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Either<Failure, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final userId = await authDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
