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
      'NOLOWERCASE1!',
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

}