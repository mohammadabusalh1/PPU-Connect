import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/models/session_confirmation_model.dart';

abstract interface class SessionConfirmationRemoteDataSource {
  Future<SessionConfirmationModel?> getForAppointment(String appointmentId);
  Future<void> confirmAttendance(String appointmentId, String userId);
  Future<void> reportNoShow(String appointmentId, String reporterId);
  Stream<SessionConfirmationModel?> watchForAppointment(String appointmentId);
}

@Injectable(as: SessionConfirmationRemoteDataSource)
class SessionConfirmationRemoteDataSourceImpl
    implements SessionConfirmationRemoteDataSource {
  const SessionConfirmationRemoteDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('sessionConfirmations');

  @override
  Future<SessionConfirmationModel?> getForAppointment(
      String appointmentId) async {
    final snap = await _col
        .where('appointmentId', isEqualTo: appointmentId)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    final d = snap.docs.first;
    return SessionConfirmationModel.fromJson({'id': d.id, ...d.data()});
  }

  @override
  Future<void> confirmAttendance(String appointmentId, String userId) async {
    final snap = await _col
        .where('appointmentId', isEqualTo: appointmentId)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return;
    await snap.docs.first.reference.update({
      'confirmedBy': FieldValue.arrayUnion([userId]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> reportNoShow(String appointmentId, String reporterId) async {
    final snap = await _col
        .where('appointmentId', isEqualTo: appointmentId)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return;
    await snap.docs.first.reference.update({
      'noShowReportedBy': FieldValue.arrayUnion([reporterId]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Stream<SessionConfirmationModel?> watchForAppointment(
      String appointmentId) =>
      _col
          .where('appointmentId', isEqualTo: appointmentId)
          .limit(1)
          .snapshots()
          .map((s) {
        if (s.docs.isEmpty) return null;
        final d = s.docs.first;
        return SessionConfirmationModel.fromJson({'id': d.id, ...d.data()});
      });
}
