import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/domain/value_objects/session_duration.dart';

void main() {
  group('SessionDuration.inHours', () {
    test('returns correct hours for 60 minutes', () {
      const sd = SessionDuration(Duration(minutes: 60));
      expect(sd.inHours, 1.0);
    });

    test('returns fractional hours for 90 minutes', () {
      const sd = SessionDuration(Duration(minutes: 90));
      expect(sd.inHours, 1.5);
    });

    test('returns fractional hours for 30 minutes', () {
      const sd = SessionDuration(Duration(minutes: 30));
      expect(sd.inHours, 0.5);
    });

    test('returns 0 for zero duration', () {
      const sd = SessionDuration(Duration.zero);
      expect(sd.inHours, 0.0);
    });
  });

  group('SessionDuration.isValid', () {
    test('returns false for 0 minutes', () {
      expect(const SessionDuration(Duration.zero).isValid, isFalse);
    });

    test('returns false for 29 minutes', () {
      expect(const SessionDuration(Duration(minutes: 29)).isValid, isFalse);
    });

    test('returns true for exactly 30 minutes', () {
      expect(const SessionDuration(Duration(minutes: 30)).isValid, isTrue);
    });

    test('returns true for 60 minutes', () {
      expect(const SessionDuration(Duration(minutes: 60)).isValid, isTrue);
    });

    test('returns true for 180 minutes', () {
      expect(const SessionDuration(Duration(minutes: 180)).isValid, isTrue);
    });
  });

  group('SessionDuration equality', () {
    test('equal durations are equal', () {
      expect(
        const SessionDuration(Duration(minutes: 60)),
        equals(const SessionDuration(Duration(minutes: 60))),
      );
    });

    test('different durations are not equal', () {
      expect(
        const SessionDuration(Duration(minutes: 60)),
        isNot(equals(const SessionDuration(Duration(minutes: 90)))),
      );
    });
  });
}
