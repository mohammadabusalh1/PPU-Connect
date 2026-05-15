part of 'schedule_cubit.dart';

sealed class ScheduleState {
  const ScheduleState();
}

final class ScheduleInitial extends ScheduleState {
  const ScheduleInitial();
}

final class ScheduleLoading extends ScheduleState {
  const ScheduleLoading();
}

final class ScheduleLoaded extends ScheduleState {
  const ScheduleLoaded({required this.appointments});
  final List<Appointment> appointments;
}

final class ScheduleError extends ScheduleState {
  const ScheduleError(this.message);
  final String message;
}
