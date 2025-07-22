import 'package:flutter_app/core/error/exceptions.dart';
import 'package:flutter_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthDataSource {
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthDataSourceImpl implements AuthDataSource {
  final SupabaseClient supabaseClient;
  AuthDataSourceImpl(this.supabaseClient);

  // Implementation of the methods using Supabase client
  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    // Logic to sign up with Supabase
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );

      if (response.user == null) {
        throw ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // Logic to sign in with Supabase
    // Todo: Implement this method
    throw UnimplementedError(
      'signInWithEmailAndPassword is not implemented yet',
    );
  }
}
