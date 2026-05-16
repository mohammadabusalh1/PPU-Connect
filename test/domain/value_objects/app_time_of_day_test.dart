import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/domain/value_objects/app_time_of_day.dart';

void main() {
  group('AppTimeOfDay construction', () {
    test('creates valid time', () {
      const t = AppTimeOfDay(hour: 9, minute: 30);
      expect(t.hour, 9);
      expect(t.minute, 30);
    });

    test('creates midnight (0:00)', () {
      const t = AppTimeOfDay(hour: 0, minute: 0);
      expect(t.hour, 0);
      expect(t.minute, 0);
    });

    test('creates last valid time (23:59)', () {
      const t = AppTimeOfDay(hour: 23, minute: 59);
      expect(t.hour, 23);
      expect(t.minute, 59);
    });

    test('asserts on invalid hour', () {
      expect(
        () => AppTimeOfDay(hour: 24, minute: 0),
        throwsA(isA<AssertionError>()),
      );
    });

    test('asserts on negative hour', () {
      expect(
        () => AppTimeOfDay(hour: -1, minute: 0),
        throwsA(isA<AssertionError>()),
      );
    });

    test('asserts on invalid minute', () {
      expect(
        () => AppTimeOfDay(hour: 10, minute: 60),
        throwsA(isA<AssertionError>()),
      );
    });

    test('asserts on negative minute', () {
      expect(
        () => AppTimeOfDay(hour: 10, minute: -1),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('AppTimeOfDay.totalMinutes', () {
    test('calculates total minutes correctly', () {
      const t = AppTimeOfDay(hour: 2, minute: 30);
      expect(t.totalMinutes, 150);
    });

    test('midnight has 0 total minutes', () {
      const t = AppTimeOfDay(hour: 0, minute: 0);
      expect(t.totalMinutes, 0);
    });

    test('23:59 has correct total minutes', () {
      const t = AppTimeOfDay(hour: 23, minute: 59);
      expect(t.totalMinutes, 23 * 60 + 59);
    });
  });

  group('AppTimeOfDay comparisons', () {
    const earlier = AppTimeOfDay(hour: 8, minute: 0);
    const later = AppTimeOfDay(hour: 10, minute: 0);
    const same = AppTimeOfDay(hour: 8, minute: 0);

    test('isAfter returns true when later', () {
      expect(later.isAfter(earlier), isTrue);
    });

    test('isAfter returns false when equal', () {
      expect(earlier.isAfter(same), isFalse);
    });

    test('isAfter returns false when earlier', () {
      expect(earlier.isAfter(later), isFalse);
    });

    test('isBefore returns true when earlier', () {
      expect(earlier.isBefore(later), isTrue);
    });

    test('isBefore returns false when equal', () {
      expect(earlier.isBefore(same), isFalse);
    });

    test('isAtOrAfter returns true when equal', () {
      expect(earlier.isAtOrAfter(same), isTrue);
    });

    test('isAtOrAfter returns true when later', () {
      expect(later.isAtOrAfter(earlier), isTrue);
    });

    test('isAtOrAfter returns false when earlier', () {
      expect(earlier.isAtOrAfter(later), isFalse);
    });

    test('isAtOrBefore returns true when equal', () {
      expect(earlier.isAtOrBefore(same), isTrue);
    });

    test('isAtOrBefore returns true when earlier', () {
      expect(earlier.isAtOrBefore(later), isTrue);
    });

    test('isAtOrBefore returns false when later', () {
      expect(later.isAtOrBefore(earlier), isFalse);
    });
  });

  group('AppTimeOfDay.difference', () {
    test('calculates positive difference', () {
      const start = AppTimeOfDay(hour: 8, minute: 0);
      const end = AppTimeOfDay(hour: 10, minute: 30);
      expect(end.difference(start), const Duration(minutes: 150));
    });

    test('calculates zero difference for same time', () {
      const t = AppTimeOfDay(hour: 9, minute: 0);
      expect(t.difference(t), Duration.zero);
    });

    test('calculates negative difference when earlier minus later', () {
      const early = AppTimeOfDay(hour: 8, minute: 0);
      const late_ = AppTimeOfDay(hour: 10, minute: 0);
      expect(early.difference(late_), const Duration(minutes: -120));
    });
  });

  group('AppTimeOfDay equality', () {
    test('equal times are equal', () {
      expect(
        const AppTimeOfDay(hour: 9, minute: 0),
        equals(const AppTimeOfDay(hour: 9, minute: 0)),
      );
    });

    test('different times are not equal', () {
      expect(
        const AppTimeOfDay(hour: 9, minute: 0),
        isNot(equals(const AppTimeOfDay(hour: 9, minute: 1))),
      );
    });
  });

  group('AppTimeOfDay.toString', () {
    test('pads single-digit hour and minute', () {
      expect(const AppTimeOfDay(hour: 9, minute: 5).toString(), '09:05');
    });

    test('formats midnight correctly', () {
      expect(const AppTimeOfDay(hour: 0, minute: 0).toString(), '00:00');
    });

    test('formats 23:59 correctly', () {
      expect(const AppTimeOfDay(hour: 23, minute: 59).toString(), '23:59');
    });
  });
}
