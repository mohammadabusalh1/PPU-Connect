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
    required String appointmentId,
    required String tutorId,
    required String seekerId,
    required double amount,
    required String currency,
    @PaymentStatusConverter() required PaymentStatus status,
    @NullableTimestampConverter() DateTime? releasedAt,
    @NullableTimestampConverter() DateTime? refundedAt,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _PaymentModel;

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  factory PaymentModel.fromEntity(Payment entity) => PaymentModel(
        id: entity.id,
        appointmentId: entity.appointmentId,
        tutorId: entity.tutorId,
        seekerId: entity.seekerId,
        amount: entity.amount,
        currency: entity.currency,
        status: entity.status,
        releasedAt: entity.releasedAt,
        refundedAt: entity.refundedAt,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}

extension PaymentModelX on PaymentModel {
  Payment toEntity() => Payment(
        id: id,
        appointmentId: appointmentId,
        tutorId: tutorId,
        seekerId: seekerId,
        amount: amount,
        currency: currency,
        status: status,
        releasedAt: releasedAt,
        refundedAt: refundedAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
