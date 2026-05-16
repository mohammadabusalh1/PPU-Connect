import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/core/utils/user_display_name.dart';

void main() {
  group('resolveUserDisplayName - fullName priority', () {
    test('returns trimmed fullName when provided', () {
      expect(
        resolveUserDisplayName(fullName: 'Ahmad Hassan', email: 'x@ppu.edu.ps'),
        'Ahmad Hassan',
      );
    });

    test('trims leading and trailing whitespace from fullName', () {
      expect(
        resolveUserDisplayName(fullName: '  Jane Doe  ', email: 'x@ppu.edu.ps'),
        'Jane Doe',
      );
    });
  });

  group('resolveUserDisplayName - email local part fallback', () {
    test('capitalizes simple local part', () {
      expect(
        resolveUserDisplayName(fullName: '', email: 'ahmad@ppu.edu.ps'),
        'Ahmad',
      );
    });

    test('splits dot-separated local part into title-case words', () {
      expect(
        resolveUserDisplayName(fullName: '', email: 'ahmad.hassan@ppu.edu.ps'),
        'Ahmad Hassan',
      );
    });

    test('splits underscore-separated local part into title-case words', () {
      expect(
        resolveUserDisplayName(fullName: '', email: 'sara_ali@student.ppu.edu.ps'),
        'Sara Ali',
      );
    });

    test('ignores empty segments from multiple dots', () {
      expect(
        resolveUserDisplayName(fullName: '', email: 'a..b@ppu.edu.ps'),
        'A B',
      );
    });
  });

  group('resolveUserDisplayName - fallback', () {
    test('returns default "User" fallback when name and email local are empty', () {
      expect(
        resolveUserDisplayName(fullName: '', email: '@ppu.edu.ps'),
        'User',
      );
    });

    test('returns custom fallback when provided', () {
      expect(
        resolveUserDisplayName(fullName: '', email: '@ppu.edu.ps', fallback: 'Tutor'),
        'Tutor',
      );
    });

    test('returns fallback when email is completely empty', () {
      expect(
        resolveUserDisplayName(fullName: '', email: '', fallback: 'Guest'),
        'Guest',
      );
    });
  });

  group('normalizeUserJson', () {
    test('uses fullName when present', () {
      final result = normalizeUserJson({'fullName': 'Ahmad', 'email': 'a@ppu.edu.ps'});
      expect(result['fullName'], 'Ahmad');
    });

    test('falls back to displayName when fullName is missing', () {
      final result = normalizeUserJson({
        'displayName': 'Khalid',
        'email': 'k@ppu.edu.ps',
      });
      expect(result['fullName'], 'Khalid');
    });

    test('falls back to name field when fullName and displayName are missing', () {
      final result = normalizeUserJson({
        'name': 'Lina',
        'email': 'l@ppu.edu.ps',
      });
      expect(result['fullName'], 'Lina');
    });

    test('derives name from email when all name fields are empty', () {
      final result = normalizeUserJson({
        'fullName': '',
        'email': 'tutor.user@ppu.edu.ps',
      });
      expect(result['fullName'], 'Tutor User');
    });

    test('preserves all original fields', () {
      final result = normalizeUserJson({
        'fullName': 'Ahmad',
        'email': 'a@ppu.edu.ps',
        'major': 'CS',
        'role': 'tutor',
      });
      expect(result['major'], 'CS');
      expect(result['role'], 'tutor');
    });

    test('trims whitespace from name fields before using', () {
      final result = normalizeUserJson({
        'fullName': '  Sara  ',
        'email': 's@ppu.edu.ps',
      });
      expect(result['fullName'], 'Sara');
    });
  });
}
