import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/datasources/appointment_remote_data_source.dart';
import 'package:ppu_connect/data/models/appointment_model.dart';
import 'package:ppu_connect/data/models/appointment_request_model.dart';
import 'package:ppu_connect/domain/entities/appointment.dart';
import 'package:ppu_connect/domain/entities/appointment_request.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/repositories/appointment_repository.dart';

@Injectable(as: AppointmentRepository)
class AppointmentRepositoryImpl implements AppointmentRepository {
  const AppointmentRepositoryImpl(this._ds);
  final AppointmentRemoteDataSource _ds;

  @override
  Future<AppointmentRequest> sendRequest(AppointmentRequest request) async {
    final m = await _ds.sendRequest(AppointmentRequestModel.fromEntity(request));
    return m.toEntity();
  }

  @override
  Future<void> acceptRequest(String requestId) =>
      _ds.updateRequestStatus(requestId, RequestStatus.accepted);

  @override
  Future<void> rejectRequest(String requestId, {String? reason}) =>
      _ds.updateRequestStatus(requestId, RequestStatus.rejected, reason: reason);

  @override
  Future<void> cancelRequest(String requestId) =>
      _ds.updateRequestStatus(requestId, RequestStatus.cancelled);

  @override
  Future<AppointmentRequest?> getRequest(String requestId) async {
    final m = await _ds.getRequest(requestId);
    return m?.toEntity();
  }

  @override
  Stream<List<AppointmentRequest>> watchIncomingRequests(String tutorId) =>
      _ds.watchIncomingRequests(tutorId).map((list) => list.map((m) => m.toEntity()).toList());

  @override
  Stream<List<AppointmentRequest>> watchSentRequests(String senderId) =>
      _ds.watchSentRequests(senderId).map((list) => list.map((m) => m.toEntity()).toList());

  @override
  Future<void> cancelAppointment(String appointmentId, {String? reason}) =>
      _ds.cancelAppointment(appointmentId, reason: reason);

  @override
  Stream<List<Appointment>> watchAppointments(String userId) =>
      _ds.watchAppointments(userId).map((list) => list.map((m) => m.toEntity()).toList());

  @override
  Future<Appointment?> getAppointment(String appointmentId) async {
    final m = await _ds.getAppointment(appointmentId);
    return m?.toEntity();
  }
}
