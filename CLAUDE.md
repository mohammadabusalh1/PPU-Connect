# PPU Connect

Flutter application for Palestine Polytechnic University.

## Project

- **Name**: ppu_connect
- **Version**: 1.0.0+1
- **SDK**: Dart ^3.9.2 / Flutter

## Structure

```
lib/          # Dart source code (entry: lib/main.dart)
android/      # Android platform code
ios/          # iOS platform code
web/          # Web platform
windows/      # Windows platform
linux/        # Linux platform
macos/        # macOS platform
```

## Common Commands

```bash
# Run the app
flutter run

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format lib/

# Build
flutter build apk          # Android APK
flutter build ios          # iOS
flutter build web          # Web
```

## Dependencies

See [pubspec.yaml](pubspec.yaml) for the full list. Currently minimal:
- `cupertino_icons` — iOS-style icons
- `flutter_lints` — lint rules (dev)

## Code Style

- Follow `analysis_options.yaml` lint rules
- Use `dart format` before committing
- Prefer `const` constructors wherever possible
- State management: not yet decided — confirm before adding a solution
