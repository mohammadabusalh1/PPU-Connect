import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/models/appointment_model.dart';
import 'package:ppu_connect/data/models/appointment_request_model.dart';
import 'package:ppu_connect/data/utils/firestore_doc_json.dart';
import 'package:ppu_connect/domain/enums/enums.dart';

abstract interface class AppointmentRemoteDataSource {
  Future<AppointmentRequestModel> sendRequest(AppointmentRequestModel request);
  Future<String> acceptAppointmentRequest({
    required AppointmentRequestModel request,
    required String tutorName,
  });
  Future<bool> hasConflictingActiveRequestForTutor({
    required String tutorId,
    required DateTime proposedStartAt,
    required DateTime proposedEndAt,
    String? excludeRequestId,
  });
  Future<bool> hasConflictingConfirmedAppointmentForUser({
    required String userId,
    required DateTime proposedStartAt,
    required DateTime proposedEndAt,
  });
  Future<void> updateRequestStatus(String id, RequestStatus status, {String? reason});
  Future<AppointmentRequestModel?> getRequest(String id);
  Stream<List<AppointmentRequestModel>> watchIncomingRequests(String tutorId);
  Stream<List<AppointmentRequestModel>> watchSentRequests(String senderId);
  Future<void> cancelAppointment(String id, {String? cancelledBy, String? reason});
  Stream<List<AppointmentModel>> watchAppointments(String userId);
  Future<AppointmentModel?> getAppointment(String id);
  Future<List<AppointmentModel>> getConfirmedAppointmentsForTutor({
    required String tutorId,
    required DateTime from,
    required DateTime to,
  });
  Future<bool> hasPendingOrAcceptedRequest({
    required String seekerId,
    required String tutorId,
    required DateTime dayStart,
    required DateTime dayEnd,
    required DateTime proposedStartAt,
    required DateTime proposedEndAt,
  });
}

