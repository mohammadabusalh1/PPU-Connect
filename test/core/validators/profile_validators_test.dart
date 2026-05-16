import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/core/validators/profile_validators.dart';

void main() {
  group('PhoneValidator.e164', () {
    test('returns null when value is null (optional field)', () {
      expect(PhoneValidator.e164(null), isNull);
    });

    test('returns null when value is empty (optional field)', () {
      expect(PhoneValidator.e164(''), isNull);
    });

    test('returns null when value is only whitespace', () {
      expect(PhoneValidator.e164('   '), isNull);
    });

    test('accepts valid E.164 Palestinian number', () {
      expect(PhoneValidator.e164('+970591234567'), isNull);
    });

    test('accepts valid E.164 US number', () {
      expect(PhoneValidator.e164('+12025551234'), isNull);
    });

    test('returns error for number without + prefix', () {
      expect(
        PhoneValidator.e164('970591234567'),
        'Enter a valid phone number (e.g. +970591234567)',
      );
    });

    test('returns error for number starting with +0', () {
      expect(
        PhoneValidator.e164('+0591234567'),
        'Enter a valid phone number (e.g. +970591234567)',
      );
    });

    test('returns error for number that is too short', () {
      expect(
        PhoneValidator.e164('+1234567'),
        'Enter a valid phone number (e.g. +970591234567)',
      );
    });

    test('returns error for number that is too long (15+ digits)', () {
      expect(
        PhoneValidator.e164('+12345678901234567'),
        'Enter a valid phone number (e.g. +970591234567)',
      );
    });

    test('accepts number with whitespace that trims to valid', () {
      expect(PhoneValidator.e164('  +970591234567  '), isNull);
    });
  });

  group('BioValidator.length', () {
    test('returns null when bio is null (optional)', () {
      expect(BioValidator.length(null), isNull);
    });

    test('returns null when bio is empty (optional)', () {
      expect(BioValidator.length(''), isNull);
    });

    test('returns null for bio within limit', () {
      expect(BioValidator.length('Short bio'), isNull);
    });

    test('returns null for bio of exactly 500 characters', () {
      expect(BioValidator.length('A' * 500), isNull);
    });

    test('returns error for bio exceeding 500 characters', () {
      expect(
        BioValidator.length('A' * 501),
        'Bio must be 500 characters or fewer',
      );
    });
  });

  group('HourlyRateValidator.range', () {
    test('returns error when null', () {
      expect(HourlyRateValidator.range(null), 'Hourly rate is required');
    });

    test('returns error when negative', () {
      expect(HourlyRateValidator.range(-1.0), 'Rate cannot be negative');
    });

    test('accepts zero rate', () {
      expect(HourlyRateValidator.range(0.0), isNull);
    });

    test('accepts valid rate', () {
      expect(HourlyRateValidator.range(50.0), isNull);
    });

    test('accepts maximum rate of 10000', () {
      expect(HourlyRateValidator.range(10000.0), isNull);
    });

    test('returns error when rate exceeds 10000', () {
      expect(HourlyRateValidator.range(10001.0), 'Rate must be 10,000 or less');
    });
  });

  group('SubjectsValidator.minOne', () {
    test('returns error for empty list', () {
      expect(SubjectsValidator.minOne([]), 'Add at least one subject');
    });

    test('returns error for list of blank strings', () {
      expect(SubjectsValidator.minOne(['', '  ', '\t']), 'Add at least one subject');
    });

    test('accepts list with one valid subject', () {
      expect(SubjectsValidator.minOne(['Mathematics']), isNull);
    });

    test('accepts list with multiple subjects', () {
      expect(SubjectsValidator.minOne(['Math', 'Physics', 'CS']), isNull);
    });

    test('accepts list with mixed blank and valid', () {
      expect(SubjectsValidator.minOne(['', 'Math']), isNull);
    });
  });
}
