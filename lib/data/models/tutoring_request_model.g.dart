// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutoring_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TutoringRequestModelImpl _$$TutoringRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$TutoringRequestModelImpl(
  id: json['id'] as String,
  seekerId: json['seekerId'] as String,
  subject: json['subject'] as String,
  description: json['description'] as String,
  preferredDays: (json['preferredDays'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  preferredTimeRange: const NullableTimeRangeConverter().fromJson(
    json['preferredTimeRange'] as Map<String, dynamic>?,
  ),
  status: const RequestStatusConverter().fromJson(json['status'] as String),
  respondedTutorIds: (json['respondedTutorIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  expiresAt: const TimestampConverter().fromJson(json['expiresAt']),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$TutoringRequestModelImplToJson(
  _$TutoringRequestModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'seekerId': instance.seekerId,
  'subject': instance.subject,
  'description': instance.description,
  'preferredDays': instance.preferredDays,
  'preferredTimeRange': const NullableTimeRangeConverter().toJson(
    instance.preferredTimeRange,
  ),
  'status': const RequestStatusConverter().toJson(instance.status),
  'respondedTutorIds': instance.respondedTutorIds,
  'expiresAt': const TimestampConverter().toJson(instance.expiresAt),
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};
