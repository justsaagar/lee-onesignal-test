# Flutter Template - GetX + Dependency Injection

## Project Overview
This is a Flutter starter app using a clean 3-tier structure with:
- GetX for routing and state updates
- GetIt (`AppInjector`) for dependency injection
- Repository pattern for data access abstraction
- Local placeholder data for onboarding

## Architecture

### 3-Tier Structure
```
Presentation Layer
- Screens
- Controllers
- Screen helpers

Domain/Data Layer
- Repository interfaces
- Repository implementations

Services Layer
- Connectivity checks
- REST helper
- Utility helpers
```

## Setup

### Prerequisites
- Flutter SDK `>=3.8.1 <4.0.0`
- Dart SDK `>=3.8.1 <4.0.0`
- Node.js `v16+` (for Husky hooks)

### Install
```bash
flutter pub get
npm install
```

### Run
```bash
flutter run
```

### Useful commands
```bash
npm run format
npm run analyze
npm run test
npm run codegen
```

## Notes
- Dependencies are registered in `lib/app/di/injector.dart`.
- Routes are declared in `lib/app/routes/route_constant.dart`.
- Onboarding content is returned from `lib/repository/utils/utils_helper.dart`.
- Splash navigation is handled in `lib/screen/splash/splash_helper.dart`.

## GPT Handoff Doc
Use `PROJECT_CONTEXT_FOR_GPT.md` when sharing project context with GPT for prompt help.
