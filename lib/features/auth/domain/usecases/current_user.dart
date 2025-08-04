import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/core/usecases/usecases.dart';
import 'package:flutter_app/features/auth/domain/entities/user.dart';
import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, Params> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await authRepository.currentUser();
  }
}

class Params {
  // pass params if needed, otherwise can be empty
}
