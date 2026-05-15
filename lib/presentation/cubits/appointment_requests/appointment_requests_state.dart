part of 'appointment_requests_cubit.dart';

sealed class AppointmentRequestsState {
  const AppointmentRequestsState();
}

final class AppointmentRequestsInitial extends AppointmentRequestsState {
  const AppointmentRequestsInitial();
}

final class AppointmentRequestsLoading extends AppointmentRequestsState {
  const AppointmentRequestsLoading();
}

final class AppointmentRequestsLoaded extends AppointmentRequestsState {
  const AppointmentRequestsLoaded({required this.requests});
  final List<AppointmentRequest> requests;
}

final class AppointmentRequestsError extends AppointmentRequestsState {
  const AppointmentRequestsError(this.message);
  final String message;
}
