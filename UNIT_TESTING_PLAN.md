# Unit Testing Plan - Fintech App

## Overview
This document outlines the comprehensive unit testing strategy for the Fintech Flutter application. The plan covers all layers of the clean architecture: data, domain, and presentation layers.

## Current Project Structure
```
lib/features/
├── buy_crypto/
├── coin_details/
├── home/
├── login/
├── market/
├── onboarding/
├── payment_method/
├── portfolio/
├── register/
└── settings/

lib/core/
├── di/
├── routing/
├── service/
├── utils/
└── ...
```

## Testing Strategy

### 1. Test Framework & Dependencies

#### Required Packages
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^6.1.0
  bloc_test: ^9.1.0
  mocktail: ^0.3.0
  http_mock_adapter: ^0.5.0
  fake_cloud_firestore: ^1.3.0  # For Firebase mocking
  firebase_auth_mocks: ^0.10.0  # For Firebase Auth mocking
```

#### Installation Command
```bash
flutter pub add --dev mockito bloc_test mocktail http_mock_adapter fake_cloud_firestore firebase_auth_mocks
```

### 2. Testing Layers

#### Layer 1: Data Layer (Repository & DataSource)
**Purpose**: Test API calls, local storage, and data transformations

**Key Components to Test**:
- **Repositories**:
  - `LoginRepository`
  - `RegisterRepository`
  - `MarketRepository`
  - `CoinDetailsRepository`
  - `PortfolioRepository`
  - `SettingsRepository`

- **Services**:
  - `ApiService` (Retrofit)
  - `SharedPrefService`
  - `BiometricEnrollmentService`
  - `FirebaseService`

**Test Structure**:
```
test/
├── features/
│   ├── login/
│   │   ├── data/
│   │   │   ├── repository/
│   │   │   │   └── login_repository_test.dart
│   │   │   └── datasource/
│   │   │       └── login_local_datasource_test.dart
│   ├── register/
│   ├── market/
│   └── ...
├── core/
│   ├── service/
│   │   ├── api_service_test.dart
│   │   ├── shared_pref_service_test.dart
│   │   └── ...
│   └── utils/
│       ├── user_preferences_test.dart
│       └── ...
```

**Example Test Cases**:
- ✅ Successful API response handling
- ✅ Error handling (network errors, validation errors)
- ✅ Data model serialization/deserialization
- ✅ Local storage persistence
- ✅ Cache invalidation
- ✅ Network timeout handling

---

#### Layer 2: State Management (BLoC/Cubit)
**Purpose**: Test business logic and state transitions

**Key Components to Test**:
- **Login Feature**:
  - `LoginCubit` - Email/password authentication
  - `AutoLoginCubit` - Biometric auto-login flow
  - `BiometricCubit` - Biometric enrollment

- **Register Feature**:
  - `RegisterCubit` - User registration
  - `FingerprintEnrollmentCubit`
  - `FaceIdEnrollmentCubit`

- **Market Feature**:
  - `MarketCoinsCubit` - Cryptocurrency list
  - `SearchCoinsCubit` - Coin search

- **Coin Details Feature**:
  - `CoinDetailsCubit` - Coin details data
  - `ChartCubit` - Price chart data

- **Home Feature**:
  - `HomeScreenCubit` - Home screen data

- **Portfolio Feature**:
  - `PortfolioCubit` - User portfolio data

- **Settings Feature**:
  - `SettingsCubit` - App settings management

**Test Structure**:
```
test/
├── features/
│   ├── login/
│   │   └── presentation/
│   │       └── cubit/
│   │           ├── login_cubit_test.dart
│   │           ├── auto_login_cubit_test.dart
│   │           └── biometric_cubit_test.dart
│   ├── register/
│   └── ...
```

**Example Test Cases**:
- ✅ Initial state verification
- ✅ Successful state transitions
- ✅ Error state handling
- ✅ Loading state management
- ✅ Event handling and emission
- ✅ Concurrent event handling
- ✅ State restoration on errors

---

#### Layer 3: Utility Functions & Services
**Purpose**: Test helper functions and utilities

**Components to Test**:
- `UserPreferences` - User preference management
- `AppRegex` - Validation utilities
- `ColorManager` - Color utilities
- `NavigationService` - App navigation
- Custom formatters and parsers

**Test Structure**:
```
test/
├── core/
│   ├── utils/
│   │   ├── user_preferences_test.dart
│   │   ├── app_regex_test.dart
│   │   ├── color_manager_test.dart
│   │   └── ...
│   └── service/
│       ├── navigation_service_test.dart
│       └── ...
```

**Example Test Cases**:
- ✅ Email validation
- ✅ Password strength validation
- ✅ Phone number formatting
- ✅ Date formatting
- ✅ Price formatting
- ✅ Navigation parameter passing

---

#### Layer 4: Models & Mappers
**Purpose**: Test data serialization and transformation

**Components to Test**:
- Freezed models (JSON serialization)
- Data mappers
- Model validation

**Test Structure**:
```
test/
├── features/
│   ├── login/
│   │   └── data/
│   │       └── models/
│   │           ├── login_response_test.dart
│   │           └── login_request_test.dart
│   └── ...
```

**Example Test Cases**:
- ✅ JSON deserialization
- ✅ JSON serialization
- ✅ Model equality
- ✅ Model copyWith functionality
- ✅ Model validation

---

### 3. Testing Best Practices

#### Mocking Strategy
```dart
// Use mockito for repositories and services
final mockLoginRepository = MockLoginRepository();
final mockSharedPref = MockSharedPref();

// Use mocktail for better type safety
when(() => mockLoginRepository.login(any(), any()))
    .thenAnswer((_) async => Right(user));
