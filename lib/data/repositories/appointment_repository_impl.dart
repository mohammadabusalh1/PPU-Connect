import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/datasources/appointment_remote_data_source.dart';
import 'package:ppu_connect/data/datasources/notification_remote_data_source.dart';
import 'package:ppu_connect/data/models/app_notification_model.dart';
import 'package:ppu_connect/data/models/appointment_model.dart';
import 'package:ppu_connect/data/models/appointment_request_model.dart';
import 'package:ppu_connect/domain/entities/appointment.dart';
import 'package:ppu_connect/domain/entities/appointment_request.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/repositories/appointment_repository.dart';
import 'package:ppu_connect/domain/repositories/tutor_profile_repository.dart';

@Injectable(as: AppointmentRepository)
class AppointmentRepositoryImpl implements AppointmentRepository {
  const AppointmentRepositoryImpl(this._ds, this._tutorProfiles, this._notifs);
  final AppointmentRemoteDataSource _ds;
  final TutorProfileRepository _tutorProfiles;
  final NotificationRemoteDataSource _notifs;

  @override
  Future<AppointmentRequest> sendRequest(AppointmentRequest request) async {
    final compositeId =
        '${request.seekerId}_${request.tutorId}_'
        '${request.proposedStartAt.toUtc().millisecondsSinceEpoch}';
    final dayStart = DateTime.utc(
      request.proposedStartAt.year,
      request.proposedStartAt.month,
      request.proposedStartAt.day,
    );
    final duplicate = await _ds.hasPendingOrAcceptedRequest(
      seekerId: request.seekerId,
      tutorId: request.tutorId,
      dayStart: dayStart,
      dayEnd: dayStart.add(const Duration(days: 1)),
      proposedStartAt: request.proposedStartAt.toUtc(),
      proposedEndAt: request.proposedEndAt.toUtc(),
    );
    if (duplicate) {
      throw Exception('You already have a pending request for this time slot');
    }
    final m = await _ds.sendRequest(
      AppointmentRequestModel.fromEntity(request.copyWith(id: compositeId)),
    );
    final saved = m.toEntity();
    await _notifs.createNotification(AppNotificationModel(
      id: '',
      userId: saved.receiverId,
      type: NotificationType.appointmentRequest,
      title: 'New Session Request',
      body: '${saved.senderName} wants to book a session for ${saved.subject}',
      payload: {'requestId': saved.id},
      isRead: false,
      createdAt: DateTime.now().toUtc(),
    ));
    return saved;
  }

  @override
  Future<void> acceptRequest(String requestId) async {
    final request = await _ds.getRequest(requestId);
    if (request == null) throw Exception('Request not found');

    final profile = await _tutorProfiles.getProfile(request.tutorId);
    if (profile == null) throw Exception('Tutor profile not found');

    await _ds.acceptAppointmentRequest(
      request: request,
      hourlyRate: profile.hourlyRate,
      currency: profile.currency,
    );
    await _notifs.createNotification(AppNotificationModel(
      id: '',
      userId: request.seekerId,
      type: NotificationType.appointmentConfirmed,
      title: 'Request Accepted',
      body: 'Your session request for ${request.subject} has been accepted',
      payload: {'requestId': requestId},
      isRead: false,
      createdAt: DateTime.now().toUtc(),
    ));
  }

  @override
  Future<void> rejectRequest(String requestId, {String? reason}) async {
    final request = await _ds.getRequest(requestId);
    await _ds.updateRequestStatus(requestId, RequestStatus.rejected, reason: reason);
    if (request != null) {
      await _notifs.createNotification(AppNotificationModel(
        id: '',
        userId: request.seekerId,
        type: NotificationType.appointmentCancelled,
        title: 'Request Declined',
        body: 'Your session request for ${request.subject} has been declined',
        payload: {'requestId': requestId},
        isRead: false,
        createdAt: DateTime.now().toUtc(),
      ));
    }
  }

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

  @override
  Future<List<Appointment>> getConfirmedAppointmentsForTutor({
    required String tutorId,
    required DateTime from,
    required DateTime to,
  }) async {
    final models = await _ds.getConfirmedAppointmentsForTutor(
      tutorId: tutorId,
      from: from,
      to: to,
    );
    return models.map((m) => m.toEntity()).toList();
  }
}
