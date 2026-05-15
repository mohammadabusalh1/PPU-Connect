import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/appointment.dart';
import 'package:ppu_connect/domain/repositories/appointment_repository.dart';

part 'schedule_state.dart';

@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit(this._repo) : super(const ScheduleInitial());
  final AppointmentRepository _repo;
  StreamSubscription<List<Appointment>>? _sub;

  void watch(String userId) {
    _sub?.cancel();
    emit(const ScheduleLoading());
    _sub = _repo.watchAppointments(userId).listen(
      (appointments) {
        if (isClosed) return;
        emit(ScheduleLoaded(appointments: appointments));
      },
      onError: (e) {
        if (isClosed) return;
        emit(ScheduleError(e.toString().replaceFirst('Exception: ', '')));
      },
    );
  }

  Future<void> cancel(String appointmentId, {String? reason}) async {
    try {
      await _repo.cancelAppointment(appointmentId, reason: reason);
    } catch (e) {
      if (isClosed) return;
      emit(ScheduleError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
