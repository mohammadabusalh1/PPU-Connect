// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentModelImpl _$$AppointmentModelImplFromJson(
  Map<String, dynamic> json,
) => _$AppointmentModelImpl(
  id: json['id'] as String,
  appointmentRequestId: json['appointmentRequestId'] as String,
  tutorId: json['tutorId'] as String,
  seekerId: json['seekerId'] as String,
  tutorName: json['tutorName'] as String?,
  seekerName: json['seekerName'] as String?,
  subject: json['subject'] as String,
  startAt: const TimestampConverter().fromJson(json['startAt']),
  endAt: const TimestampConverter().fromJson(json['endAt']),
  status: const AppointmentStatusConverter().fromJson(json['status'] as String),
  cancelledBy: json['cancelledBy'] as String?,
  cancelledAt: const NullableTimestampConverter().fromJson(json['cancelledAt']),
  cancellationReason: json['cancellationReason'] as String?,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$AppointmentModelImplToJson(
  _$AppointmentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'appointmentRequestId': instance.appointmentRequestId,
  'tutorId': instance.tutorId,
  'seekerId': instance.seekerId,
  'tutorName': instance.tutorName,
  'seekerName': instance.seekerName,
  'subject': instance.subject,
  'startAt': const TimestampConverter().toJson(instance.startAt),
  'endAt': const TimestampConverter().toJson(instance.endAt),
  'status': const AppointmentStatusConverter().toJson(instance.status),
  'cancelledBy': instance.cancelledBy,
  'cancelledAt': const NullableTimestampConverter().toJson(
    instance.cancelledAt,
  ),
  'cancellationReason': instance.cancellationReason,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};
