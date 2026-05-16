import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/core/validators/review_validators.dart';

void main() {
  group('RatingValidator.required', () {
    test('returns error when null', () {
      expect(RatingValidator.required(null), 'Rating is required');
    });

    test('returns error when below 1', () {
      expect(RatingValidator.required(0.9), 'Rating must be between 1 and 5');
    });

    test('returns error when above 5', () {
      expect(RatingValidator.required(5.1), 'Rating must be between 1 and 5');
    });

    test('accepts minimum rating of 1', () {
      expect(RatingValidator.required(1.0), isNull);
    });

    test('accepts maximum rating of 5', () {
      expect(RatingValidator.required(5.0), isNull);
    });

    test('accepts mid-range rating', () {
      expect(RatingValidator.required(3.5), isNull);
    });

    test('returns error for 0', () {
      expect(RatingValidator.required(0.0), 'Rating must be between 1 and 5');
    });
  });

  group('ReviewCommentValidator.optional', () {
    test('returns null when null (optional)', () {
      expect(ReviewCommentValidator.optional(null), isNull);
    });

    test('returns null when empty (optional)', () {
      expect(ReviewCommentValidator.optional(''), isNull);
    });

    test('returns error when trimmed length < 10', () {
      expect(
        ReviewCommentValidator.optional('Short'),
        'Comment must be at least 10 characters',
      );
    });

    test('accepts comment with exactly 10 trimmed characters', () {
      expect(ReviewCommentValidator.optional('1234567890'), isNull);
    });

    test('returns error when exceeds 1000 characters', () {
      expect(
        ReviewCommentValidator.optional('A' * 1001),
        'Comment must be 1,000 characters or fewer',
      );
    });

    test('accepts comment of exactly 1000 characters', () {
      expect(ReviewCommentValidator.optional('A' * 1000), isNull);
    });

    test('accepts valid comment', () {
      expect(ReviewCommentValidator.optional('Great tutor!'), isNull);
    });
  });

  group('ReviewCommentValidator.required', () {
    test('returns error when null', () {
      expect(ReviewCommentValidator.required(null), 'Comment is required');
    });

    test('returns error when empty', () {
      expect(ReviewCommentValidator.required(''), 'Comment is required');
    });

    test('returns error when only whitespace', () {
      expect(ReviewCommentValidator.required('   '), 'Comment is required');
    });

    test('returns error when trimmed length < 10', () {
      expect(
        ReviewCommentValidator.required('Short'),
        'Comment must be at least 10 characters',
      );
    });

    test('returns error when exceeds 1000 characters', () {
      expect(
        ReviewCommentValidator.required('A' * 1001),
        'Comment must be 1,000 characters or fewer',
      );
    });

    test('accepts valid comment', () {
      expect(ReviewCommentValidator.required('Excellent teaching!'), isNull);
    });
  });
}
