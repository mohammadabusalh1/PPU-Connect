import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/core/validators/report_validators.dart';

void main() {
  group('ReportReasonValidator.required', () {
    test('returns error when null', () {
      expect(ReportReasonValidator.required(null), 'Reason is required');
    });

    test('returns error when empty', () {
      expect(ReportReasonValidator.required(''), 'Reason is required');
    });

    test('returns error when only whitespace', () {
      expect(ReportReasonValidator.required('   '), 'Reason is required');
    });

    test('returns error for unrecognized reason', () {
      expect(ReportReasonValidator.required('spam'), 'Select a valid reason');
    });

    test('accepts no_show', () {
      expect(ReportReasonValidator.required('no_show'), isNull);
    });

    test('accepts inappropriate_behavior', () {
      expect(ReportReasonValidator.required('inappropriate_behavior'), isNull);
    });

    test('accepts payment_dispute', () {
      expect(ReportReasonValidator.required('payment_dispute'), isNull);
    });

    test('accepts quality_issue', () {
      expect(ReportReasonValidator.required('quality_issue'), isNull);
    });

    test('accepts other', () {
      expect(ReportReasonValidator.required('other'), isNull);
    });
  });

  group('ReportDescriptionValidator.required', () {
    test('returns error when null', () {
      expect(ReportDescriptionValidator.required(null), 'Description is required');
    });

    test('returns error when empty', () {
      expect(ReportDescriptionValidator.required(''), 'Description is required');
    });

    test('returns error when only whitespace', () {
      expect(ReportDescriptionValidator.required('   '), 'Description is required');
    });

    test('returns error when trimmed length < 20', () {
      expect(
        ReportDescriptionValidator.required('Too short'),
        'Provide at least 20 characters of detail',
      );
    });

    test('accepts description with exactly 20 trimmed characters', () {
      expect(
        ReportDescriptionValidator.required('A' * 20),
        isNull,
      );
    });

    test('accepts valid description', () {
      expect(
        ReportDescriptionValidator.required('The tutor did not show up for the session at all.'),
        isNull,
      );
    });

    test('returns error when exceeds 2000 characters', () {
      expect(
        ReportDescriptionValidator.required('A' * 2001),
        'Description must be 2,000 characters or fewer',
      );
    });

    test('accepts description of exactly 2000 characters', () {
      expect(ReportDescriptionValidator.required('A' * 2000), isNull);
    });
  });
}
