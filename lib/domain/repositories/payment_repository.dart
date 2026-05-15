import 'package:ppu_connect/domain/entities/payment.dart';

abstract interface class PaymentRepository {
  Future<Payment?> getPaymentForAppointment(String appointmentId);
  Future<List<Payment>> getPaymentsForUser(String userId, {int page = 0});
  Stream<List<Payment>> watchPaymentsForUser(String userId);
}
