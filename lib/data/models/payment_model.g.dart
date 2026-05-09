// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentModelImpl _$$PaymentModelImplFromJson(
  Map<String, dynamic> json,
) => _$PaymentModelImpl(
  id: json['id'] as String,
  appointmentId: json['appointmentId'] as String,
  tutorId: json['tutorId'] as String,
  seekerId: json['seekerId'] as String,
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String,
  status: const PaymentStatusConverter().fromJson(json['status'] as String),
  releasedAt: const NullableTimestampConverter().fromJson(json['releasedAt']),
  refundedAt: const NullableTimestampConverter().fromJson(json['refundedAt']),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$PaymentModelImplToJson(
  _$PaymentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'appointmentId': instance.appointmentId,
  'tutorId': instance.tutorId,
  'seekerId': instance.seekerId,
  'amount': instance.amount,
  'currency': instance.currency,
  'status': const PaymentStatusConverter().toJson(instance.status),
  'releasedAt': const NullableTimestampConverter().toJson(instance.releasedAt),
  'refundedAt': const NullableTimestampConverter().toJson(instance.refundedAt),
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};
