import 'package:flutter_test/flutter_test.dart';
import 'package:fintech/core/utils/app_regex.dart';

void main() {
  group('AppRegex', () {
    group('isEmailValid', () {
      test('returns true for valid email format', () {
        expect(AppRegex.isEmailValid('test@example.com'), isTrue);
        expect(AppRegex.isEmailValid('user.name@domain.co.uk'), isTrue);
        expect(AppRegex.isEmailValid('john.doe@company.com'), isTrue);
      });

      test('returns false for invalid email format', () {
        expect(AppRegex.isEmailValid('invalid.email'), isFalse);
        expect(AppRegex.isEmailValid('test@'), isFalse);
        expect(AppRegex.isEmailValid('test@domain'), isFalse);
        expect(AppRegex.isEmailValid('@example.com'), isFalse);
        expect(AppRegex.isEmailValid(''), isFalse);
      });

      test('returns false for email without domain extension', () {
        expect(AppRegex.isEmailValid('test@domain'), isFalse);
      });
    });

    group('isPasswordValid', () {
      test('returns true for valid password (8+ chars, upper, lower, digit, special)', () {
        expect(AppRegex.isPasswordValid('Password123@'), isTrue);
        expect(AppRegex.isPasswordValid('SecurePass\$456'), isTrue);
        expect(AppRegex.isPasswordValid('Abc123!%'), isTrue);
      });

      test('returns false for password without uppercase', () {
        expect(AppRegex.isPasswordValid('password123!'), isFalse);
      });

      test('returns false for password without lowercase', () {
        expect(AppRegex.isPasswordValid('PASSWORD123!'), isFalse);
      });

      test('returns false for password without digit', () {
        expect(AppRegex.isPasswordValid('Password!@#'), isFalse);
      });

      test('returns false for password without special character', () {
        expect(AppRegex.isPasswordValid('Password123'), isFalse);
      });

      test('returns false for password shorter than 8 characters', () {
        expect(AppRegex.isPasswordValid('Pass1!a'), isFalse);
      });

      test('returns false for empty password', () {
        expect(AppRegex.isPasswordValid(''), isFalse);
      });
    });

    group('isPhoneNumberValid', () {
      test('returns true for valid Egyptian phone numbers', () {
        expect(AppRegex.isPhoneNumberValid('01001234567'), isTrue);
        expect(AppRegex.isPhoneNumberValid('01101234567'), isTrue);
        expect(AppRegex.isPhoneNumberValid('01201234567'), isTrue);
        expect(AppRegex.isPhoneNumberValid('01501234567'), isTrue);
      });

      test('returns false for invalid phone numbers', () {
        expect(AppRegex.isPhoneNumberValid('02001234567'), isFalse);
        expect(AppRegex.isPhoneNumberValid('1001234567'), isFalse);
        expect(AppRegex.isPhoneNumberValid('0100123456'), isFalse);
        expect(AppRegex.isPhoneNumberValid(''), isFalse);
      });

      test('returns false for non-numeric characters', () {
        expect(AppRegex.isPhoneNumberValid('0100123456a'), isFalse);
      });
    });

    group('hasLowerCase', () {
      test('returns true when password contains lowercase letters', () {
        expect(AppRegex.hasLowerCase('Password'), isTrue);
        expect(AppRegex.hasLowerCase('abc123'), isTrue);
      });

      test('returns false when password has no lowercase letters', () {
        expect(AppRegex.hasLowerCase('PASSWORD'), isFalse);
        expect(AppRegex.hasLowerCase('123'), isFalse);
      });
    });

    group('hasUpperCase', () {
      test('returns true when password contains uppercase letters', () {
        expect(AppRegex.hasUpperCase('Password'), isTrue);
        expect(AppRegex.hasUpperCase('ABC123'), isTrue);
      });

      test('returns false when password has no uppercase letters', () {
        expect(AppRegex.hasUpperCase('password'), isFalse);
        expect(AppRegex.hasUpperCase('123'), isFalse);
      });
    });

    group('hasNumber', () {
      test('returns true when password contains digits', () {
        expect(AppRegex.hasNumber('Password123'), isTrue);
        expect(AppRegex.hasNumber('abc1def'), isTrue);
      });

      test('returns false when password has no digits', () {
        expect(AppRegex.hasNumber('Password'), isFalse);
        expect(AppRegex.hasNumber('abc'), isFalse);
      });
    });

    group('hasSpecialCharacter', () {
      test('returns true when password contains special characters', () {
        expect(AppRegex.hasSpecialCharacter('Password!'), isTrue);
        expect(AppRegex.hasSpecialCharacter('Password@123'), isTrue);
        expect(AppRegex.hasSpecialCharacter('abc#def'), isTrue);
      });

      test('returns false when password has no special characters', () {
        expect(AppRegex.hasSpecialCharacter('Password123'), isFalse);
        expect(AppRegex.hasSpecialCharacter('abc'), isFalse);
      });
    });

    group('hasMinLength', () {
      test('returns true for password with 8 or more characters', () {
        expect(AppRegex.hasMinLength('Password'), isTrue);
        expect(AppRegex.hasMinLength('12345678'), isTrue);
        expect(AppRegex.hasMinLength('LongPassword123'), isTrue);
      });

      test('returns false for password shorter than 8 characters', () {
        expect(AppRegex.hasMinLength('Pass12'), isFalse);
        expect(AppRegex.hasMinLength('abc'), isFalse);
      });

      test('returns false for empty password', () {
        expect(AppRegex.hasMinLength(''), isFalse);
      });
    });
  });
}
