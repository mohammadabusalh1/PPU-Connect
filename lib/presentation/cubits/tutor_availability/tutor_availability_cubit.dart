import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/weekly_slot.dart';
import 'package:ppu_connect/domain/repositories/appointment_repository.dart';
import 'package:ppu_connect/domain/repositories/tutor_profile_repository.dart';

part 'tutor_availability_state.dart';

@injectable
class TutorAvailabilityCubit extends Cubit<TutorAvailabilityState> {
  TutorAvailabilityCubit(this._repo, this._appointmentRepo)
      : super(const TutorAvailabilityInitial());

  final TutorProfileRepository _repo;
  final AppointmentRepository _appointmentRepo;

  Future<void> load(String tutorId) async {
    emit(const TutorAvailabilityLoading());
    try {
      final profile = await _repo.getProfile(tutorId);
      if (isClosed) return;
      final slots = profile?.weeklySlots.where((s) => s.isActive).toList() ?? [];

      final now = DateTime.now().toUtc();
      final confirmed = await _appointmentRepo.getConfirmedAppointmentsForTutor(
        tutorId: tutorId,
        from: now,
        to: now.add(const Duration(days: 60)),
      );

      final bookedDates = <String, Set<DateTime>>{};
      for (final appt in confirmed) {
        final apptDate = DateTime(
          appt.startAt.year,
          appt.startAt.month,
          appt.startAt.day,
        );
        for (final slot in slots) {
          if (slot.dayOfWeek != appt.startAt.toLocal().weekday) continue;
          final slotStart = DateTime(
            apptDate.year, apptDate.month, apptDate.day,
            slot.startTime.hour, slot.startTime.minute,
          );
          final slotEnd = DateTime(
            apptDate.year, apptDate.month, apptDate.day,
            slot.endTime.hour, slot.endTime.minute,
          );
          if (appt.startAt.isBefore(slotEnd) && appt.endAt.isAfter(slotStart)) {
            final key =
                '${slot.dayOfWeek}_${slot.startTime.hour}_${slot.startTime.minute}';
            bookedDates.putIfAbsent(key, () => {}).add(apptDate);
          }
        }
      }

      if (isClosed) return;
      emit(TutorAvailabilityLoaded(slots, bookedDates));
    } catch (e) {
      if (isClosed) return;
      emit(TutorAvailabilityError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
