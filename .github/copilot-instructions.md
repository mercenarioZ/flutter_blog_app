# Flutter Blog App - AI Coding Agent Instructions

## Architecture Overview

This Flutter blog app follows **Clean Architecture** with **BLoC/Cubit** state management and **GetIt** dependency injection:

```
lib/
├── core/
│   ├── common/
│   │   ├── cubits/app_user/     # Global user state (AppUserCubit)
│   │   ├── entities/            # Shared entities (User)
│   │   └── widgets/             # Reusable UI components
│   ├── error/                   # Exception/Failure handling
│   ├── theme/                   # AppPallete, AppTheme
│   ├── usecases/                # UseCase base class, NoParams
│   └── utils/                   # Utilities (snackbar, etc.)
├── features/
│   ├── auth/                    # Authentication feature
│   │   ├── domain/              # Entities, repositories, use cases
│   │   ├── data/                # Data sources, models, repository impl
│   │   └── presentation/        # BLoC, pages, widgets
│   └── blog/                    # Blog feature (expanding)
└── init_dependencies.dart       # GetIt service locator setup
```

## Key Architectural Patterns

### 1. Dependency Injection with GetIt

- **Service Locator Pattern**: All dependencies registered in `init_dependencies.dart`
- **Registration Types**: `registerFactory()` for short-lived, `registerLazySingleton()` for app-wide
- **Access Pattern**: `serviceLocator<AuthBloc>()` in main.dart providers

### 2. State Management Strategy

- **Feature BLoCs**: Handle specific feature logic (AuthBloc)
- **Global Cubit**: `AppUserCubit` manages app-wide user state
- **State Flow**: AuthBloc → emits AuthSuccess → updates AppUserCubit → triggers navigation
- **Navigation Logic**: Main app uses `BlocSelector<AppUserCubit>` to switch between LoginPage/BlogPage

### 3. Clean Architecture Layers

```dart
// Domain Layer (business logic)
abstract interface class AuthRepository {
  Future<Either<Failure, User>> signInWithEmailAndPassword();
}

// Data Layer (external dependencies)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  // Uses Either<Failure, Success> pattern from fpdart
}

// Presentation Layer (UI/BLoC)
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Coordinates use cases and updates global state
}
```

### 4. Error Handling Pattern

- **fpdart Either**: `Either<Failure, T>` for repository returns
- **Exception Hierarchy**: `ServerException` → `Failure` → UI error messages
- **BLoC Error States**: `AuthFailure(message)` → snackbar display

## Supabase Integration

### Authentication Flow

1. **Auth Data Source**: Direct Supabase client integration
2. **Session Management**: `currentUserSession` getter pattern
3. **Profile Data**: Separate `profiles` table for extended user data
4. **Data Merging**: Combines auth user + profile data via `copyWith` pattern

```dart
// Critical: User profiles stored in separate 'profiles' table
final user = await supabaseClient
    .from('profiles')
    .select()
    .eq('id', currentUserSession!.user.id);
return UserModel.fromJson(user.first)
    .copyWith(email: currentUserSession!.user.email);
```

## UI/UX Patterns

### Theme System

- **AppPallete**: Centralized color definitions with gradient colors
- **Modern Syntax**: Use `withValues(alpha: 0.3)` instead of deprecated `withOpacity()`
- **Gradient Usage**: `[AppPallete.gradient1, gradient2, gradient3]` for consistent branding

### Reusable Components

- **AuthInputField**: Standard form input with validation
- **Chip Selection**: Tag selection pattern in AddBlogPage
- **BlocConsumer**: Standard pattern for state listening + UI building

### Navigation Pattern

```dart
// Route definition in StatefulWidget
static route() => MaterialPageRoute(builder: (context) => const Page());

// Navigation
Navigator.push(context, PageName.route());
```

## Development Workflow

### Adding New Features

1. **Domain First**: Define entities, repositories, use cases
2. **Data Layer**: Implement data sources and repository
3. **Register Dependencies**: Add to `init_dependencies.dart`
4. **BLoC/Cubit**: Create presentation layer state management
5. **UI**: Build pages and widgets

### Key Dependencies

- **supabase_flutter**: Backend integration
- **flutter_bloc**: State management
- **get_it**: Dependency injection
- **fpdart**: Functional programming (Either pattern)
- **image_picker**: Media handling

### Current Implementation Status

- ✅ Authentication (signin/signup/session management)
- ✅ User state management (AppUserCubit)
- ✅ Navigation flow (login → blog home)
- 🚧 Blog CRUD operations (add_blog_page structure exists)
- 🚧 Blog data persistence

## Critical Development Notes

1. **UserModel copyWith**: Must implement `copyWith()` method for profile data merging
2. **BLoC Registration**: Use `registerLazySingleton()` for BLoCs that need global access
3. **State Updates**: AuthBloc success must call `_appUserCubit.updateUser()` for navigation
4. **Error Boundaries**: Always wrap Supabase calls in try-catch with ServerException
5. **Asset Management**: Images handled via image_picker package

When implementing new features, follow the established Clean Architecture pattern and maintain consistency with the existing state management flow.

Each step you generate, I want you to generate the code slowly, do not go too far each time.
