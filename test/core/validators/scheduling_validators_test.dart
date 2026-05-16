import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/core/validators/scheduling_validators.dart';

void main() {
  group('SessionDurationValidator.valid', () {
    test('returns error when null', () {
      expect(SessionDurationValidator.valid(null), 'Duration is required');
    });

    test('returns error when below minimum of 30 minutes', () {
      expect(
        SessionDurationValidator.valid(29),
        'Minimum session is 30 minutes',
      );
    });

    test('returns error when above maximum of 180 minutes', () {
      expect(
        SessionDurationValidator.valid(181),
        'Maximum session is 180 minutes',
      );
    });

    test('returns error when not a 15-minute increment', () {
      expect(
        SessionDurationValidator.valid(35),
        'Duration must be in 15-minute increments',
      );
    });

    test('accepts minimum valid duration of 30 minutes', () {
      expect(SessionDurationValidator.valid(30), isNull);
    });

    test('accepts 45 minutes', () {
      expect(SessionDurationValidator.valid(45), isNull);
    });

    test('accepts 60 minutes', () {
      expect(SessionDurationValidator.valid(60), isNull);
    });

    test('accepts maximum valid duration of 180 minutes', () {
      expect(SessionDurationValidator.valid(180), isNull);
    });

    test('returns error for 15 minutes (below minimum, but valid increment)', () {
      expect(
        SessionDurationValidator.valid(15),
        'Minimum session is 30 minutes',
      );
    });
  });

  group('SlotTimeValidator.notInPast', () {
    test('returns error when null', () {
      expect(SlotTimeValidator.notInPast(null), 'Time is required');
    });

    test('returns error for a past datetime', () {
      final past = DateTime.now().subtract(const Duration(hours: 1));
      expect(SlotTimeValidator.notInPast(past), 'Slot cannot be in the past');
    });

    test('returns null for a future datetime', () {
      final future = DateTime.now().add(const Duration(hours: 1));
      expect(SlotTimeValidator.notInPast(future), isNull);
    });
  });

  group('SlotTimeValidator.endAfterStart', () {
    test('returns null when both are null', () {
      expect(SlotTimeValidator.endAfterStart(null, null), isNull);
    });

    test('returns null when start is null', () {
      expect(
        SlotTimeValidator.endAfterStart(null, DateTime.now()),
        isNull,
      );
    });

    test('returns null when end is null', () {
      expect(
        SlotTimeValidator.endAfterStart(DateTime.now(), null),
        isNull,
      );
    });

    test('returns error when end equals start', () {
      final dt = DateTime(2030, 1, 1, 10, 0);
      expect(
        SlotTimeValidator.endAfterStart(dt, dt),
        'End time must be after start time',
      );
    });

    test('returns error when end is before start', () {
      final start = DateTime(2030, 1, 1, 11, 0);
      final end = DateTime(2030, 1, 1, 10, 0);
      expect(
        SlotTimeValidator.endAfterStart(start, end),
        'End time must be after start time',
      );
    });

    test('returns error when slot is less than 30 minutes', () {
      final start = DateTime(2030, 1, 1, 10, 0);
      final end = DateTime(2030, 1, 1, 10, 29);
      expect(
        SlotTimeValidator.endAfterStart(start, end),
        'Slot must be at least 30 minutes',
      );
    });

    test('returns error when slot exceeds 3 hours', () {
      final start = DateTime(2030, 1, 1, 10, 0);
      final end = DateTime(2030, 1, 1, 13, 1);
      expect(
        SlotTimeValidator.endAfterStart(start, end),
        'Slot cannot exceed 3 hours',
      );
    });

    test('accepts valid slot of exactly 30 minutes', () {
      final start = DateTime(2030, 1, 1, 10, 0);
      final end = DateTime(2030, 1, 1, 10, 30);
      expect(SlotTimeValidator.endAfterStart(start, end), isNull);
    });

    test('accepts valid slot of exactly 3 hours', () {
      final start = DateTime(2030, 1, 1, 10, 0);
      final end = DateTime(2030, 1, 1, 13, 0);
      expect(SlotTimeValidator.endAfterStart(start, end), isNull);
    });
  });

  group('WeeklySlotCountValidator.maxPerDay', () {
    test('returns null when count is 0', () {
      expect(WeeklySlotCountValidator.maxPerDay(0), isNull);
    });

    test('returns null when count equals max of 8', () {
      expect(WeeklySlotCountValidator.maxPerDay(8), isNull);
    });

    test('returns error when count exceeds 8', () {
      expect(
        WeeklySlotCountValidator.maxPerDay(9),
        'Maximum 8 slots per day',
      );
    });
  });

  group('BookingNoticeValidator.sufficientNotice', () {
    test('returns null when slotStart is null', () {
      expect(BookingNoticeValidator.sufficientNotice(null), isNull);
    });

    test('returns error when slot starts in less than 1 hour', () {
      final soon = DateTime.now().add(const Duration(minutes: 30));
      expect(
        BookingNoticeValidator.sufficientNotice(soon),
        'Must book at least 1 hour before the session',
      );
    });

    test('returns null when slot starts in more than 1 hour', () {
      final later = DateTime.now().add(const Duration(hours: 2));
      expect(BookingNoticeValidator.sufficientNotice(later), isNull);
    });
  });
}
