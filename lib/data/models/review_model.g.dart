// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewModelImpl _$$ReviewModelImplFromJson(Map<String, dynamic> json) =>
    _$ReviewModelImpl(
      id: json['id'] as String,
      appointmentId: json['appointmentId'] as String,
      authorId: json['authorId'] as String,
      tutorId: json['tutorId'] as String,
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String?,
      isVisible: json['isVisible'] as bool,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$ReviewModelImplToJson(_$ReviewModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointmentId': instance.appointmentId,
      'authorId': instance.authorId,
      'tutorId': instance.tutorId,
      'rating': instance.rating,
      'comment': instance.comment,
      'isVisible': instance.isVisible,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
