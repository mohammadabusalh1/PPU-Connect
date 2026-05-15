import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/models/payment_model.dart';

abstract interface class PaymentRemoteDataSource {
  Future<PaymentModel?> getPaymentForAppointment(String appointmentId);
  Future<List<PaymentModel>> getPaymentsForUser(String userId, {int page = 0});
  Stream<List<PaymentModel>> watchPaymentsForUser(String userId);
}

@Injectable(as: PaymentRemoteDataSource)
class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  const PaymentRemoteDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('payments');

  @override
  Future<PaymentModel?> getPaymentForAppointment(String appointmentId) async {
    final snap = await _col
        .where('appointmentId', isEqualTo: appointmentId)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    final d = snap.docs.first;
    return PaymentModel.fromJson({'id': d.id, ...d.data()});
  }

  @override
  Future<List<PaymentModel>> getPaymentsForUser(
    String userId, {
    int page = 0,
  }) async {
    final snap = await _col
        .where(Filter.or(
          Filter('tutorId', isEqualTo: userId),
          Filter('seekerId', isEqualTo: userId),
        ))
        .orderBy('createdAt', descending: true)
        .limit(20)
        .get();
    return snap.docs
        .map((d) => PaymentModel.fromJson({'id': d.id, ...d.data()}))
        .toList();
  }

  @override
  Stream<List<PaymentModel>> watchPaymentsForUser(String userId) => _col
      .where(Filter.or(
        Filter('tutorId', isEqualTo: userId),
        Filter('seekerId', isEqualTo: userId),
      ))
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) =>
          s.docs.map((d) => PaymentModel.fromJson({'id': d.id, ...d.data()})).toList());
}
