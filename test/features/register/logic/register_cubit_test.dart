import 'package:flutter_test/flutter_test.dart';
import 'package:fintech/features/register/logic/register_cubit.dart';
import 'package:fintech/features/register/logic/register_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fintech/features/register/data/repos/register_repo.dart';

class MockRegisterRepo extends Mock implements RegisterRepo {}

void main() {
  group('RegisterCubit', () {
    test('initial state is RegisterState.initial()', () {
      final mockRepo = MockRegisterRepo();
      final cubit = RegisterCubit(mockRepo);

      expect(cubit.state, equals(const RegisterState.initial()));

      cubit.close();
    });

    test('all text controllers are initialized', () {
      final mockRepo = MockRegisterRepo();
      final cubit = RegisterCubit(mockRepo);

      expect(cubit.firstNameController, isNotNull);
      expect(cubit.lastNameController, isNotNull);
      expect(cubit.phoneController, isNotNull);
      expect(cubit.emailController, isNotNull);
      expect(cubit.passwordController, isNotNull);
      expect(cubit.confirmPasswordController, isNotNull);

      cubit.close();
    });

    test('formKey is initialized', () {
      final mockRepo = MockRegisterRepo();
      final cubit = RegisterCubit(mockRepo);

      expect(cubit.formKey, isNotNull);

      cubit.close();
    });

    test('createUser method exists and is callable', () {
      final mockRepo = MockRegisterRepo();
      final cubit = RegisterCubit(mockRepo);

      expect(cubit.createUser, isNotNull);

      cubit.close();
    });

    test('storeUser method exists and is callable', () {
      final mockRepo = MockRegisterRepo();
      final cubit = RegisterCubit(mockRepo);

      expect(cubit.storeUser, isNotNull);

      cubit.close();
    });
  });
}
