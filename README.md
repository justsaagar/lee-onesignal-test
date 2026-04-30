# Flutter Template - GetX + Dependency Injection

## Project Overview
This is a **Flutter template** with a clean 3-tier architecture using:
- **GetX** for state management and routing
- **GetIt** (via `AppInjector`) for dependency injection
- **Firebase** integration (Auth, Firestore, Storage, Remote Config)
- **Repository pattern** for data layer abstraction

## Architecture

### 3-Tier Structure
```
┌─────────────────────────────────────┐
│   Presentation Layer                │
│   - Screens (UI)                    │
│   - Controllers (GetX)              │
│   - Screen Helpers (Business Logic)│
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│   Domain/Business Layer            │
│   - Repository Interfaces           │
│   - Repository Implementations      │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│   Data Layer                        │
│   - Firebase Services               │
│   - REST API (RestServices)         │
│   - Local Storage                   │
└─────────────────────────────────────┘
```

### Key Components

- **Dependency Injection**: Centralized via `AppInjector` (no global variables)
  - Location: `lib/app/di/injector.dart`
  - Register dependencies: `AppInjector.registerAll()` in `main.dart`
  - Resolve: `AppInjector.get<RepositoryType>()`

- **State Management**: GetX Controllers
  - Controllers extend `GetxController`
  - Use `GetBuilder` for reactive UI updates
  - Screen helpers contain business logic

- **Repository Pattern**: Abstract interfaces with implementations
  - `AuthRepository` / `AuthRepositoryImpl`
  - `UtilsRepository` / `UtilsRepositoryImpl`

## Project Structure

```
lib/
├── app/
│   ├── config/              # App configuration (e.g., feedback strip toggle)
│   ├── constant/            # App constants (colors, strings, enums)
│   ├── di/                  # Dependency injection (AppInjector)
│   ├── helper/              # Helper utilities (extensions, REST, validation)
│   ├── routes/              # Route definitions and navigation helpers
│   ├── utils/               # Utility functions (dimensions, date utils, app functions)
│   └── widgets/             # Reusable UI widgets
├── controller/              # GetX controllers for state management
├── repository/              # Repository interfaces and implementations
│   ├── authentication/      # Auth repository
│   └── utils/              # Utils repository (Firestore utilities)
├── screen/                  # UI screens
│   ├── onboarding/         # Onboarding screen + helper
│   └── splash/              # Splash screen + helper
├── serialized/              # Data models (JSON serializable)
└── service/                 # Services (connectivity, permissions)
```

