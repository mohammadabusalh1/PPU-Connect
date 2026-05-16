import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/core/validators/auth_validators.dart';

void main() {
  group('EmailValidator.ppu', () {
    test('returns error when value is null', () {
      expect(EmailValidator.ppu(null), 'Email is required');
    });

    test('returns error when value is empty', () {
      expect(EmailValidator.ppu(''), 'Email is required');
    });

    test('returns error when value is blank whitespace', () {
      expect(EmailValidator.ppu('   '), 'Email is required');
    });

    test('returns error for invalid email format', () {
      expect(EmailValidator.ppu('notanemail'), 'Enter a valid email address');
    });

    test('returns error for email with no domain', () {
      expect(EmailValidator.ppu('user@'), 'Enter a valid email address');
    });

    test('returns error for valid format but non-PPU domain', () {
      expect(
        EmailValidator.ppu('user@gmail.com'),
        'Must use a PPU email (@ppu.edu.ps or @student.ppu.edu.ps)',
      );
    });

    test('accepts staff PPU email', () {
      expect(EmailValidator.ppu('lecturer@ppu.edu.ps'), isNull);
    });

    test('accepts student PPU email', () {
      expect(EmailValidator.ppu('student@student.ppu.edu.ps'), isNull);
    });

    test('accepts PPU email with mixed case', () {
      expect(EmailValidator.ppu('User@PPU.EDU.PS'), isNull);
    });

    test('returns error for partial PPU domain', () {
      expect(
        EmailValidator.ppu('user@notppu.edu.ps'),
        'Must use a PPU email (@ppu.edu.ps or @student.ppu.edu.ps)',
      );
    });
  });

  group('EmailValidator.format', () {
    test('returns error when null', () {
      expect(EmailValidator.format(null), 'Email is required');
    });

    test('returns error when empty', () {
      expect(EmailValidator.format(''), 'Email is required');
    });

    test('returns error for invalid format', () {
      expect(EmailValidator.format('bad-email'), 'Enter a valid email address');
    });

    test('accepts any valid email format', () {
      expect(EmailValidator.format('user@gmail.com'), isNull);
    });

    test('accepts PPU email', () {
      expect(EmailValidator.format('user@ppu.edu.ps'), isNull);
    });
  });

  group('PasswordValidator.strength', () {
    test('returns error when null', () {
      expect(PasswordValidator.strength(null), 'Password is required');
    });

    test('returns error when empty', () {
      expect(PasswordValidator.strength(''), 'Password is required');
    });

    test('returns error when too short', () {
      expect(PasswordValidator.strength('Ab1!'), 'At least 8 characters');
    });

    test('returns error when no uppercase', () {
      expect(PasswordValidator.strength('password1!'), 'Add an uppercase letter');
    });

    test('returns error when no number', () {
      expect(PasswordValidator.strength('Password!'), 'Add a number');
    });

    test('returns error when no special character', () {
      expect(PasswordValidator.strength('Password1'), 'Add a special character');
    });

    test('accepts strong password', () {
      expect(PasswordValidator.strength('Password1!'), isNull);
    });

    test('accepts password with various special characters', () {
      expect(PasswordValidator.strength('Password1@'), isNull);
      expect(PasswordValidator.strength('Password1#'), isNull);
      expect(PasswordValidator.strength('Password1\$'), isNull);
    });
  });

  group('PasswordValidator.match', () {
    test('returns null when passwords match', () {
      expect(PasswordValidator.match('secret123')('secret123'), isNull);
    });

    test('returns error when passwords do not match', () {
      expect(
        PasswordValidator.match('secret123')('different'),
        'Passwords do not match',
      );
    });

    test('returns error when confirm is null', () {
      expect(PasswordValidator.match('secret123')(null), 'Passwords do not match');
    });
  });

  group('PasswordValidator.score', () {
    test('returns 0 for empty string', () {
      expect(PasswordValidator.score(''), 0);
    });

    test('returns 1 for length-only criteria met', () {
      expect(PasswordValidator.score('abcdefgh'), 1);
    });

    test('returns 2 for length + uppercase', () {
      expect(PasswordValidator.score('Abcdefgh'), 2);
    });

    test('returns 3 for length + uppercase + digit', () {
      expect(PasswordValidator.score('Abcdefg1'), 3);
    });

    test('returns 4 for all criteria met', () {
      expect(PasswordValidator.score('Abcdef1!'), 4);
    });

    test('returns 0 for short string with no criteria', () {
      expect(PasswordValidator.score('abc'), 0);
    });
  });

  group('NameValidator.required', () {
    test('returns error when null', () {
      expect(NameValidator.required(null), 'Name is required');
    });

    test('returns error when empty', () {
      expect(NameValidator.required(''), 'Name is required');
    });

    test('returns error when blank whitespace', () {
      expect(NameValidator.required('   '), 'Name is required');
    });

    test('returns error when name exceeds 100 characters', () {
      expect(
        NameValidator.required('A' * 101),
        'Name must be 100 characters or fewer',
      );
    });

    test('returns error when name has leading space', () {
      expect(NameValidator.required(' Ahmad'), 'Remove leading/trailing spaces');
    });

    test('returns error when name has trailing space', () {
      expect(NameValidator.required('Ahmad '), 'Remove leading/trailing spaces');
    });

    test('accepts valid name', () {
      expect(NameValidator.required('Ahmad Hassan'), isNull);
    });

    test('accepts name of exactly 100 characters', () {
      expect(NameValidator.required('A' * 100), isNull);
    });
  });
}
