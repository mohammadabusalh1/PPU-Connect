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
