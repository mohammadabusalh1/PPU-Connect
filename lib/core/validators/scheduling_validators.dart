import 'package:ppu_connect/domain/entities/weekly_slot.dart';
import 'package:ppu_connect/domain/value_objects/app_time_of_day.dart';

abstract final class SessionDurationValidator {
  static const _minMinutes = 30;
  static const _maxMinutes = 180;

  static String? valid(int? minutes) {
    if (minutes == null) return 'Duration is required';
    if (minutes < _minMinutes) return 'Minimum session is $_minMinutes minutes';
    if (minutes > _maxMinutes) return 'Maximum session is $_maxMinutes minutes';
    if (minutes % 15 != 0) return 'Duration must be in 15-minute increments';
    return null;
  }
}

abstract final class SlotTimeValidator {
  static String? notInPast(DateTime? dt) {
    if (dt == null) return 'Time is required';
    if (dt.isBefore(DateTime.now())) return 'Slot cannot be in the past';
    return null;
  }

  static String? endAfterStart(DateTime? start, DateTime? end) {
    if (start == null || end == null) return null;
    if (!end.isAfter(start)) return 'End time must be after start time';
    final diff = end.difference(start).inMinutes;
    if (diff < 30) return 'Slot must be at least 30 minutes';
    if (diff > 180) return 'Slot cannot exceed 3 hours';
    return null;
  }
}

abstract final class WeeklySlotCountValidator {
  static const _maxSlotsPerDay = 8;

  static String? maxPerDay(int count) {
    if (count > _maxSlotsPerDay) {
      return 'Maximum $_maxSlotsPerDay slots per day';
    }
    return null;
  }
}

/// Rules for tutor weekly availability (same calendar day only — no overnight).
abstract final class WeeklySlotValidator {
  static const _minMinutes = 30;
  static const _maxMinutes = 180;
  static const _quarterStep = 15;

  static String? validateTimes(AppTimeOfDay start, AppTimeOfDay end) {
    final stepsError = _quarterHourSteps(start, end);
    if (stepsError != null) return stepsError;

    if (!end.isAfter(start)) {
      return 'End time must be after start time on the same day';
    }

    final durationMinutes = end.totalMinutes - start.totalMinutes;
    if (durationMinutes < _minMinutes) {
      return 'Slot must be at least $_minMinutes minutes';
    }
    if (durationMinutes > _maxMinutes) {
      return 'Slot cannot exceed 3 hours';
    }
    return null;
  }

  static String? validateSlot(WeeklySlot slot) {
    if (slot.dayOfWeek < 1 || slot.dayOfWeek > 7) {
      return 'Invalid day of week';
    }
    return validateTimes(slot.startTime, slot.endTime);
  }

  static bool overlaps(WeeklySlot a, WeeklySlot b) {
    if (a.dayOfWeek != b.dayOfWeek) return false;
    return a.startTime.isBefore(b.endTime) && b.startTime.isBefore(a.endTime);
  }

  static String? _quarterHourSteps(AppTimeOfDay start, AppTimeOfDay end) {
    if (start.minute % _quarterStep != 0 || end.minute % _quarterStep != 0) {
      return 'Use 15-minute steps (e.g. 10:00, 10:15, 10:30, 10:45)';
    }
    return null;
  }
}

abstract final class BookingNoticeValidator {
  static const _minNoticeHours = 1;

  static String? sufficientNotice(DateTime? slotStart) {
    if (slotStart == null) return null;
    final notice = slotStart.difference(DateTime.now());
    if (notice.inHours < _minNoticeHours) {
      return 'Must book at least $_minNoticeHours hour before the session';
    }
    return null;
  }
}
