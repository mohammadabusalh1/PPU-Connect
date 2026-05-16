import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/core/validators/academic_validators.dart';

void main() {
  group('GpaValidator.range', () {
    test('returns null when GPA is null (optional)', () {
      expect(GpaValidator.range(null), isNull);
    });

    test('returns null for GPA of 0.0', () {
      expect(GpaValidator.range(0.0), isNull);
    });

    test('returns null for GPA of 4.0', () {
      expect(GpaValidator.range(4.0), isNull);
    });

    test('returns null for GPA within range', () {
      expect(GpaValidator.range(3.5), isNull);
    });

    test('returns error for negative GPA', () {
      expect(GpaValidator.range(-0.1), 'GPA must be between 0.0 and 4.0');
    });

    test('returns error for GPA above 4.0', () {
      expect(GpaValidator.range(4.1), 'GPA must be between 0.0 and 4.0');
    });
  });

  group('MajorValidator.required', () {
    test('returns error when null', () {
      expect(MajorValidator.required(null), 'Major is required');
    });

    test('returns error when empty', () {
      expect(MajorValidator.required(''), 'Major is required');
    });

    test('returns error when only whitespace', () {
      expect(MajorValidator.required('   '), 'Major is required');
    });

    test('returns error when exceeds 100 characters', () {
      expect(
        MajorValidator.required('A' * 101),
        'Major must be 100 characters or fewer',
      );
    });

    test('accepts valid major name', () {
      expect(MajorValidator.required('Computer Science'), isNull);
    });

    test('accepts major of exactly 100 characters', () {
      expect(MajorValidator.required('A' * 100), isNull);
    });

    test('accepts major with leading/trailing spaces (trims for check)', () {
      expect(MajorValidator.required('  CS  '), isNull);
    });
  });
}
