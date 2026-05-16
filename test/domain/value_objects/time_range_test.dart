import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/domain/value_objects/app_time_of_day.dart';
import 'package:ppu_connect/domain/value_objects/time_range.dart';

void main() {
  const t8 = AppTimeOfDay(hour: 8, minute: 0);
  const t9 = AppTimeOfDay(hour: 9, minute: 0);
  const t10 = AppTimeOfDay(hour: 10, minute: 0);
  const t11 = AppTimeOfDay(hour: 11, minute: 0);
  const t12 = AppTimeOfDay(hour: 12, minute: 0);

  group('TimeRange.duration', () {
    test('calculates duration of a 2-hour range', () {
      const range = TimeRange(start: t8, end: t10);
      expect(range.duration, const Duration(hours: 2));
    });

    test('calculates duration of a 30-minute range', () {
      const t830 = AppTimeOfDay(hour: 8, minute: 30);
      const range = TimeRange(start: t8, end: t830);
      expect(range.duration, const Duration(minutes: 30));
    });
  });

  group('TimeRange.overlaps', () {
    test('ranges that share a middle segment overlap', () {
      const range1 = TimeRange(start: t8, end: t10);
      const range2 = TimeRange(start: t9, end: t11);
      expect(range1.overlaps(range2), isTrue);
      expect(range2.overlaps(range1), isTrue);
    });

    test('ranges that are adjacent (end == start) do not overlap', () {
      const range1 = TimeRange(start: t8, end: t9);
      const range2 = TimeRange(start: t9, end: t10);
      expect(range1.overlaps(range2), isFalse);
      expect(range2.overlaps(range1), isFalse);
    });

    test('ranges that do not touch do not overlap', () {
      const range1 = TimeRange(start: t8, end: t9);
      const range2 = TimeRange(start: t10, end: t11);
      expect(range1.overlaps(range2), isFalse);
    });

    test('identical ranges overlap', () {
      const range = TimeRange(start: t9, end: t11);
      expect(range.overlaps(range), isTrue);
    });

    test('range fully contained within another overlaps', () {
      const outer = TimeRange(start: t8, end: t12);
      const inner = TimeRange(start: t9, end: t11);
      expect(outer.overlaps(inner), isTrue);
      expect(inner.overlaps(outer), isTrue);
    });
  });

  group('TimeRange equality', () {
    test('equal ranges are equal', () {
      expect(
        const TimeRange(start: t8, end: t10),
        equals(const TimeRange(start: t8, end: t10)),
      );
    });

    test('ranges with different start are not equal', () {
      expect(
        const TimeRange(start: t8, end: t10),
        isNot(equals(const TimeRange(start: t9, end: t10))),
      );
    });

    test('ranges with different end are not equal', () {
      expect(
        const TimeRange(start: t8, end: t10),
        isNot(equals(const TimeRange(start: t8, end: t11))),
      );
    });
  });
}
