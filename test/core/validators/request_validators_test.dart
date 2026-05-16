import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/core/validators/request_validators.dart';

void main() {
  group('RequestMessageValidator.required', () {
    test('returns error when null', () {
      expect(RequestMessageValidator.required(null), 'Message is required');
    });

    test('returns error when empty', () {
      expect(RequestMessageValidator.required(''), 'Message is required');
    });

    test('returns error when only whitespace', () {
      expect(RequestMessageValidator.required('   '), 'Message is required');
    });

    test('returns error when trimmed length is less than 10', () {
      expect(
        RequestMessageValidator.required('Hi there'),
        'Message must be at least 10 characters',
      );
    });

    test('accepts message with exactly 10 trimmed characters', () {
      expect(RequestMessageValidator.required('Hello thre'), isNull);
    });

    test('accepts valid message', () {
      expect(
        RequestMessageValidator.required('Can you help me with calculus?'),
        isNull,
      );
    });

    test('returns error when message exceeds 500 characters', () {
      expect(
        RequestMessageValidator.required('A' * 501),
        'Message must be 500 characters or fewer',
      );
    });

    test('accepts message of exactly 500 characters', () {
      expect(RequestMessageValidator.required('A' * 500), isNull);
    });
  });

  group('RequestSubjectValidator.required', () {
    test('returns error when null', () {
      expect(RequestSubjectValidator.required(null), 'Subject is required');
    });

    test('returns error when empty', () {
      expect(RequestSubjectValidator.required(''), 'Subject is required');
    });

    test('returns error when only whitespace', () {
      expect(RequestSubjectValidator.required('  '), 'Subject is required');
    });

    test('returns error when exceeds 100 characters', () {
      expect(
        RequestSubjectValidator.required('A' * 101),
        'Subject must be 100 characters or fewer',
      );
    });

    test('accepts valid subject', () {
      expect(RequestSubjectValidator.required('Mathematics'), isNull);
    });

    test('accepts subject of exactly 100 characters', () {
      expect(RequestSubjectValidator.required('A' * 100), isNull);
    });
  });

  group('RequestNotesValidator.optional', () {
    test('returns null when null (optional field)', () {
      expect(RequestNotesValidator.optional(null), isNull);
    });

    test('returns null when empty (optional field)', () {
      expect(RequestNotesValidator.optional(''), isNull);
    });

    test('returns null for valid short note', () {
      expect(RequestNotesValidator.optional('Some note'), isNull);
    });

    test('returns null for note of exactly 1000 characters', () {
      expect(RequestNotesValidator.optional('A' * 1000), isNull);
    });

    test('returns error when exceeds 1000 characters', () {
      expect(
        RequestNotesValidator.optional('A' * 1001),
        'Notes must be 1,000 characters or fewer',
      );
    });
  });
}
