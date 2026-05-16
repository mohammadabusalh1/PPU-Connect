// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentRequestModelImpl _$$AppointmentRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$AppointmentRequestModelImpl(
  id: json['id'] as String,
  senderId: json['senderId'] as String,
  senderName: json['senderName'] as String,
  senderAvatarUrl: json['senderAvatarUrl'] as String?,
  receiverId: json['receiverId'] as String,
  receiverName: json['receiverName'] as String?,
  receiverAvatarUrl: json['receiverAvatarUrl'] as String?,
  tutorId: json['tutorId'] as String,
  seekerId: json['seekerId'] as String,
  subject: json['subject'] as String,
  note: json['note'] as String?,
  proposedStartAt: const TimestampConverter().fromJson(json['proposedStartAt']),
  proposedEndAt: const TimestampConverter().fromJson(json['proposedEndAt']),
  status: const RequestStatusConverter().fromJson(json['status'] as String),
  linkedTutoringRequestId: json['linkedTutoringRequestId'] as String?,
  expiresAt: const TimestampConverter().fromJson(json['expiresAt']),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$AppointmentRequestModelImplToJson(
  _$AppointmentRequestModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'senderId': instance.senderId,
  'senderName': instance.senderName,
  'senderAvatarUrl': instance.senderAvatarUrl,
  'receiverId': instance.receiverId,
  'receiverName': instance.receiverName,
  'receiverAvatarUrl': instance.receiverAvatarUrl,
  'tutorId': instance.tutorId,
  'seekerId': instance.seekerId,
  'subject': instance.subject,
  'note': instance.note,
  'proposedStartAt': const TimestampConverter().toJson(
    instance.proposedStartAt,
  ),
  'proposedEndAt': const TimestampConverter().toJson(instance.proposedEndAt),
  'status': const RequestStatusConverter().toJson(instance.status),
  'linkedTutoringRequestId': instance.linkedTutoringRequestId,
  'expiresAt': const TimestampConverter().toJson(instance.expiresAt),
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};