```

#### Test Structure Template
```dart
void main() {
  group('FeatureBloc/Cubit', () {
    late MockRepository mockRepository;
    late FeatureCubit featureCubit;

    setUp(() {
      mockRepository = MockRepository();
      featureCubit = FeatureCubit(mockRepository);
    });

    tearDown(() {
      featureCubit.close();
    });

    test('initial state is correct', () {
      expect(featureCubit.state, InitialState());
    });

    blocTest<FeatureCubit, FeatureState>(
      'emits [LoadingState, SuccessState] when successful',
      build: () {
        when(() => mockRepository.getData())
            .thenAnswer((_) async => testData);
        return featureCubit;
      },
      act: (cubit) => cubit.loadData(),
      expect: () => [
        LoadingState(),
        SuccessState(testData),
      ],
    );
  });
}
```

#### Coverage Goals
- **Target Coverage**: Minimum 80% code coverage
- **Priority**:
  1. Data layer (repositories, services): 90%+
  2. Business logic (BLoC/Cubit): 85%+
  3. Utilities & helpers: 80%+
  4. Models & mappers: 100%

---

### 4. Feature-by-Feature Testing Plan

#### Priority 1: Core Features (High Priority)

**Login Feature**
- [ ] LoginCubit tests
  - [ ] Email validation
  - [ ] Password validation
  - [ ] Successful login
  - [ ] Login error handling
  - [ ] Session persistence

- [ ] BiometricCubit tests
  - [ ] Biometric enrollment
  - [ ] Biometric authentication
  - [ ] Biometric fallback to password

- [ ] LoginRepository tests
  - [ ] Firebase authentication
  - [ ] User creation
  - [ ] Session management

**Register Feature**
- [ ] RegisterCubit tests
  - [ ] Form validation
  - [ ] Registration success
  - [ ] Email verification

- [ ] BiometricEnrollmentService tests
  - [ ] Fingerprint enrollment
  - [ ] Face ID enrollment
  - [ ] Biometric storage

---

#### Priority 2: Business Features (Medium Priority)

**Market Feature**
- [ ] MarketCoinsCubit tests
- [ ] MarketRepository tests
- [ ] Coin search functionality
- [ ] Market data filtering

**Coin Details Feature**
- [ ] CoinDetailsCubit tests
- [ ] ChartCubit tests
- [ ] CoinDetailsRepository tests

---

#### Priority 3: Supporting Features (Lower Priority)

**Settings Feature**
- [ ] SettingsCubit tests
- [ ] User preferences persistence
- [ ] Theme switching

**Portfolio Feature**
- [ ] PortfolioCubit tests
- [ ] Portfolio data aggregation
- [ ] Portfolio calculations

---

### 5. Implementation Schedule

| Phase | Duration | Features | Deliverables |
|-------|----------|----------|---------------|
| Phase 1 | Week 1 | Setup & Core Data Layer | Test infrastructure, 20+ repository tests |
| Phase 2 | Week 2 | Login & Auth BLoCs | 30+ BLoC tests, 100% login coverage |
| Phase 3 | Week 3 | Register & Biometric | 25+ registration tests |
| Phase 4 | Week 4 | Market & Home | 25+ market tests |
| Phase 5 | Week 5 | Portfolio & Settings | 20+ feature tests |
| Phase 6 | Week 6 | Utilities & Polish | 30+ utility tests, CI/CD integration |

---

### 6. CI/CD Integration

#### GitHub Actions Configuration
Add to `.github/workflows/pr-checks.yml`:
```yaml
- name: Run tests
  run: flutter test --coverage

- name: Upload coverage
  uses: codecov/codecov-action@v3
  with:
    files: ./coverage/lcov.info
    flags: flutter
```

#### Local Testing Commands
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run tests for specific feature
flutter test test/features/login/

# Run tests with verbose output
flutter test -v

# Run tests in watch mode
flutter test --watch
```

---

### 7. Test Naming Conventions

```dart
// ✅ Good - describes what is being tested
test('login_cubit_emits_success_when_credentials_are_valid')

test('market_repository_throws_error_on_network_failure')

test('user_preferences_persists_email_correctly')

// ❌ Poor - too vague
test('test login')
test('repository works')
```

---

### 8. Mock & Stub Patterns

#### Common Mocks Needed
```dart
// Data sources
- MockLoginRemoteDataSource
- MockLoginLocalDataSource
- MockMarketRemoteDataSource

// Repositories
- MockLoginRepository
- MockRegisterRepository
- MockMarketRepository

// Services
- MockApiService
- MockSharedPreferenceService
- MockFirebaseService
- MockNavigationService
```

---

### 9. Testing Checklist

- [ ] Setup mockito and bloc_test dependencies
- [ ] Create mock generators (build_runner config)
- [ ] Write repository tests (Data Layer)
- [ ] Write BLoC/Cubit tests (Presentation Layer)
- [ ] Write utility function tests
- [ ] Write model serialization tests
- [ ] Achieve 80%+ code coverage
- [ ] Integrate tests in CI/CD pipeline
- [ ] Create test documentation
- [ ] Train team on testing standards

---

### 10. Resources & Documentation

- [Flutter Testing Guide](https://flutter.dev/docs/testing)
- [Mockito Documentation](https://pub.dev/packages/mockito)
- [Bloc Testing](https://pub.dev/packages/bloc_test)
- [Clean Architecture Testing](https://resocoder.com/flutter-clean-architecture-tdd)

---

## Next Steps

1. **Immediate**: Install required testing dependencies
2. **Week 1**: Create test infrastructure and folder structure
3. **Week 2**: Write first set of repository tests for Login feature
4. **Week 3-6**: Implement remaining tests according to schedule
5. **Ongoing**: Maintain >80% coverage for all new code

---

**Last Updated**: December 2025
**Status**: Planning Phase
**Owner**: Development Team
