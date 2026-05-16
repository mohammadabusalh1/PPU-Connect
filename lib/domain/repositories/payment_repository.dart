import 'package:ppu_connect/domain/entities/payment.dart';

abstract interface class PaymentRepository {
  Future<Payment?> getPaymentForAppointment(String appointmentId);
  Future<List<Payment>> getPaymentsForUser(String userId, {int page = 0});
  Stream<List<Payment>> watchPaymentsForUser(String userId);
  Future<Payment> createForRequest({
    required String requestId,
    required String tutorId,
    required String seekerId,
    required double amount,
    required String currency,
    required String cardLast4,
    required String cardBrand,
  });
  Future<Payment?> getPaymentForRequest(String requestId);
  Future<Payment?> getPaymentById(String paymentId);
  Future<void> requestRefund(String paymentId, {required String reason});
}
