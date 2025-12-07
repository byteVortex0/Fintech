# Flavours Configuration

This document explains how to run the app with different flavours (dev and prod).

## Setup

Flavours are configured in:
- **Android**: `android/app/build.gradle.kts` - Product flavours definitions with unique bundle IDs
- **iOS**: Xcode schemes (`dev.xcscheme`, `prod.xcscheme`) and build configurations
- **Dart**: `lib/core/config/flavour_config.dart` - Centralized configuration constants

### Implementation Status

- ✅ **Dart Entry Points**: `lib/main_dev.dart` and `lib/main_prod.dart` created
- ✅ **Configuration Layer**: `flavour_config.dart` with environment-specific settings
- ✅ **Android**: Product flavours fully configured in `build.gradle.kts`
- ✅ **iOS Schemes**: `dev.xcscheme` and `prod.xcscheme` created
- ✅ **iOS xcconfig Files**: Build configuration files created for both flavours
- ⏳ **iOS Build Configs**: Xcode build configurations may require final setup in Xcode IDE

## Running Flavours

### Development Flavour

```bash
# Android
flutter run -t lib/main_dev.dart --flavor dev

# iOS
flutter run -t lib/main_dev.dart --flavor dev
```

### Production Flavour

```bash
# Android
flutter run -t lib/main_prod.dart --flavor prod

# iOS
flutter run -t lib/main_prod.dart --flavor prod
```

## Building APK/IPA

### Android APK - Development

```bash
flutter build apk --flavor dev -t lib/main_dev.dart
```

Output: `build/app/outputs/apk/dev/release/app-dev-release.apk`

### Android APK - Production

```bash
flutter build apk --flavor prod -t lib/main_prod.dart
```

Output: `build/app/outputs/apk/prod/release/app-prod-release.apk`

### iOS IPA - Development

```bash
flutter build ios --flavor dev -t lib/main_dev.dart
```

### iOS IPA - Production

```bash
flutter build ios --flavor prod -t lib/main_prod.dart
```

## Differences Between Flavours

### Development (`dev`)

- App name: **FinTech Dev**
- Bundle ID (Android): `com.byteVortex.fintech.dev`
- Bundle ID (iOS): `com.byteVortex.fintech.dev`
- Version: `1.0-dev`
- Debug logging: **Enabled**
- Dio logger: **Enabled**
- API: Development endpoints

### Production (`prod`)

- App name: **FinTech**
- Bundle ID (Android): `com.byteVortex.fintech`
- Bundle ID (iOS): `com.byteVortex.fintech`
- Version: `1.0`
- Debug logging: **Disabled**
- Dio logger: **Disabled**
- API: Production endpoints

## Configuration Code

Access current flavour in code:

```dart
import 'package:fintech/core/config/flavour_config.dart';

// Check if development
if (FlavourConfig.isDev) {
  print('Running in development mode');
}

// Check if production
if (FlavourConfig.isProd) {
  print('Running in production mode');
}

// Get app name
final appName = FlavourConfig.appName; // 'FinTech Dev' or 'FinTech'

// Get bundle ID
final bundleId = FlavourConfig.bundleId; // com.byteVortex.fintech.dev or com.byteVortex.fintech
```

## Testing Both Flavours

```bash
# Start dev and keep it running
flutter run -t lib/main_dev.dart --flavor dev

# In another terminal, start prod
flutter run -t lib/main_prod.dart --flavor prod

# Now you can test both versions side-by-side
```

## Troubleshooting

### App shows old flavour name

- Clear build: `flutter clean`
- Rebuild: `flutter pub get`
- Run again: `flutter run -t lib/main_dev.dart --flavor dev`

### Android Bundle ID conflicts

- Make sure each flavour has unique `applicationId` in `build.gradle.kts`
- Dev: `com.byteVortex.fintech.dev`
- Prod: `com.byteVortex.fintech`

### iOS Build Issues

- Clean build folder: `rm -rf ios/Pods ios/Podfile.lock`
- Get Flutter dependencies: `flutter pub get`
- Run: `flutter run -t lib/main_dev.dart --flavor dev`
