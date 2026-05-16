part of 'tutor_availability_cubit.dart';

sealed class TutorAvailabilityState {
  const TutorAvailabilityState();
}

class TutorAvailabilityInitial extends TutorAvailabilityState {
  const TutorAvailabilityInitial();
}

class TutorAvailabilityLoading extends TutorAvailabilityState {
  const TutorAvailabilityLoading();
}

class TutorAvailabilityLoaded extends TutorAvailabilityState {
  const TutorAvailabilityLoaded(this.slots, this.bookedDates, this.tutorProfile);
  final List<WeeklySlot> slots;
  final TutorProfile tutorProfile;

  /// Key: '${slot.dayOfWeek}_${slot.startTime.hour}_${slot.startTime.minute}'
  /// Value: set of date-only DateTimes (year/month/day) that are fully booked.
  final Map<String, Set<DateTime>> bookedDates;

  bool isSlotBookedOnDate(WeeklySlot slot, DateTime date) {
    final key =
        '${slot.dayOfWeek}_${slot.startTime.hour}_${slot.startTime.minute}';
    final dateOnly = DateTime(date.year, date.month, date.day);
    return bookedDates[key]?.contains(dateOnly) ?? false;
  }
}

class TutorAvailabilityError extends TutorAvailabilityState {
  const TutorAvailabilityError(this.message);
  final String message;
}
