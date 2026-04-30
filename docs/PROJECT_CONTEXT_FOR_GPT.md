# Project Context For GPT

Use this document as the shared context when asking GPT for change suggestions, refactors, or implementation prompts for this repository.

## 1) What This Project Is
- Type: Flutter mobile app/template
- Pattern: Clean-ish layered architecture with GetX + GetIt + repositories
- Primary goal: reusable starter with splash/onboarding flow and utility scaffolding
- Package name in code: `untitled` (can be changed with `package_name_change.sh`)

## 2) Current Tech Stack
- Flutter SDK constraint: `>=3.8.1 <4.0.0`
- State management + navigation: `get`
- Dependency injection: `get_it`
- Networking: `http`
- Connectivity: `connectivity_plus`, `internet_connection_checker_plus`
- Serialization: `json_annotation`, `json_serializable`, `build_runner`
- UI helpers: `carousel_slider`, `google_fonts`, `cached_network_image`, `flutter_svg`, `lottie`, `shimmer`, etc.
- Tooling/hooks: npm + Husky (`package.json` scripts)

## 3) Important Architectural Rules In This Repo
- `main.dart` bootstraps app and calls `AppInjector.registerAll()`.
- Dependencies are resolved via `AppInjector.get<T>()`, not global singletons.
- UI logic is split into:
  - screen widgets (`lib/screen/**`)
  - controller (`lib/controller/**`)
  - helper classes (`lib/screen/**/**_helper.dart`)
- Data access is behind repository interfaces in `lib/repository/**`.
- Keep feature code modular; avoid embedding business logic directly in widgets.

## 4) Firebase Status (Important)
- Firebase has been completely removed from this project.
- Removed:
  - Firebase Dart dependencies from `pubspec.yaml`
  - Firebase initialization in `lib/main.dart`
  - Firebase config files and setup artifacts
  - Firebase references in iOS/macOS project files
- Current replacements:
  - `AuthRepositoryImpl` is now a local placeholder implementation (non-backend)
  - `UtilsRepositoryImpl` returns local static onboarding data
- Implication: auth/storage/utils are template stubs now, not production backend integrations.

## 5) Runtime Flow (High-Level)
1. App starts in `lib/main.dart`
2. Initial route is `/` (`SplashScreen`)
3. `SplashScreenHelper` waits ~2s then routes to `/onBoarding`
4. `OnBoardingScreenHelper` loads onboarding data from `UtilsRepository`
5. Onboarding UI uses carousel data and static action controls

## 6) Key Files GPT Should Know
- App entry:
  - `lib/main.dart`
- DI container:
  - `lib/app/di/injector.dart`
- Routing:
  - `lib/app/routes/route_constant.dart`
  - `lib/app/routes/route_helper.dart`
- Splash/onboarding:
  - `lib/screen/splash/splash_screen.dart`
  - `lib/screen/splash/splash_helper.dart`
  - `lib/screen/onboarding/onboarding_screen.dart`
  - `lib/screen/onboarding/onboarding_helper.dart`
- Repositories:
  - `lib/repository/authentication/auth_repository.dart`
  - `lib/repository/authentication/authentication_helper.dart`
  - `lib/repository/utils/utils_repository.dart`
  - `lib/repository/utils/utils_helper.dart`
- Common helpers:
  - `lib/app/helper/rest_helper.dart`
  - `lib/app/helper/extension_helper.dart`

## 7) Current Gaps / Likely Next Work
- Auth repository is stubbed; no real backend auth flow.
- Utils repository uses hardcoded local data.
- `RestConstants.baseUrl` is empty, so REST services need API configuration.
- Onboarding actions are mostly UI-level placeholders.
- No end-to-end production flow is wired yet.

## 8) Coding Conventions For Suggested Changes
- Prefer adding repository interfaces + implementations instead of direct API calls in widgets.
- Keep DI registration centralized in `AppInjector`.
- Reuse shared widgets/constants/helpers where possible.
- Keep null safety and avoid introducing global mutable state.
- Match existing naming style and file organization.

## 9) How To Ask GPT Effectively (Prompt Template)
Use this template:

```text
You are helping me modify a Flutter project with GetX + GetIt repositories.

Project constraints:
- No Firebase usage
- Keep repository pattern + dependency injection
- Do not put business logic directly in widgets
- Keep changes production-ready and null-safe

Target change:
<describe feature/bug clearly>

Relevant files:
<list file paths>

Expected output:
1) Short implementation plan
2) Exact file-by-file code changes
3) Any migration steps or commands
4) Edge cases and test checklist
```

## 10) Handy Local Commands
- Install dependencies: `flutter pub get`
- Run app: `flutter run`
- Analyze: `flutter analyze`
- Test: `flutter test`
- Format: `dart format .`
- Codegen: `dart run build_runner build --delete-conflicting-outputs`
