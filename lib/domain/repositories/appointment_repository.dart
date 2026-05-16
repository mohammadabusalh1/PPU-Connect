import 'package:ppu_connect/domain/entities/appointment.dart';
import 'package:ppu_connect/domain/entities/appointment_request.dart';

abstract interface class AppointmentRepository {
  // Requests
  Future<AppointmentRequest> sendRequest(AppointmentRequest request);
  Future<void> acceptRequest(String requestId);
  Future<void> rejectRequest(String requestId, {String? reason});
  Future<void> cancelRequest(String requestId);
  Future<AppointmentRequest?> getRequest(String requestId);
  Stream<List<AppointmentRequest>> watchIncomingRequests(String tutorId);
  Stream<List<AppointmentRequest>> watchSentRequests(String senderId);
  // Appointments
  Future<void> cancelAppointment(String appointmentId, {String? reason});
  Stream<List<Appointment>> watchAppointments(String userId);
  Future<Appointment?> getAppointment(String appointmentId);
  Future<List<Appointment>> getConfirmedAppointmentsForTutor({
    required String tutorId,
    required DateTime from,
    required DateTime to,
  });
}
