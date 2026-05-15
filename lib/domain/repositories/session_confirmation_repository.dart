import 'package:ppu_connect/domain/entities/session_confirmation.dart';

abstract interface class SessionConfirmationRepository {
  Future<SessionConfirmation?> getForAppointment(String appointmentId);
  Future<void> confirmAttendance(String appointmentId, String userId);
  Future<void> reportNoShow(String appointmentId, String reporterId);
  Stream<SessionConfirmation?> watchForAppointment(String appointmentId);
}