## Links
- **GitHub Repository**: [GitHub Repo URL](https://github.com/your-username/your-repo)
- **Figma Design**: [Figma Link](https://www.figma.com/your-design-link)
- **Jira Issue Tracker**: [Jira Link](https://your-jira-instance.atlassian.net/your-project)

## Development Setup

### Prerequisites
- Flutter SDK: `>=3.8.1 <4.0.0` (latest 3.x)
- Dart Version: `>=3.8.1 <4.0.0`
- Node.js: `v16.x` or higher (for Husky Git hooks)

Make sure you have Flutter, Dart, and Node.js set up on your machine before you proceed with the setup. You can install Flutter from [flutter.dev](https://flutter.dev/docs/get-started/install) and Node.js from [nodejs.org](https://nodejs.org/).

### Run the Project

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/your-username/your-repo.git
    cd your-repo
    ```

2. **Change package name**:
   Since this is template not a project. So you may need to change the package name of this project.

   Run this command to make shell script executable:
    ```bash
    chmod +x package_name_change.sh
    ```

   To change the package name, use this command and replace package name with your new package name (write.new.package.name):
    ```bash
    ./package_name_change.sh pacakgeName
    ```

3. **Install Dependencies**:
   Run the following command to get all the dependencies required by the project:
    ```bash
    flutter pub get
    ```

4. **Setup Git Hooks (Husky)**:
   This project uses Husky for Git hooks to ensure code quality. Install Node.js dependencies and setup hooks:
    ```bash
    npm install
    ```
   This will automatically setup the following Git hooks:
   - **pre-commit**: Runs code formatting and static analysis
   - **commit-msg**: Validates commit message format (conventional commits)
   - **pre-push**: Runs tests before pushing to remote

5. **Generate Code for JSON Serialization**:
   Since this project uses JSON serialization (via `json_serializable` package), you need to run the `build_runner` command to generate code for your models.

   Run this command to generate the necessary code:
    ```bash
    dart run build_runner build
    ```

   If you are making changes to your models and want to regenerate the code, use this command:
    ```bash
    dart run build_runner watch
    ```

6. **Remove Firebase (If Applicable)**:
   Since this project uses firebase, if don't need it, you can remove it using following command.

   Run this command to make shell script executable:
    ```bash
    chmod +x remove_firebase.sh
    ```

   To remove the firebase from project, use this command:
    ```bash
    ./remove_firebase.sh
    ```

7. **Run the App**:
   To run the app on an emulator or connected device:
    ```bash
    flutter run
    ```

### Build the App

1. **Build for Android**:
   To build the app for an Android release:
    ```bash
    flutter build apk --release --no-tree-shake-icons
    ```

2. **Build for iOS**:
   To build the app for iOS:
    ```bash
    flutter build ios --release
    ```

## Git Hooks & Code Quality

This project uses **Husky** to enforce code quality through Git hooks:

### Available Git Hooks:
- **pre-commit**: 
  - Automatically formats staged Dart files and re-stages them
  - Runs static analysis (per-file if supported, otherwise full analysis)
  - Safely handles filenames with spaces and special characters
  - Provides clear error messages and exits on failures
- **commit-msg**: Validates commit messages follow conventional commits format
- **pre-push**: 
  - Runs comprehensive static analysis before pushing
  - Detects Flutter repositories automatically
  - Optional Flutter analyzer for additional safety

### NPM Scripts:
You can use these convenient npm scripts for common Flutter tasks:

```bash
# Code formatting and analysis
npm run format          # Format all Dart files
npm run analyze         # Run static analysis
npm run test           # Run tests

# Build commands
npm run build:android  # Build Android APK
npm run build:ios     # Build iOS app

# Development utilities
npm run clean          # Clean and get dependencies
npm run deps:update    # Update dependencies
npm run deps:get       # Get dependencies
npm run codegen        # Generate code (JSON serialization)
```

### Commit Message Format:
This project follows [Conventional Commits](https://www.conventionalcommits.org/) format:
```
<type>(<scope>): <description>

Examples:
feat(auth): add login functionality
fix(ui): resolve button alignment issue
docs(readme): update setup instructions
```

## Key Features & Improvements

### ✅ Dependency Injection
- **No global variables**: All DI handled via `AppInjector` class
- **Centralized registration**: All repositories registered in `AppInjector.registerAll()`
- **Type-safe resolution**: `AppInjector.get<RepositoryType>()`
- **Test-friendly**: Easy to mock dependencies for testing

### ✅ Clean Architecture
- **Separation of concerns**: Presentation, Domain, and Data layers clearly separated
- **Repository pattern**: Abstract interfaces with concrete implementations
- **Screen helpers**: Business logic contained in helper classes, not in widgets

### ✅ State Management
- **GetX controllers**: Lightweight controllers for state management
- **Reactive updates**: `GetBuilder` for efficient UI rebuilds
- **Lifecycle aware**: Controllers follow GetX lifecycle (onInit, onReady, onClose)

### ✅ Code Quality
- **Consistent naming**: Utils (not Utills) throughout the codebase
- **Error handling**: Proper error snackbars (`showError()` for errors, `showSuccess()` for success)
- **Logging**: Structured logging with different levels (info, error, warning, trace)

### ✅ Template Features
- **Optional feedback strip**: Toggle via `AppConfig.showFeedbackStrip`
- **Firebase integration**: Auth, Firestore, Storage, Remote Config ready
- **REST API support**: `RestServices` class for HTTP calls with connectivity checks
- **Reusable widgets**: Common UI components in `app/widgets/`

## Usage Examples

### Adding a New Repository

1. Create abstract interface:
```dart
// lib/repository/user/user_repository.dart
abstract class UserRepository {
  Future<User?> getUser(String userId);
}
```

2. Create implementation:
```dart
// lib/repository/user/user_repository_impl.dart
class UserRepositoryImpl extends UserRepository {
  @override
  Future<User?> getUser(String userId) async {
    // Implementation
  }
}
```

3. Register in `AppInjector`:
```dart
// lib/app/di/injector.dart
static Future<void> registerAll() async {
  // ... existing registrations
  _instance.registerSingleton<UserRepository>(UserRepositoryImpl());
}
```

4. Use in controller or helper:
```dart
final userRepository = AppInjector.get<UserRepository>();
```

### Creating a New Screen with Controller

1. Create controller:
```dart
// lib/controller/profile_controller.dart
class ProfileController extends GetxController {
  // State and methods
}
```

2. Create screen helper (if needed):
```dart
// lib/screen/profile/profile_helper.dart
class ProfileScreenHelper {
  ProfileScreenHelper(this.state);
  final ProfileScreenState state;
  // Business logic here
}
```

3. Create screen:
```dart
// lib/screen/profile/profile_screen.dart
GetBuilder(
  init: ProfileController(),
  builder: (ProfileController controller) {
    return Scaffold(/* UI */);
  },
)
```

4. Add route:
```dart
// lib/app/routes/route_constant.dart
GetPage(
  name: RouteConstant.profile,
  page: () => const ProfileScreen(),
),
```

## Notes
- Ensure that you have the appropriate development environment set up for Android or iOS.
- For further instructions on how to configure your device or emulator, refer to [Flutter Installation Guide](https://flutter.dev/docs/get-started/install).
- If you encounter issues with code generation (e.g., errors with `build_runner`), try clearing any generated files by running the following:
    ```bash
    dart run build_runner clean
    ```
- Git hooks will automatically run when you commit or push code. Make sure your code passes all checks before committing.
- **Firestore Collection Names**: The template uses `'utils'` as the Firestore collection name. If your existing data uses `'utills'`, update `AppCollectionConstants.utils` in `lib/app/constant/string_constant.dart` accordingly.

### Enhanced Hook Features:
- **Smart File Detection**: Only processes staged Dart files for efficiency
- **Auto-formatting**: Automatically formats code and re-stages formatted files
- **Robust Error Handling**: Clear error messages and proper exit codes
- **Flutter Detection**: Automatically detects Flutter projects and applies appropriate checks
- **Safe Filename Handling**: Properly handles files with spaces and special characters
- **Per-file Analysis**: Uses per-file analysis when supported by Dart SDK
- **Comprehensive Logging**: Detailed output showing what's being processed
