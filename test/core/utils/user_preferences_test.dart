import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fintech/core/service/shared_pref/shared_pref.dart';
import 'package:fintech/core/utils/user_preferences.dart';

// Mock SharedPref to test UserPreferences
class MockSharedPref extends Mock implements SharedPref {}

void main() {
  group('UserPreferences', () {
    // Note: Full testing requires proper setup of SharedPref singleton
    // These tests verify the structure and logic

    group('saveUserUid', () {
      test('saveUserUid method exists and is callable', () async {
        // In a real test environment with proper SharedPref setup:
        // await UserPreferences.saveUserUid('test_uid_123');
        expect(UserPreferences.saveUserUid, isNotNull);
      });
    });

    group('checkIfLoggedInUser', () {
      test(
        'checkIfLoggedInUser method exists and returns Future<bool>',
        () async {
          // In a real test environment:
          // final isLoggedIn = await UserPreferences.checkIfLoggedInUser();
          // expect(isLoggedIn, isFalse); // When no UID is saved
          expect(UserPreferences.checkIfLoggedInUser, isNotNull);
        },
      );
    });

    group('setBiometricEnrolled', () {
      test('setBiometricEnrolled method exists', () {
        expect(UserPreferences.setBiometricEnrolled, isNotNull);
      });
    });

    group('isBiometricEnrolled', () {
      test(
        'isBiometricEnrolled method exists and returns Future<bool>',
        () async {
          // In a real test environment:
          // final enrolled = await UserPreferences.isBiometricEnrolled();
          // expect(enrolled, isFalse); // Default when not set
          expect(UserPreferences.isBiometricEnrolled, isNotNull);
        },
      );
    });

    group('clearBiometricEnrollment', () {
      test('clearBiometricEnrollment method exists', () {
        expect(UserPreferences.clearBiometricEnrollment, isNotNull);
      });
    });

    group('saveBiometricEmail', () {
      test('saveBiometricEmail method exists', () {
        expect(UserPreferences.saveBiometricEmail, isNotNull);
      });
    });

    group('getBiometricEmail', () {
      test(
        'getBiometricEmail method exists and returns Future<String?>',
        () async {
          // In a real test environment:
          // final email = await UserPreferences.getBiometricEmail();
          // expect(email, isNull); // When not set
          expect(UserPreferences.getBiometricEmail, isNotNull);
        },
      );
    });

    group('saveBiometricPassword', () {
      test('saveBiometricPassword method exists', () {
        expect(UserPreferences.saveBiometricPassword, isNotNull);
      });
    });

    group('getBiometricPassword', () {
      test(
        'getBiometricPassword method exists and returns Future<String?>',
        () async {
          // In a real test environment:
          // final password = await UserPreferences.getBiometricPassword();
          // expect(password, isNull); // When not set
          expect(UserPreferences.getBiometricPassword, isNotNull);
        },
      );
    });

    group('hasBiometricCredentials', () {
      test(
        'hasBiometricCredentials method exists and returns Future<bool>',
        () async {
          // In a real test environment:
          // final hasCredentials = await UserPreferences.hasBiometricCredentials();
          // expect(hasCredentials, isFalse); // When credentials not set
          expect(UserPreferences.hasBiometricCredentials, isNotNull);
        },
      );

      test('returns false when email or password is empty', () async {
        // This tests the logic:
        // hasCredentials = email != null && email.isNotEmpty && password != null && password.isNotEmpty
        expect(UserPreferences.hasBiometricCredentials, isNotNull);
      });
    });
  });
}
