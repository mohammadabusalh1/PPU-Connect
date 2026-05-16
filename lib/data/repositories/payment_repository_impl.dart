import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/datasources/payment_remote_data_source.dart';
import 'package:ppu_connect/data/models/payment_model.dart';
import 'package:ppu_connect/domain/entities/payment.dart';
import 'package:ppu_connect/domain/repositories/payment_repository.dart';

@Injectable(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  const PaymentRepositoryImpl(this._ds);
  final PaymentRemoteDataSource _ds;

  @override
  Future<Payment?> getPaymentForAppointment(String appointmentId) async {
    final m = await _ds.getPaymentForAppointment(appointmentId);
    return m?.toEntity();
  }

  @override
  Future<List<Payment>> getPaymentsForUser(String userId, {int page = 0}) async {
    final models = await _ds.getPaymentsForUser(userId, page: page);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Stream<List<Payment>> watchPaymentsForUser(String userId) =>
      _ds.watchPaymentsForUser(userId).map((list) => list.map((m) => m.toEntity()).toList());

  @override
  Future<Payment> createForRequest({
    required String requestId,
    required String tutorId,
    required String seekerId,
    required double amount,
    required String currency,
    required String cardLast4,
    required String cardBrand,
  }) async {
    final m = await _ds.createForRequest(
      requestId: requestId,
      tutorId: tutorId,
      seekerId: seekerId,
      amount: amount,
      currency: currency,
      cardLast4: cardLast4,
      cardBrand: cardBrand,
    );
    return m.toEntity();
  }

  @override
  Future<Payment?> getPaymentForRequest(String requestId) async {
    final m = await _ds.getPaymentForRequest(requestId);
    return m?.toEntity();
  }

  @override
  Future<Payment?> getPaymentById(String paymentId) async {
    final m = await _ds.getPaymentById(paymentId);
    return m?.toEntity();
  }

  @override
  Future<void> requestRefund(String paymentId, {required String reason}) =>
      _ds.requestRefund(paymentId, reason: reason);
}
