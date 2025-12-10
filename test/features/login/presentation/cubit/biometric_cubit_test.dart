import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fintech/features/login/data/repository/biometric_repository.dart';
import 'package:fintech/features/login/presentation/cubit/biometric_cubit.dart';
import 'package:fintech/features/login/presentation/cubit/biometric_state.dart';

class MockBiometricRepository extends Mock implements BiometricRepository {}

class MockUser extends Mock implements User {}

void main() {
  group('BiometricCubit', () {
    late BiometricCubit biometricCubit;
    late MockBiometricRepository mockBiometricRepository;
    late MockUser mockUser;

    setUp(() {
      mockBiometricRepository = MockBiometricRepository();
      mockUser = MockUser();
      biometricCubit = BiometricCubit(mockBiometricRepository);
    });

    tearDown(() {
      biometricCubit.close();
    });

    group('initial state', () {
      test('initial state is BiometricState.initial()', () {
        expect(biometricCubit.state, equals(const BiometricState.initial()));
      });
    });

    group('checkBiometricSupport', () {
      blocTest<BiometricCubit, BiometricState>(
        'emits [notSupported] when device does not support biometrics',
        setUp: () {
          when(
            () => mockBiometricRepository.canUseBiometrics(),
          ).thenAnswer((_) async => false);
        },
        build: () => biometricCubit,
        act: (cubit) => cubit.checkBiometricSupport(),
        expect: () => [const BiometricState.notSupported()],
      );

      blocTest<BiometricCubit, BiometricState>(
        'emits nothing when device supports biometrics',
        setUp: () {
          when(
            () => mockBiometricRepository.canUseBiometrics(),
          ).thenAnswer((_) async => true);
        },
        build: () => biometricCubit,
        act: (cubit) => cubit.checkBiometricSupport(),
        expect: () => [],
      );

      blocTest<BiometricCubit, BiometricState>(
        'emits [error] when repository throws exception',
        setUp: () {
          when(
            () => mockBiometricRepository.canUseBiometrics(),
          ).thenThrow(Exception('Biometric check failed'));
        },
        build: () => biometricCubit,
        act: (cubit) => cubit.checkBiometricSupport(),
        expect: () => [
          isA<BiometricState>().having(
            (state) => state.mapOrNull(error: (error) => error.message),
            'error message',
            equals('Failed to check biometric support'),
          ),
        ],
      );
    });

    group('authenticateWithBiometrics', () {
      const testEmail = 'test@example.com';
      const testPassword = 'password123';
      const testLocalizedReason = 'Authenticate with your fingerprint';
      const testUid = 'uid123';

      blocTest<BiometricCubit, BiometricState>(
        'emits [Loading, Authenticated] when authentication succeeds',
        setUp: () {
          when(() => mockUser.uid).thenReturn(testUid);
          when(() => mockUser.email).thenReturn(testEmail);
          when(
            () => mockBiometricRepository.authenticateWithBiometrics(
              email: testEmail,
              password: testPassword,
              localizedReason: testLocalizedReason,
            ),
          ).thenAnswer((_) async => mockUser);
        },
        build: () => biometricCubit,
        act: (cubit) => cubit.authenticateWithBiometrics(
          email: testEmail,
          password: testPassword,
          localizedReason: testLocalizedReason,
        ),
        expect: () => [
          const BiometricState.loading(),
          const BiometricState.authenticated(testUid),
        ],
      );

      blocTest<BiometricCubit, BiometricState>(
        'emits [Loading, Error] when authentication fails',
        setUp: () {
          when(
            () => mockBiometricRepository.authenticateWithBiometrics(
              email: testEmail,
              password: testPassword,
              localizedReason: testLocalizedReason,
            ),
          ).thenThrow(Exception('Biometric authentication failed'));
        },
        build: () => biometricCubit,
        act: (cubit) => cubit.authenticateWithBiometrics(
          email: testEmail,
          password: testPassword,
          localizedReason: testLocalizedReason,
        ),
        expect: () => [
          const BiometricState.loading(),
          isA<BiometricState>().having(
            (state) => state.mapOrNull(error: (error) => error.message),
            'error message',
            contains('Biometric authentication failed'),
          ),
        ],
      );

      blocTest<BiometricCubit, BiometricState>(
        'emits [Loading, Error] when user is null',
        setUp: () {
          when(
            () => mockBiometricRepository.authenticateWithBiometrics(
              email: testEmail,
              password: testPassword,
              localizedReason: testLocalizedReason,
            ),
          ).thenAnswer((_) async => null);
        },
        build: () => biometricCubit,
        act: (cubit) => cubit.authenticateWithBiometrics(
          email: testEmail,
          password: testPassword,
          localizedReason: testLocalizedReason,
        ),
        expect: () => [
          const BiometricState.loading(),
          const BiometricState.error('Authentication failed'),
        ],
      );

      blocTest<BiometricCubit, BiometricState>(
        'calls repository with correct parameters',
        setUp: () {
          when(() => mockUser.uid).thenReturn(testUid);
          when(() => mockUser.email).thenReturn(testEmail);
          when(
            () => mockBiometricRepository.authenticateWithBiometrics(
              email: testEmail,
              password: testPassword,
              localizedReason: testLocalizedReason,
            ),
          ).thenAnswer((_) async => mockUser);
        },
        build: () => biometricCubit,
        act: (cubit) => cubit.authenticateWithBiometrics(
          email: testEmail,
          password: testPassword,
          localizedReason: testLocalizedReason,
        ),
        verify: (cubit) {
          verify(
            () => mockBiometricRepository.authenticateWithBiometrics(
              email: testEmail,
              password: testPassword,
              localizedReason: testLocalizedReason,
            ),
          ).called(1);
        },
      );
    });
  });
}
