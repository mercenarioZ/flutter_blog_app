import 'package:flutter_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_app/core/secrets/secrets.dart';
import 'package:flutter_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutter_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_app/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_app/features/auth/domain/usecases/user_signin.dart';
import 'package:flutter_app/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:flutter_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:flutter_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:flutter_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Explain: get_it singleton, used for accessing dependencies throughout the app
final serviceLocator = GetIt.instance;

// Explain: Main function
Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  // Initialize Supabase here
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  // Register Supabase client as a lazy singleton. This means it will be created only when it's first requested.
  serviceLocator.registerLazySingleton(() => supabase.client);

  // core dependencies
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    // data source
    ..registerFactory<AuthDataSource>(
      () => AuthDataSourceImpl(serviceLocator()),
    )
    // repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    // use cases
    ..registerFactory(() => UserSignup(serviceLocator()))
    ..registerFactory(() => UserSignin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    // bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignup: serviceLocator(),
        userSignin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  // data source
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(serviceLocator()),
    )
    // repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(blogRemoteDataSource: serviceLocator()),
    )
    // use cases
    ..registerFactory(() => UploadBlog(blogRepository: serviceLocator()))
    // bloc
    ..registerLazySingleton(() => BlogBloc(serviceLocator()));
}
