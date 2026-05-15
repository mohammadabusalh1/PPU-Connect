import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/models/appointment_model.dart';
import 'package:ppu_connect/data/models/appointment_request_model.dart';
import 'package:ppu_connect/domain/enums/enums.dart';

abstract interface class AppointmentRemoteDataSource {
  Future<AppointmentRequestModel> sendRequest(AppointmentRequestModel request);
  Future<void> updateRequestStatus(String id, RequestStatus status, {String? reason});
  Future<AppointmentRequestModel?> getRequest(String id);
  Stream<List<AppointmentRequestModel>> watchIncomingRequests(String tutorId);
  Stream<List<AppointmentRequestModel>> watchSentRequests(String senderId);
  Future<void> cancelAppointment(String id, {String? cancelledBy, String? reason});
  Stream<List<AppointmentModel>> watchAppointments(String userId);
  Future<AppointmentModel?> getAppointment(String id);
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
    return AppointmentRequestModel.fromJson({'id': doc.id, ...data});
  }

  @override
  Future<void> updateRequestStatus(
    String id,
    RequestStatus status, {
    String? reason,
  }) async {
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
    return AppointmentRequestModel.fromJson({'id': id, ...doc.data()!});
  }

  @override
  Stream<List<AppointmentRequestModel>> watchIncomingRequests(String tutorId) =>
      _requests
          .where('receiverId', isEqualTo: tutorId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((s) => s.docs
              .map((d) => AppointmentRequestModel.fromJson({'id': d.id, ...d.data()}))
              .toList());

  @override
  Stream<List<AppointmentRequestModel>> watchSentRequests(String senderId) =>
      _requests
          .where('senderId', isEqualTo: senderId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((s) => s.docs
              .map((d) => AppointmentRequestModel.fromJson({'id': d.id, ...d.data()}))
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
          .map((d) => AppointmentModel.fromJson({'id': d.id, ...d.data()}))
          .toList());

  @override
  Future<AppointmentModel?> getAppointment(String id) async {
    final doc = await _appointments.doc(id).get();
    if (!doc.exists || doc.data() == null) return null;
    return AppointmentModel.fromJson({'id': id, ...doc.data()!});
  }
}
