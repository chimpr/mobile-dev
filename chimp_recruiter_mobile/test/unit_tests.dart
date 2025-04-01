import 'package:flutter_test/flutter_test.dart';
import 'package:chimp_recruiter_mobile/utils/validators.dart';

void main() {

  // signup password unit test
  group('Password Validation Tests', () {
    final validPasswords = [
      'Password1!',
      'Secure@123',
      'HELLOworld9\$',
      'A1b2C3d4!',
    ];

    final invalidPasswords = [
      'short1!',
      'nouppercase1!',
      '1001000100',
      'NoSpecialChar1',
      'NoNumber!',
      '',
      '       ',
    ];

    for (var password in validPasswords) {
      test('Valid password: $password', () {
        expect(isValidPassword(password), true);
      });
    }

    for (var password in invalidPasswords) {
      test('Invalid password: $password', () {
        expect(isValidPassword(password), false);
      });
    }
  });

  // signup email unit test
  group('Email Validation Tests', () {
    final validEmails = [
      'test@example.com',
      'john.doe@mail.co.uk',
      'user123@domain.io',
    ];

    final invalidEmails = [
      'justtext',
      'noatsign.com',
      '@nodomain',
      'missing@dot',
    ];

    for (var email in validEmails) {
      test('Valid email: $email', () {
        expect(isValidEmail(email), true);
      });
    }

    for (var email in invalidEmails) {
      test('Invalid email: $email', () {
        expect(isValidEmail(email), false);
      });
    }
  });

  
// login role logic unit test
  group('User Role Detection Tests', () {
    test('Returns UserRole.student for "Student" role', () {
      final response = {"Role": "Student"};
      expect(getUserRoleFromResponse(response), UserRole.student);
    });

    test('Returns UserRole.recruiter for "Recruiter" role', () {
      final response = {"Role": "Recruiter"};
      expect(getUserRoleFromResponse(response), UserRole.recruiter);
    });

    test('Returns UserRole.unknown for unexpected role value', () {
      final response = {"Role": "Admin"};
      expect(getUserRoleFromResponse(response), UserRole.unknown);
    });

    test('Returns UserRole.unknown for missing Role key', () {
      final Map<String, dynamic> response = {};
      expect(getUserRoleFromResponse(response), UserRole.unknown);
    });

    test('Returns UserRole.unknown for null Role', () {
      final response = {"Role": null};
      expect(getUserRoleFromResponse(response), UserRole.unknown);
    });
  });


    group('ID Validation Tests', () {
    final validIds = [
      '507f1f77bcf86cd799439011',
      'ffffffffffffffffffffffff',
      '1234567890abcdefABCDEF12',
      '9a3f2b7c6e1d4f8a0b2c3d9e',
      'ABCDEF123456abcdef789012',
      '00ff11aa22bb33cc44dd55ee',
      'a1b2c3d4e5f6A7B8C9D0E1F2',
    ];

    final invalidIds = [
      '507f1f77bcf86cd79943901',
      '507f1f77bcf86cd7994390111',
      '507f1f77bcf86cd79943901Z',
      '',
      '     ',
      'g07f1f77bcf86cd799439011',
      'QWERTYUIOPASDFGHJKLZXCVB',
      'xyz1234567890ABCDEFghijkl',
      'www.google.com',
      'https://www.google.com',
    ];

    for (var id in validIds) {
      test('Valid ID: $id', () {
        expect(isValidId(id), true);
      });
    }

    for (var id in invalidIds) {
      test('Invalid ID: $id', () {
        expect(isValidId(id), false);
      });
    }
  });

}