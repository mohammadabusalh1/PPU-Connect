// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppNotificationModelImpl _$$AppNotificationModelImplFromJson(
  Map<String, dynamic> json,
) => _$AppNotificationModelImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  type: const NotificationTypeConverter().fromJson(json['type'] as String),
  title: json['title'] as String,
  body: json['body'] as String,
  payload: json['payload'] == null
      ? const {}
      : const StringMapConverter().fromJson(json['payload']),
  isRead: json['isRead'] as bool,
  readAt: const NullableTimestampConverter().fromJson(json['readAt']),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$$AppNotificationModelImplToJson(
  _$AppNotificationModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'type': const NotificationTypeConverter().toJson(instance.type),
  'title': instance.title,
  'body': instance.body,
  'payload': const StringMapConverter().toJson(instance.payload),
  'isRead': instance.isRead,
  'readAt': const NullableTimestampConverter().toJson(instance.readAt),
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};
