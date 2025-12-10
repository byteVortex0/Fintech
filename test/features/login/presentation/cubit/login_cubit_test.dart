import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fintech/features/login/data/repository/login_repository.dart';
import 'package:fintech/features/login/presentation/cubit/login_cubit.dart';
import 'package:fintech/features/login/presentation/cubit/login_state.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

class MockUser extends Mock implements User {}

void main() {
  group('LoginCubit', () {
    test('initial state is LoginState.initial()', () {
      final mockLoginRepository = MockLoginRepository();
      final loginCubit = LoginCubit(mockLoginRepository);
      expect(loginCubit.state, equals(const LoginState.initial()));
      loginCubit.close();
    });

    const testEmail = 'test@example.com';
    const testPassword = 'password123';

    blocTest<LoginCubit, LoginState>(
      'emits [Loading, Authenticated] when login succeeds',
      build: () {
        final mockLoginRepository = MockLoginRepository();
        final mockUser = MockUser();
        when(() => mockUser.email).thenReturn(testEmail);
        when(() => mockUser.uid).thenReturn('uid123');
        when(
          () => mockLoginRepository.signInWithEmailAndPassword(
            email: testEmail,
            password: testPassword,
          ),
        ).thenAnswer((_) async => mockUser);
        return LoginCubit(mockLoginRepository);
      },
      act: (cubit) => cubit.login(email: testEmail, password: testPassword),
      expect: () => [
        const LoginState.loading(),
        const LoginState.authenticated(testEmail),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [Loading, Error] when email is empty',
      build: () => LoginCubit(MockLoginRepository()),
      act: (cubit) => cubit.login(email: '', password: testPassword),
      expect: () => [
        const LoginState.loading(),
        const LoginState.error('Email and password are required'),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [Loading, Error] when password is empty',
      build: () => LoginCubit(MockLoginRepository()),
      act: (cubit) => cubit.login(email: testEmail, password: ''),
      expect: () => [
        const LoginState.loading(),
        const LoginState.error('Email and password are required'),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [Loading, Error] when both fields empty',
      build: () => LoginCubit(MockLoginRepository()),
      act: (cubit) => cubit.login(email: '', password: ''),
      expect: () => [
        const LoginState.loading(),
        const LoginState.error('Email and password are required'),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [Loading, Error] on repository exception',
      build: () {
        final mockLoginRepository = MockLoginRepository();
        when(
          () => mockLoginRepository.signInWithEmailAndPassword(
            email: testEmail,
            password: testPassword,
          ),
        ).thenThrow(Exception('User not found'));
        return LoginCubit(mockLoginRepository);
      },
      act: (cubit) => cubit.login(email: testEmail, password: testPassword),
      expect: () => [
        const LoginState.loading(),
        isA<LoginState>().having(
          (state) => state.mapOrNull(error: (error) => error.message),
          'error message',
          contains('User not found'),
        ),
      ],
    );
  });
}
