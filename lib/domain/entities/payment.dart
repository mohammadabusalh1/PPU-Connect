import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/enums.dart';

part 'payment.freezed.dart';

@freezed
class Payment with _$Payment {
  const factory Payment({
    required String id,
    String? appointmentId,
    required String requestId,
    required String tutorId,
    required String seekerId,
    required double amount,
    required String currency,
    required PaymentStatus status,
    required String cardLast4,
    required String cardBrand,
    DateTime? releasedAt,
    DateTime? refundedAt,
    DateTime? refundRequestedAt,
    String? refundReason,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Payment;
}
