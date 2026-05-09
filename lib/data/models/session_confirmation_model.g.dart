// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_confirmation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionConfirmationModelImpl _$$SessionConfirmationModelImplFromJson(
  Map<String, dynamic> json,
) => _$SessionConfirmationModelImpl(
  id: json['id'] as String,
  appointmentId: json['appointmentId'] as String,
  tutorConfirmed: json['tutorConfirmed'] as bool,
  seekerConfirmed: json['seekerConfirmed'] as bool,
  tutorConfirmedAt: const NullableTimestampConverter().fromJson(
    json['tutorConfirmedAt'],
  ),
  seekerConfirmedAt: const NullableTimestampConverter().fromJson(
    json['seekerConfirmedAt'],
  ),
  outcome: const NullableSessionOutcomeConverter().fromJson(
    json['outcome'] as String?,
  ),
  resolvedAt: const NullableTimestampConverter().fromJson(json['resolvedAt']),
);

Map<String, dynamic> _$$SessionConfirmationModelImplToJson(
  _$SessionConfirmationModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'appointmentId': instance.appointmentId,
  'tutorConfirmed': instance.tutorConfirmed,
  'seekerConfirmed': instance.seekerConfirmed,
  'tutorConfirmedAt': const NullableTimestampConverter().toJson(
    instance.tutorConfirmedAt,
  ),
  'seekerConfirmedAt': const NullableTimestampConverter().toJson(
    instance.seekerConfirmedAt,
  ),
  'outcome': const NullableSessionOutcomeConverter().toJson(instance.outcome),
  'resolvedAt': const NullableTimestampConverter().toJson(instance.resolvedAt),
};
