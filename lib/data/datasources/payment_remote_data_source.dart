import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/models/payment_model.dart';

abstract interface class PaymentRemoteDataSource {
  Future<PaymentModel?> getPaymentForAppointment(String appointmentId);
  Future<List<PaymentModel>> getPaymentsForUser(String userId, {int page = 0});
  Stream<List<PaymentModel>> watchPaymentsForUser(String userId);
  Future<PaymentModel> createForRequest({
    required String requestId,
    required String tutorId,
    required String seekerId,
    required double amount,
    required String currency,
    required String cardLast4,
    required String cardBrand,
  });
  Future<PaymentModel?> getPaymentForRequest(String requestId);
  Future<PaymentModel?> getPaymentById(String paymentId);
  Future<void> requestRefund(String paymentId, {required String reason});
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

  @override
  Future<PaymentModel> createForRequest({
    required String requestId,
    required String tutorId,
    required String seekerId,
    required double amount,
    required String currency,
    required String cardLast4,
    required String cardBrand,
  }) async {
    final ref = _col.doc();
    final now = Timestamp.now();
    final data = {
      'requestId': requestId,
      'appointmentId': null,
      'tutorId': tutorId,
      'seekerId': seekerId,
      'amount': amount,
      'currency': currency,
      'status': 'held',
      'cardLast4': cardLast4,
      'cardBrand': cardBrand,
      'releasedAt': null,
      'refundedAt': null,
      'refundRequestedAt': null,
      'refundReason': null,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    await ref.set(data);
    return PaymentModel.fromJson({
      'id': ref.id,
      ...data,
      'createdAt': now,
      'updatedAt': now,
    });
  }

  @override
  Future<PaymentModel?> getPaymentForRequest(String requestId) async {
    final snap =
        await _col.where('requestId', isEqualTo: requestId).limit(1).get();
    if (snap.docs.isEmpty) return null;
    final d = snap.docs.first;
    return PaymentModel.fromJson({'id': d.id, ...d.data()});
  }

  @override
  Future<PaymentModel?> getPaymentById(String paymentId) async {
    final doc = await _col.doc(paymentId).get();
    if (!doc.exists || doc.data() == null) return null;
    return PaymentModel.fromJson({'id': doc.id, ...doc.data()!});
  }

  @override
  Future<void> requestRefund(String paymentId, {required String reason}) =>
      _col.doc(paymentId).update({
        'status': 'refunded',
        'refundReason': reason,
        'refundRequestedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
}
