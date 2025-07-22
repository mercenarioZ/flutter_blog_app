import 'package:flutter/material.dart';
import 'package:flutter_app/core/secrets/secrets.dart';
import 'package:flutter_app/core/theme/theme.dart';
import 'package:flutter_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutter_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_app/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            userSignup: UserSignup(
              AuthRepositoryImpl(AuthDataSourceImpl(supabase.client)),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
