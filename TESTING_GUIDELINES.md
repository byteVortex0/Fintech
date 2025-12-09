# Testing Guidelines & Code Examples

## Table of Contents
1. [Setup & Configuration](#setup--configuration)
2. [Data Layer Testing](#data-layer-testing)
3. [BLoC/Cubit Testing](#bloccubit-testing)
4. [Widget Testing](#widget-testing)
5. [Common Patterns](#common-patterns)
6. [Troubleshooting](#troubleshooting)

---

## Setup & Configuration

### 1. Install Dependencies

```bash
flutter pub add --dev mockito bloc_test mocktail http_mock_adapter
```

### 2. Configure build_runner for Mockito

Create `build.yaml` in project root:
```yaml
targets:
  $default:
    builders:
      mockito:
        generate_for:
          - test/**_test.dart
```

### 3. Generate Mocks

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Data Layer Testing

### Repository Testing Example

**Test File**: `test/features/login/data/repository/login_repository_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:fintech/features/login/data/repository/login_repository.dart';
import 'package:fintech/core/service/api/api_service.dart';
import 'package:fintech/core/service/shared_pref/shared_pref.dart';
import 'package:dartz/dartz.dart';

// Generate mocks with: flutter pub run build_runner build
import 'login_repository_test.mocks.dart';

@GenerateMocks([ApiService, SharedPref])
void main() {
  group('LoginRepository', () {
    late LoginRepository loginRepository;
    late MockApiService mockApiService;
    late MockSharedPref mockSharedPref;

    setUp(() {
      mockApiService = MockApiService();
      mockSharedPref = MockSharedPref();
      loginRepository = LoginRepository(
        apiService: mockApiService,
        sharedPref: mockSharedPref,
      );
    });

    group('login', () {
      const testEmail = 'test@example.com';
      const testPassword = 'password123';

      test('returns Right(LoginResponse) when login is successful', () async {
        // Arrange
        final mockResponse = LoginResponse(
          token: 'test_token',
          user: User(id: '1', email: testEmail),
        );

        when(mockApiService.login(testEmail, testPassword))
            .thenAnswer((_) async => mockResponse);

        when(mockSharedPref.setString('token', 'test_token'))
            .thenAnswer((_) async => true);

        // Act
        final result = await loginRepository.login(testEmail, testPassword);

        // Assert
        expect(result, Right(mockResponse));
        verify(mockApiService.login(testEmail, testPassword)).called(1);
        verify(mockSharedPref.setString('token', 'test_token')).called(1);
      });

      test('returns Left(ErrorModel) when login fails', () async {
        // Arrange
        const errorMessage = 'Invalid credentials';
        when(mockApiService.login(testEmail, testPassword))
            .thenThrow(Exception(errorMessage));

        // Act
        final result = await loginRepository.login(testEmail, testPassword);

        // Assert
        expect(result, isA<Left>());
        verify(mockApiService.login(testEmail, testPassword)).called(1);
        verifyNever(mockSharedPref.setString('token', any));
      });

      test('returns Left(ErrorModel) when network fails', () async {
        // Arrange
        when(mockApiService.login(testEmail, testPassword))
            .thenThrow(SocketException('Network error'));

        // Act
        final result = await loginRepository.login(testEmail, testPassword);

        // Assert
        expect(result, isA<Left>());
      });
    });

    group('logout', () {
      test('clears token from shared preferences', () async {
        // Arrange
        when(mockSharedPref.remove('token')).thenAnswer((_) async => true);

        // Act
        await loginRepository.logout();

        // Assert
        verify(mockSharedPref.remove('token')).called(1);
      });
    });

    group('isLoggedIn', () {
      test('returns true when token exists', () {
        // Arrange
        when(mockSharedPref.getString('token')).thenReturn('test_token');

        // Act
        final result = loginRepository.isLoggedIn();

        // Assert
        expect(result, true);
      });

      test('returns false when token is null', () {
        // Arrange
        when(mockSharedPref.getString('token')).thenReturn(null);

        // Act
        final result = loginRepository.isLoggedIn();

        // Assert
        expect(result, false);
      });
    });
  });
}
```

### DataSource Testing Example

**Test File**: `test/features/login/data/datasource/login_remote_datasource_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

@GenerateMocks([http.Client])
void main() {
  group('LoginRemoteDataSource', () {
    late LoginRemoteDataSource dataSource;
    late MockClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockClient();
      dataSource = LoginRemoteDataSource(
        client: mockHttpClient,
        baseUrl: 'https://api.example.com',
      );
    });

    test('login returns LoginResponse when response code is 200', () async {
      // Arrange
      const endpoint = '/auth/login';
      final responseBody = jsonEncode({
        'token': 'test_token',
        'user': {'id': '1', 'email': 'test@example.com'},
      });

      when(mockHttpClient.post(
        Uri.parse('https://api.example.com$endpoint'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(responseBody, 200));

      // Act
      final result = await dataSource.login('test@example.com', 'password');

      // Assert
      expect(result.token, 'test_token');
      expect(result.user.email, 'test@example.com');
    });

    test('login throws Exception when response code is not 200', () {
      // Arrange
      when(mockHttpClient.post(any,
          headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Unauthorized', 401));

      // Act & Assert
      expect(
        () => dataSource.login('test@example.com', 'wrongpassword'),
        throwsException,
      );
    });
  });
}
```

---

## BLoC/Cubit Testing

### Cubit Testing Example

**Test File**: `test/features/login/presentation/cubit/login_cubit_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fintech/features/login/presentation/cubit/login_cubit.dart';
import 'package:fintech/features/login/presentation/cubit/login_state.dart';
import 'package:fintech/features/login/data/repository/login_repository.dart';

@GenerateMocks([LoginRepository])
void main() {
  group('LoginCubit', () {
    late LoginCubit loginCubit;
    late MockLoginRepository mockLoginRepository;

    setUp(() {
      mockLoginRepository = MockLoginRepository();
      loginCubit = LoginCubit(mockLoginRepository);
    });

    tearDown(() {
      loginCubit.close();
    });

    test('initial state is LoginInitialState', () {
      expect(loginCubit.state, isA<LoginInitialState>());
    });

    group('login', () {
      blocTest<LoginCubit, LoginState>(
        'emits [LoginLoadingState, LoginSuccessState] when login is successful',
        build: () {
          when(mockLoginRepository.login('test@example.com', 'password123'))
              .thenAnswer((_) async => Right(testLoginResponse));
          return loginCubit;
        },
        act: (cubit) => cubit.login('test@example.com', 'password123'),
        expect: () => [
          isA<LoginLoadingState>(),
          isA<LoginSuccessState>()
              .having((state) => state.user.email, 'email', 'test@example.com'),
        ],
        verify: (_) {
          verify(mockLoginRepository.login('test@example.com', 'password123'))
              .called(1);
        },
      );

      blocTest<LoginCubit, LoginState>(
        'emits [LoginLoadingState, LoginErrorState] when login fails',
        build: () {
          when(mockLoginRepository.login('test@example.com', 'wrongpassword'))
              .thenAnswer((_) async => Left(
                  ErrorModel(message: 'Invalid credentials', code: 'AUTH_001')));
          return loginCubit;
        },
        act: (cubit) => cubit.login('test@example.com', 'wrongpassword'),
        expect: () => [
          isA<LoginLoadingState>(),
          isA<LoginErrorState>()
              .having((state) => state.error.message, 'message',
                  'Invalid credentials'),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [LoginLoadingState, LoginErrorState] for invalid email',
        build: () => loginCubit,
        act: (cubit) => cubit.login('invalid-email', 'password123'),
        expect: () => [
          isA<LoginLoadingState>(),
          isA<LoginErrorState>()
              .having((state) => state.error.message, 'message',
                  contains('valid email')),
        ],
      );
    });

    group('emailChanged', () {
      blocTest<LoginCubit, LoginState>(
        'emits state with updated email',
        build: () => loginCubit,
        act: (cubit) => cubit.emailChanged('newemail@example.com'),
        expect: () => [
          isA<LoginInitialState>().having(
              (state) => state.email, 'email', 'newemail@example.com'),
        ],
      );
    });

    group('passwordChanged', () {
      blocTest<LoginCubit, LoginState>(
        'emits state with updated password',
        build: () => loginCubit,
        act: (cubit) => cubit.passwordChanged('newpassword'),
        expect: () => [
          isA<LoginInitialState>()
              .having((state) => state.password, 'password', 'newpassword'),
        ],
      );
    });
  });
}
```

### BLoC Testing Example

**Test File**: `test/features/market/presentation/logic/market_coins_bloc_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

void main() {
  group('MarketCoinsBloc', () {
    late MarketCoinsBloc marketCoinsBloc;
    late MockMarketRepository mockMarketRepository;

    setUp(() {
      mockMarketRepository = MockMarketRepository();
      marketCoinsBloc = MarketCoinsBloc(mockMarketRepository);
    });

    tearDown(() {
      marketCoinsBloc.close();
    });

    test('initial state is MarketInitialState', () {
      expect(marketCoinsBloc.state, isA<MarketInitialState>());
    });

    group('FetchMarketCoinsEvent', () {
      blocTest<MarketCoinsBloc, MarketState>(
        'emits [MarketLoadingState, MarketLoadedState] when coins are fetched successfully',
        build: () {
          when(mockMarketRepository.getMarketCoins(any, any, any))
              .thenAnswer((_) async => Right(testCoinsList));
          return marketCoinsBloc;
        },
        act: (bloc) => bloc.add(FetchMarketCoinsEvent()),
        expect: () => [
          isA<MarketLoadingState>(),
          isA<MarketLoadedState>()
              .having((state) => state.coins.length, 'coins length', 20),
        ],
      );

      blocTest<MarketCoinsBloc, MarketState>(
        'emits [MarketLoadingState, MarketErrorState] when fetch fails',
        build: () {
          when(mockMarketRepository.getMarketCoins(any, any, any))
              .thenAnswer((_) async =>
                  Left(ErrorModel(message: 'Network error', code: 'NET_001')));
          return marketCoinsBloc;
        },
        act: (bloc) => bloc.add(FetchMarketCoinsEvent()),
        expect: () => [
          isA<MarketLoadingState>(),
          isA<MarketErrorState>()
              .having((state) => state.message, 'message', 'Network error'),
        ],
      );
    });

    group('PaginationEvent', () {
      blocTest<MarketCoinsBloc, MarketState>(
        'fetches next page of coins',
        build: () {
          when(mockMarketRepository.getMarketCoins(2, any, any))
              .thenAnswer((_) async => Right(testNextPageCoins));
          return marketCoinsBloc;
        },
        act: (bloc) {
          bloc.add(FetchMarketCoinsEvent());
          bloc.add(PaginateMarketCoinsEvent(page: 2));
        },
        expect: () => [
          isA<MarketLoadingState>(),
          isA<MarketLoadedState>(),
          isA<MarketLoadingState>(),
          isA<MarketLoadedState>()
              .having((state) => state.coins.length, 'coins length', 40),
        ],
      );
    });
  });
}
```

---

## Widget Testing

### Simple Widget Test Example

**Test File**: `test/features/login/presentation/widgets/login_form_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('LoginForm Widget', () {
    late MockLoginCubit mockLoginCubit;

    setUp(() {
      mockLoginCubit = MockLoginCubit();
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: Scaffold(
          body: BlocProvider<LoginCubit>.value(
            value: mockLoginCubit,
            child: const LoginForm(),
          ),
        ),
      );
    }

    testWidgets('displays email and password input fields',
        (WidgetTester tester) async {
      // Arrange
      when(mockLoginCubit.state).thenReturn(LoginInitialState());

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(TextField), findsWidgets);
      expect(find.byKey(const Key('email_input')), findsOneWidget);
      expect(find.byKey(const Key('password_input')), findsOneWidget);
    });

    testWidgets('email input calls emailChanged when user types',
        (WidgetTester tester) async {
      // Arrange
      when(mockLoginCubit.state).thenReturn(LoginInitialState());

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.enterText(
          find.byKey(const Key('email_input')), 'test@example.com');
      await tester.pumpAndSettle();

      // Assert
      verify(mockLoginCubit.emailChanged('test@example.com')).called(1);
    });

    testWidgets('login button is disabled when form is invalid',
        (WidgetTester tester) async {
      // Arrange
      when(mockLoginCubit.state).thenReturn(LoginInitialState(
        email: 'invalid-email',
        password: '123',
      ));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      final loginButton = find.byKey(const Key('login_button'));
      expect(
          tester.widget<ElevatedButton>(loginButton).enabled, false);
    });

    testWidgets('login button is enabled when form is valid',
        (WidgetTester tester) async {
      // Arrange
      when(mockLoginCubit.state).thenReturn(LoginInitialState(
        email: 'valid@example.com',
        password: 'validpassword123',
      ));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      final loginButton = find.byKey(const Key('login_button'));
      expect(
          tester.widget<ElevatedButton>(loginButton).enabled, true);
    });

    testWidgets('shows error message when login fails',
        (WidgetTester tester) async {
      // Arrange
      when(mockLoginCubit.state).thenReturn(
        LoginErrorState(
            error: ErrorModel(message: 'Invalid credentials', code: 'AUTH_001')),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Invalid credentials'), findsOneWidget);
    });
  });
}
```

---

## Common Patterns

### Pattern 1: Testing with Test Fixtures

**File**: `test/fixtures/login_fixtures.dart`

```dart
import 'package:fintech/features/login/data/models/login_response.dart';
import 'package:fintech/features/login/data/models/user_model.dart';

// Test data fixtures
final testUser = UserModel(
  id: '1',
  email: 'test@example.com',
  firstName: 'Test',
  lastName: 'User',
);

final testLoginResponse = LoginResponse(
  token: 'test_token_xyz123',
  user: testUser,
  expiresIn: 3600,
);
```

### Pattern 2: Testing Multiple Scenarios

```dart
void testLoginValidation() {
  const testCases = [
    (email: '', password: '', expectedError: 'Email is required'),
    (email: 'invalid', password: '123', expectedError: 'Invalid email'),
    (email: 'valid@example.com', password: '12', expectedError: 'Min 8 chars'),
    (email: 'valid@example.com', password: 'validpass', expectedError: null),
  ];

  for (final testCase in testCases) {
    test('validates login for ${testCase.email} with ${testCase.password}',
        () {
      final result = loginCubit.validateLogin(
        testCase.email,
        testCase.password,
      );

      if (testCase.expectedError != null) {
        expect(result, testCase.expectedError);
      } else {
        expect(result, isNull);
      }
    });
  }
}
```

### Pattern 3: Testing Concurrent Events

```dart
blocTest<MarketCoinsBloc, MarketState>(
  'handles concurrent fetch events correctly',
  build: () {
    when(mockMarketRepository.getMarketCoins(any, any, any))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(milliseconds: 100));
      return Right(testCoinsList);
    });
    return marketCoinsBloc;
  },
  act: (bloc) {
    bloc.add(FetchMarketCoinsEvent());
    bloc.add(FetchMarketCoinsEvent()); // Duplicate request
    bloc.add(FetchMarketCoinsEvent()); // Another duplicate
  },
  expect: () => [
    isA<MarketLoadingState>(),
    isA<MarketLoadedState>(), // Only one success state
  ],
);
```

---

## Troubleshooting

### Issue: "The method 'xxx' was called with mismatched arguments"

**Solution**: Ensure mockito matchers match the actual parameters exactly.

```dart
// ❌ Wrong - any() doesn't match String parameter
when(mockRepository.login(any)).thenAnswer((_) async => Right(data));

// ✅ Correct - use any<String>() or specific matcher
when(mockRepository.login(any<String>())).thenAnswer((_) async => Right(data));
when(mockRepository.login('test@example.com')).thenAnswer((_) async => Right(data));
```

### Issue: "No matching calls"

**Solution**: Check that your test is actually calling the mocked method.

```dart
// ✅ Call the method you expect to be called
final result = await loginRepository.login('test@example.com', 'password');

// ✅ Then verify it was called
verify(mockLoginRepository.login('test@example.com', 'password')).called(1);
```

### Issue: "Bad state: Cannot add new events after calling close"

**Solution**: Ensure tearDown closes the cubit/bloc properly.

```dart
tearDown(() {
  loginCubit.close(); // ✅ Always close in tearDown
});
```

---

## Running Tests

```bash
# Run all tests
flutter test

# Run tests for specific feature
flutter test test/features/login/

# Run tests with coverage
flutter test --coverage

# Run tests with verbose output
flutter test -v

# Run specific test file
flutter test test/features/login/data/repository/login_repository_test.dart
```

---

**Last Updated**: December 2025
