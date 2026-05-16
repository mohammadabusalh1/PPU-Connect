import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/datasources/appointment_remote_data_source.dart';
import 'package:ppu_connect/data/models/appointment_model.dart';
import 'package:ppu_connect/domain/entities/app_notification.dart';
import 'package:ppu_connect/data/models/appointment_request_model.dart';
import 'package:ppu_connect/domain/entities/appointment.dart';
import 'package:ppu_connect/domain/entities/appointment_request.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/repositories/appointment_repository.dart';
import 'package:ppu_connect/domain/repositories/notification_repository.dart';
import 'package:ppu_connect/domain/repositories/tutor_profile_repository.dart';
import 'package:ppu_connect/domain/repositories/user_repository.dart';
import 'package:ppu_connect/domain/validators/appointment_request_rules.dart';

@Injectable(as: AppointmentRepository)
class AppointmentRepositoryImpl implements AppointmentRepository {
  const AppointmentRepositoryImpl(
    this._ds,
    this._tutorProfiles,
    this._users,
    this._notifications,
  );

  final AppointmentRemoteDataSource _ds;
  final TutorProfileRepository _tutorProfiles;
  final UserRepository _users;
  final NotificationRepository _notifications;

  @override
  Future<AppointmentRequest> sendRequest(AppointmentRequest request) async {
    final now = DateTime.now().toUtc();
    final validationError = AppointmentRequestRules.validateForSend(request, now);
    if (validationError != null) {
      throw Exception(validationError);
    }

    if (request.tutorId.isEmpty) {
      throw Exception('Tutor is required');
    }

    final tutorProfile = await _tutorProfiles.getProfile(request.tutorId);
    if (tutorProfile == null) {
      throw Exception('Tutor profile not found');
    }
    if (!tutorProfile.isAcceptingRequests) {
      throw Exception('This tutor is not accepting new requests right now');
    }

    final seekerConflict = await _ds.hasConflictingConfirmedAppointmentForUser(
      userId: request.seekerId,
      proposedStartAt: request.proposedStartAt.toUtc(),
      proposedEndAt: request.proposedEndAt.toUtc(),
    );
    if (seekerConflict) {
      throw Exception('You already have a confirmed session at this time');
    }

    final tutorSlotTaken = await _ds.hasConflictingActiveRequestForTutor(
      tutorId: request.tutorId,
      proposedStartAt: request.proposedStartAt.toUtc(),
      proposedEndAt: request.proposedEndAt.toUtc(),
    );
    if (tutorSlotTaken) {
      throw Exception('This time slot is no longer available');
    }

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

    final tutorUser = await _users.getUserById(request.tutorId);
    final enriched = request.copyWith(
      id: compositeId,
      receiverName: tutorUser?.fullName,
      receiverAvatarUrl: tutorUser?.avatarUrl,
    );

    final m = await _ds.sendRequest(
      AppointmentRequestModel.fromEntity(enriched),
    );
    final saved = _normalizeOne(m.toEntity());
    await _notify(
      AppNotification(
        id: '',
        userId: saved.receiverId,
        type: NotificationType.appointmentRequest,
        title: 'New Session Request',
        body: '${saved.senderName} wants to book a session for ${saved.subject}',
        payload: {'requestId': saved.id},
        isRead: false,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    return saved;
  }

  @override
  Future<void> acceptRequest(String requestId) async {
    final request = await _requireActionableRequest(requestId);

    final tutorUser = await _users.getUserById(request.tutorId);
    final tutorName = tutorUser?.fullName ?? 'Tutor';

    final appointmentId = await _ds.acceptAppointmentRequest(
      request: AppointmentRequestModel.fromEntity(request),
      tutorName: tutorName,
    );
    await _notify(
      AppNotification(
        id: '',
        userId: request.seekerId,
        type: NotificationType.appointmentConfirmed,
        title: 'Request Accepted',
        body: 'Your session request for ${request.subject} has been accepted',
        payload: {
          'requestId': requestId,
          'appointmentId': appointmentId,
        },
        isRead: false,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  @override
  Future<void> rejectRequest(String requestId, {String? reason}) async {
    final request = await _requireActionableRequest(requestId);
    await _ds.updateRequestStatus(requestId, RequestStatus.rejected, reason: reason);
    await _notify(
      AppNotification(
        id: '',
        userId: request.seekerId,
        type: NotificationType.appointmentCancelled,
        title: 'Request Declined',
        body: 'Your session request for ${request.subject} has been declined',
        payload: {'requestId': requestId},
        isRead: false,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  @override
  Future<void> cancelRequest(String requestId) async {
    final request = await _requireActionableRequest(requestId);
    await _ds.updateRequestStatus(requestId, RequestStatus.cancelled);
    await _notify(
      AppNotification(
        id: '',
        userId: request.receiverId,
        type: NotificationType.appointmentCancelled,
        title: 'Request Cancelled',
        body:
            '${request.senderName} cancelled their session request for ${request.subject}',
        payload: {'requestId': requestId},
        isRead: false,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<void> _notify(AppNotification notification) async {
    try {
      await _notifications.createNotification(notification);
    } catch (_) {
      // Notification delivery must not fail the primary appointment action.
    }
  }

  @override
  Future<AppointmentRequest?> getRequest(String requestId) async {
    final m = await _ds.getRequest(requestId);
    if (m == null) return null;
    return _normalizeOne(m.toEntity());
  }

  @override
  Stream<List<AppointmentRequest>> watchIncomingRequests(String tutorId) =>
      _ds.watchIncomingRequests(tutorId).asyncMap(_normalizeAndSync);

  @override
  Stream<List<AppointmentRequest>> watchSentRequests(String senderId) =>
      _ds.watchSentRequests(senderId).asyncMap(_normalizeAndSync);

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

  Future<AppointmentRequest> _requireActionableRequest(String requestId) async {
    final m = await _ds.getRequest(requestId);
    if (m == null) throw Exception('Request not found');
    final request = _normalizeOne(m.toEntity());
    if (request.status == RequestStatus.expired) {
      throw Exception('This request has expired');
    }
    if (request.status != RequestStatus.pending) {
      throw Exception('This request is no longer pending');
    }
    return request;
  }

  AppointmentRequest _normalizeOne(AppointmentRequest request) {
    return AppointmentRequestRules.withEffectiveStatus(
      request,
      DateTime.now().toUtc(),
    );
  }

  Future<List<AppointmentRequest>> _normalizeAndSync(
    List<AppointmentRequestModel> models,
  ) async {
    final now = DateTime.now().toUtc();
    final normalized = <AppointmentRequest>[];
    for (final model in models) {
      final raw = model.toEntity();
      final effective = AppointmentRequestRules.withEffectiveStatus(raw, now);
      normalized.add(effective);
      if (raw.status == RequestStatus.pending &&
          effective.status == RequestStatus.expired) {
        unawaited(
          _ds.updateRequestStatus(model.id, RequestStatus.expired),
        );
      }
    }
    return normalized;
  }
}