@Injectable(as: AppointmentRemoteDataSource)
class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  const AppointmentRemoteDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _requests =>
      _firestore.collection('appointmentRequests');
  CollectionReference<Map<String, dynamic>> get _appointments =>
      _firestore.collection('appointments');

  @override
  Future<AppointmentRequestModel> sendRequest(AppointmentRequestModel request) async {
    final doc = _requests.doc(request.id.isEmpty ? null : request.id);
    final data = request.toJson();
    await doc.set(data);
    return AppointmentRequestModel.fromJson(mergeFirestoreDocId(doc.id, data));
  }

  @override
  Future<String> acceptAppointmentRequest({
    required AppointmentRequestModel request,
    required String tutorName,
  }) async {
    if (request.id.isEmpty) {
      throw Exception('Invalid request id');
    }
    if (request.status != RequestStatus.pending) {
      throw Exception('This request is no longer pending');
    }
    if (DateTime.now().toUtc().isAfter(request.expiresAt.toUtc())) {
      throw Exception('This request has expired');
    }

    final dayStart = DateTime.utc(
      request.proposedStartAt.year,
      request.proposedStartAt.month,
      request.proposedStartAt.day,
    );
    final existing = await getConfirmedAppointmentsForTutor(
      tutorId: request.tutorId,
      from: dayStart,
      to: dayStart.add(const Duration(days: 1)),
    );
    for (final appt in existing) {
      if (request.proposedStartAt.toUtc().isBefore(appt.endAt.toUtc()) &&
          request.proposedEndAt.toUtc().isAfter(appt.startAt.toUtc())) {
        throw Exception('Tutor already has a confirmed session at this time');
      }
    }

    final conflictingRequest = await hasConflictingActiveRequestForTutor(
      tutorId: request.tutorId,
      proposedStartAt: request.proposedStartAt.toUtc(),
      proposedEndAt: request.proposedEndAt.toUtc(),
      excludeRequestId: request.id,
    );
    if (conflictingRequest) {
      throw Exception('Another request already holds this time slot');
    }

    final paymentSnap = await _firestore
        .collection('payments')
        .where('requestId', isEqualTo: request.id)
        .limit(1)
        .get();
    if (paymentSnap.docs.isEmpty) {
      throw Exception('Payment not found for request');
    }
    final existingPaymentRef = paymentSnap.docs.first.reference;

    final appointmentRef = _appointments.doc();
    await _firestore.runTransaction((txn) async {
      final reqRef = _requests.doc(request.id);
      final reqSnap = await txn.get(reqRef);
      if (!reqSnap.exists || reqSnap.data() == null) {
        throw Exception('Request not found');
      }

      final currentStatus = reqSnap.data()!['status'] as String?;
      if (currentStatus != RequestStatus.pending.name) {
        throw Exception('This request is no longer pending');
      }

      final sessionRef =
          _firestore.collection('sessionConfirmations').doc(appointmentRef.id);

      txn.set(appointmentRef, {
        'appointmentRequestId': request.id,
        'tutorId': request.tutorId,
        'seekerId': request.seekerId,
        'tutorName': tutorName,
        'seekerName': request.senderName,
        'subject': request.subject,
        'startAt': Timestamp.fromDate(request.proposedStartAt.toUtc()),
        'endAt': Timestamp.fromDate(request.proposedEndAt.toUtc()),
        'status': AppointmentStatus.confirmed.name,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      txn.update(existingPaymentRef, {
        'appointmentId': appointmentRef.id,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      txn.set(sessionRef, {
        'appointmentId': appointmentRef.id,
        'tutorConfirmed': false,
        'seekerConfirmed': false,
      });

      txn.update(reqRef, {
        'status': RequestStatus.accepted.name,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });

    return appointmentRef.id;
  }

  @override
  Future<void> updateRequestStatus(
    String id,
    RequestStatus status, {
    String? reason,
  }) async {
    if (id.isEmpty) throw Exception('Invalid request id');
    final update = <String, dynamic>{
      'status': status.name,
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (reason != null) update['rejectionReason'] = reason;
    await _requests.doc(id).update(update);
  }

  @override
  Future<AppointmentRequestModel?> getRequest(String id) async {
    final doc = await _requests.doc(id).get();
    if (!doc.exists || doc.data() == null) return null;
    return AppointmentRequestModel.fromJson(
      mergeFirestoreDocId(id, doc.data()!),
    );
  }

  @override
  Stream<List<AppointmentRequestModel>> watchIncomingRequests(String tutorId) =>
      _requests
          .where('receiverId', isEqualTo: tutorId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((s) => s.docs
              .map((d) => AppointmentRequestModel.fromJson(
                    mergeFirestoreDocId(d.id, d.data()),
                  ))
              .toList());

  @override
  Stream<List<AppointmentRequestModel>> watchSentRequests(String senderId) =>
      _requests
          .where('senderId', isEqualTo: senderId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((s) => s.docs
              .map((d) => AppointmentRequestModel.fromJson(
                    mergeFirestoreDocId(d.id, d.data()),
                  ))
              .toList());

  @override
  Future<void> cancelAppointment(
    String id, {
    String? cancelledBy,
    String? reason,
  }) =>
      _appointments.doc(id).update({
        'status': AppointmentStatus.cancelled.name,
        'cancelledBy': cancelledBy,
        'cancellationReason': reason,
        'cancelledAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

  @override
  Stream<List<AppointmentModel>> watchAppointments(String userId) => _appointments
      .where(Filter.or(
        Filter('tutorId', isEqualTo: userId),
        Filter('seekerId', isEqualTo: userId),
      ))
      .orderBy('startAt', descending: true)
      .snapshots()
      .map((s) => s.docs
          .map((d) => AppointmentModel.fromJson(
                mergeFirestoreDocId(d.id, d.data()),
              ))
          .toList());

  @override
  Future<AppointmentModel?> getAppointment(String id) async {
    final doc = await _appointments.doc(id).get();
    if (!doc.exists || doc.data() == null) return null;
    return AppointmentModel.fromJson(mergeFirestoreDocId(id, doc.data()!));
  }

  @override
  Future<List<AppointmentModel>> getConfirmedAppointmentsForTutor({
    required String tutorId,
    required DateTime from,
    required DateTime to,
  }) async {
    final snap = await _appointments
        .where('tutorId', isEqualTo: tutorId)
        .where('status', isEqualTo: AppointmentStatus.confirmed.name)
        .where('startAt', isGreaterThanOrEqualTo: Timestamp.fromDate(from))
        .where('startAt', isLessThan: Timestamp.fromDate(to))
        .get();
    return snap.docs
        .map((d) => AppointmentModel.fromJson(mergeFirestoreDocId(d.id, d.data())))
        .toList();
  }

  @override
  Future<bool> hasPendingOrAcceptedRequest({
    required String seekerId,
    required String tutorId,
    required DateTime dayStart,
    required DateTime dayEnd,
    required DateTime proposedStartAt,
    required DateTime proposedEndAt,
  }) async {
    final snap = await _requests
        .where('senderId', isEqualTo: seekerId)
        .where('receiverId', isEqualTo: tutorId)
        .where('proposedStartAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(dayStart))
        .where('proposedStartAt', isLessThan: Timestamp.fromDate(dayEnd))
        .get();

    for (final doc in snap.docs) {
      final data = doc.data();
      final status = data['status'] as String?;
      if (status != RequestStatus.pending.name &&
          status != RequestStatus.accepted.name) {
        continue;
      }
      final start =
          (data['proposedStartAt'] as Timestamp).toDate().toUtc();
      final end = (data['proposedEndAt'] as Timestamp).toDate().toUtc();
      if (proposedStartAt.isBefore(end) && proposedEndAt.isAfter(start)) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<bool> hasConflictingActiveRequestForTutor({
    required String tutorId,
    required DateTime proposedStartAt,
    required DateTime proposedEndAt,
    String? excludeRequestId,
  }) async {
    final snap = await _requests.where('receiverId', isEqualTo: tutorId).get();

    for (final doc in snap.docs) {
      if (excludeRequestId != null && doc.id == excludeRequestId) continue;
      final data = doc.data();
      final status = data['status'] as String?;
      if (status != RequestStatus.pending.name &&
          status != RequestStatus.accepted.name) {
        continue;
      }
      final expiresAt = (data['expiresAt'] as Timestamp).toDate().toUtc();
      if (status == RequestStatus.pending.name &&
          DateTime.now().toUtc().isAfter(expiresAt)) {
        continue;
      }
      final start =
          (data['proposedStartAt'] as Timestamp).toDate().toUtc();
      final end = (data['proposedEndAt'] as Timestamp).toDate().toUtc();
      if (proposedStartAt.isBefore(end) && proposedEndAt.isAfter(start)) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<bool> hasConflictingConfirmedAppointmentForUser({
    required String userId,
    required DateTime proposedStartAt,
    required DateTime proposedEndAt,
  }) async {
    final snap = await _appointments
        .where('seekerId', isEqualTo: userId)
        .where('status', isEqualTo: AppointmentStatus.confirmed.name)
        .get();

    for (final doc in snap.docs) {
      final data = doc.data();
      final start = (data['startAt'] as Timestamp).toDate().toUtc();
      final end = (data['endAt'] as Timestamp).toDate().toUtc();
      if (proposedStartAt.isBefore(end) && proposedEndAt.isAfter(start)) {
        return true;
      }
    }
    return false;
  }
}
