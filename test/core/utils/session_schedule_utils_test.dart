import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/core/utils/session_schedule_utils.dart';
import 'package:ppu_connect/domain/value_objects/app_time_of_day.dart';

void main() {
  const morning = AppTimeOfDay(hour: 10, minute: 0);
  const noon = AppTimeOfDay(hour: 12, minute: 0);
  const lateNight = AppTimeOfDay(hour: 22, minute: 0);
  const midnight = AppTimeOfDay(hour: 0, minute: 0);

  test('sessionEndOnDate keeps same-day end when after start', () {
    final date = DateTime(2030, 6, 15);
    final start = sessionStartOnDate(date, morning);
    final end = sessionEndOnDate(date, morning, noon);
    expect(end.isAfter(start), isTrue);
    expect(end.day, start.day);
    expect(end.hour, 12);
  });

  test('sessionEndOnDate rolls to next day for overnight slots', () {
    final date = DateTime(2030, 6, 15);
    final start = sessionStartOnDate(date, lateNight);
    final end = sessionEndOnDate(date, lateNight, midnight);
    expect(end.isAfter(start), isTrue);
    expect(end.day, 16);
    expect(end.hour, 0);
  });

  test('normalizeCalendarDate uses local calendar components', () {
    final utcMidnight = DateTime.utc(2030, 6, 15);
    final normalized = normalizeCalendarDate(utcMidnight);
    expect(normalized.hour, 0);
    expect(normalized.minute, 0);
    expect(normalized.second, 0);
  });
}
