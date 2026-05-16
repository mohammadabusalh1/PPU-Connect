import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/firestore_converters.dart';
import '../../domain/entities/payment.dart';
import '../../domain/enums/enums.dart';

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

@freezed
class PaymentModel with _$PaymentModel {
  const factory PaymentModel({
    required String id,
    String? appointmentId,
    required String requestId,
    required String tutorId,
    required String seekerId,
    required double amount,
    required String currency,
    @PaymentStatusConverter() required PaymentStatus status,
    required String cardLast4,
    required String cardBrand,
    @NullableTimestampConverter() DateTime? releasedAt,
    @NullableTimestampConverter() DateTime? refundedAt,
    @NullableTimestampConverter() DateTime? refundRequestedAt,
    String? refundReason,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _PaymentModel;

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  factory PaymentModel.fromEntity(Payment entity) => PaymentModel(
        id: entity.id,
        appointmentId: entity.appointmentId,
        requestId: entity.requestId,
        tutorId: entity.tutorId,
        seekerId: entity.seekerId,
        amount: entity.amount,
        currency: entity.currency,
        status: entity.status,
        cardLast4: entity.cardLast4,
        cardBrand: entity.cardBrand,
        releasedAt: entity.releasedAt,
        refundedAt: entity.refundedAt,
        refundRequestedAt: entity.refundRequestedAt,
        refundReason: entity.refundReason,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}

extension PaymentModelX on PaymentModel {
  Payment toEntity() => Payment(
        id: id,
        appointmentId: appointmentId,
        requestId: requestId,
        tutorId: tutorId,
        seekerId: seekerId,
        amount: amount,
        currency: currency,
        status: status,
        cardLast4: cardLast4,
        cardBrand: cardBrand,
        releasedAt: releasedAt,
        refundedAt: refundedAt,
        refundRequestedAt: refundRequestedAt,
        refundReason: refundReason,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
