import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/enums.dart';

part 'payment.freezed.dart';

@freezed
class Payment with _$Payment {
  const factory Payment({
    required String id,
    required String appointmentId,
    required String tutorId,
    required String seekerId,
    required double amount,
    required String currency,
    required PaymentStatus status,
    DateTime? releasedAt,
    DateTime? refundedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Payment;
}
