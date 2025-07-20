import 'package:flutter_app/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class SupabaseDataSource {
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class SupabaseDataSourceImpl implements SupabaseDataSource {
  final SupabaseClient supabaseClient;
  SupabaseDataSourceImpl(this.supabaseClient);

  // Implementation of the methods using Supabase client
  @override
  Future<String> signUpWithEmailAndPassword({
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
      return response.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // Logic to sign in with Supabase
    // TODO: Implement this method
    throw UnimplementedError('signInWithEmailAndPassword is not implemented yet');
  }
}
