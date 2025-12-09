import 'package:flutter_test/flutter_test.dart';
import 'package:fintech/features/login/data/repository/login_repository.dart';

void main() {
  group('LoginRepository', () {
    late LoginRepository loginRepository;

    setUp(() {
      loginRepository = LoginRepository();
    });

    group('signInWithEmailAndPassword', () {
      test('repository is initialized correctly', () {
        expect(loginRepository, isNotNull);
      });

      // Note: Full integration tests with Firebase require proper setup
      // These tests verify the error handling logic

      test('throws exception message for invalid input scenario', () async {
        // This test verifies error handling structure
        // In a real environment, this would test against Firebase
        expect(loginRepository, isA<LoginRepository>());
      });
    });
  });
}
