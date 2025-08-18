# Flutter Blog App

A modern Flutter blog application built with Clean Architecture, BLoC state management, and Supabase backend integration. This app demonstrates best practices in Flutter development with a focus on scalability, maintainability, and clean code principles.

## ✨ Features

- **Authentication System**: Sign up, sign in, and session management
- **User Profiles**: Extended user data with profile management
- **Blog Management**: Create, read, update, and delete blog posts
- **Image Handling**: Pick and upload images for blog posts
- **Modern UI**: Beautiful gradient-based design with custom themes
- **Offline Support**: Robust error handling and state management

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/
│   ├── common/           # Shared components and global state
│   ├── error/           # Exception and failure handling
│   ├── theme/           # App theming and colors
│   ├── usecases/        # Base use case classes
│   └── utils/           # Utility functions
├── features/
│   ├── auth/            # Authentication feature
│   └── blog/            # Blog management feature
└── init_dependencies.dart  # Dependency injection setup
```

### Key Architectural Patterns

- **Clean Architecture**: Domain, Data, and Presentation layers
- **BLoC/Cubit**: State management with flutter_bloc
- **Dependency Injection**: GetIt service locator pattern
- **Repository Pattern**: Abstract data layer with concrete implementations
- **Either Pattern**: Functional error handling with fpdart

## 🚀 Tech Stack

- **Framework**: Flutter 3.x
- **State Management**: flutter_bloc, BLoC/Cubit pattern
- **Backend**: Supabase (Authentication, Database, Storage)
- **Dependency Injection**: get_it
- **Functional Programming**: fpdart
- **Image Handling**: image_picker
- **Architecture**: Clean Architecture

## 📱 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Supabase account

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/mercenarioZ/flutter_blog_app.git
   cd flutter_blog_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Set up Supabase**

   - Create a new project at [supabase.com](https://supabase.com)
   - Create the required tables (users, profiles, blogs)
   - Add your Supabase URL and anon key to `lib/core/secrets/app_secrets.dart`

4. **Run the app**
   ```bash
   flutter run
   ```

## 🗄️ Database Schema

### Profiles Table

```sql
CREATE TABLE profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  name TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Blogs Table (Future Implementation)

```sql
CREATE TABLE blogs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  image_url TEXT,
  owner_id UUID REFERENCES profiles(id) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## 🎨 Design System

The app uses a custom design system with:

- **Color Palette**: Gradient-based theme with primary brand colors
- **Typography**: Consistent text styles across the app
- **Components**: Reusable UI components (AuthInputField, custom buttons)
- **Responsive Design**: Adaptive layouts for different screen sizes

## 🔧 Development

### Project Structure

Each feature follows the Clean Architecture pattern:

```
features/feature_name/
├── domain/
│   ├── entities/         # Business objects
│   ├── repositories/     # Abstract contracts
│   └── usecases/        # Business logic
├── data/
│   ├── datasources/     # External data sources
│   ├── models/          # Data transfer objects
│   └── repositories/    # Repository implementations
└── presentation/
    ├── bloc/            # State management
    ├── pages/           # UI screens
    └── widgets/         # Reusable components
```

### State Management Flow

1. **UI Events** → BLoC receives events
2. **Use Cases** → BLoC calls business logic
3. **Repository** → Use cases interact with data layer
4. **State Updates** → BLoC emits new states
5. **UI Rebuilds** → UI reacts to state changes

### Adding New Features

1. Define domain entities and repositories
2. Implement data sources and repository
3. Create use cases for business logic
4. Register dependencies in `init_dependencies.dart`
5. Build BLoC for state management
6. Create UI pages and widgets

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feat/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feat/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Supabase for the excellent backend service
- BLoC library maintainers for state management solution
- Tutorial: Rivaan Ranawat (YouTube)
