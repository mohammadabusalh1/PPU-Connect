// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentModelImpl _$$PaymentModelImplFromJson(
  Map<String, dynamic> json,
) => _$PaymentModelImpl(
  id: json['id'] as String,
  appointmentId: json['appointmentId'] as String?,
  requestId: json['requestId'] as String,
  tutorId: json['tutorId'] as String,
  seekerId: json['seekerId'] as String,
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String,
  status: const PaymentStatusConverter().fromJson(json['status'] as String),
  cardLast4: json['cardLast4'] as String,
  cardBrand: json['cardBrand'] as String,
  releasedAt: const NullableTimestampConverter().fromJson(json['releasedAt']),
  refundedAt: const NullableTimestampConverter().fromJson(json['refundedAt']),
  refundRequestedAt: const NullableTimestampConverter().fromJson(
    json['refundRequestedAt'],
  ),
  refundReason: json['refundReason'] as String?,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$PaymentModelImplToJson(
  _$PaymentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'appointmentId': instance.appointmentId,
  'requestId': instance.requestId,
  'tutorId': instance.tutorId,
  'seekerId': instance.seekerId,
  'amount': instance.amount,
  'currency': instance.currency,
  'status': const PaymentStatusConverter().toJson(instance.status),
  'cardLast4': instance.cardLast4,
  'cardBrand': instance.cardBrand,
  'releasedAt': const NullableTimestampConverter().toJson(instance.releasedAt),
  'refundedAt': const NullableTimestampConverter().toJson(instance.refundedAt),
  'refundRequestedAt': const NullableTimestampConverter().toJson(
    instance.refundRequestedAt,
  ),
  'refundReason': instance.refundReason,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};
