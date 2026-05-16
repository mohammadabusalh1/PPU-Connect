import 'package:ppu_connect/domain/value_objects/app_time_of_day.dart';

/// Calendar date in the device's local timezone (no time-of-day).
DateTime normalizeCalendarDate(DateTime date) {
  final local = date.toLocal();
  return DateTime(local.year, local.month, local.day);
}

/// Session start on [date] using [time] (local).
DateTime sessionStartOnDate(DateTime date, AppTimeOfDay time) {
  final day = normalizeCalendarDate(date);
  return DateTime(day.year, day.month, day.day, time.hour, time.minute);
}

/// Session end on [date], rolling to the next calendar day when [end] is not
/// after [start] on the clock (e.g. 22:00–00:00).
DateTime sessionEndOnDate(
  DateTime date,
  AppTimeOfDay start,
  AppTimeOfDay end,
) {
  final startDt = sessionStartOnDate(date, start);
  var endDt = sessionStartOnDate(date, end);
  if (!endDt.isAfter(startDt)) {
    endDt = endDt.add(const Duration(days: 1));
  }
  return endDt;
}
