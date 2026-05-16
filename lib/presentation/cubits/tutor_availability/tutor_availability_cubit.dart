import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/tutor_profile.dart';
import 'package:ppu_connect/domain/entities/weekly_slot.dart';
import 'package:ppu_connect/core/utils/session_schedule_utils.dart';
import 'package:ppu_connect/core/validators/scheduling_validators.dart';
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
      if (profile == null) {
        emit(const TutorAvailabilityError('Tutor profile not found'));
        return;
      }
      final slots = profile.weeklySlots
          .where(
            (s) => s.isActive && WeeklySlotValidator.validateSlot(s) == null,
          )
          .toList();

      final now = DateTime.now().toUtc();
      final confirmed = await _appointmentRepo.getConfirmedAppointmentsForTutor(
        tutorId: tutorId,
        from: now,
        to: now.add(const Duration(days: 60)),
      );

      final bookedDates = <String, Set<DateTime>>{};
      for (final appt in confirmed) {
        final apptStartLocal = appt.startAt.toLocal();
        final apptEndLocal = appt.endAt.toLocal();
        final apptDate = DateTime(
          apptStartLocal.year,
          apptStartLocal.month,
          apptStartLocal.day,
        );
        for (final slot in slots) {
          if (slot.dayOfWeek != apptStartLocal.weekday) continue;
          final slotStart = sessionStartOnDate(apptDate, slot.startTime);
          final slotEnd = sessionEndOnDate(
            apptDate,
            slot.startTime,
            slot.endTime,
          );
          if (apptStartLocal.isBefore(slotEnd) &&
              apptEndLocal.isAfter(slotStart)) {
            final key =
                '${slot.dayOfWeek}_${slot.startTime.hour}_${slot.startTime.minute}';
            bookedDates.putIfAbsent(key, () => {}).add(apptDate);
          }
        }
      }

      if (isClosed) return;
      emit(TutorAvailabilityLoaded(slots, bookedDates, profile));
    } catch (e) {
      if (isClosed) return;
      emit(TutorAvailabilityError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
