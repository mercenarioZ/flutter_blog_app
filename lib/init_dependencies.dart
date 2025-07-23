import 'package:flutter_app/core/secrets/secrets.dart';
import 'package:flutter_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutter_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_app/features/auth/domain/usecases/user_signin.dart';
import 'package:flutter_app/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Explain: get_it singleton, used for accessing dependencies throughout the app
final serviceLocator = GetIt.instance;

// Explain: Main function
Future<void> initDependencies() async {
  _initAuth();

  // Initialize Supabase here
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  // Register Supabase client as a lazy singleton. This means it will be created only when it's first requested.
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthDataSource>(
    () => AuthDataSourceImpl(serviceLocator()),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(() => UserSignup(serviceLocator()));

  serviceLocator.registerFactory(() => UserSignin(serviceLocator()));

  serviceLocator.registerFactory(
    () => AuthBloc(userSignup: serviceLocator(), userSignin: serviceLocator()),
  );
}
