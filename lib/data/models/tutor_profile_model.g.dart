// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TutorProfileModelImpl _$$TutorProfileModelImplFromJson(
  Map<String, dynamic> json,
) => _$TutorProfileModelImpl(
  userId: json['userId'] as String,
  bio: json['bio'] as String?,
  subjects: (json['subjects'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  hourlyRate: (json['hourlyRate'] as num).toDouble(),
  currency: json['currency'] as String,
  averageRating: (json['averageRating'] as num).toDouble(),
  totalReviews: (json['totalReviews'] as num).toInt(),
  completedSessions: (json['completedSessions'] as num).toInt(),
  isAcceptingRequests: json['isAcceptingRequests'] as bool,
  weeklySlots: const WeeklySlotsConverter().fromJson(
    json['weeklySlots'] as List,
  ),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$TutorProfileModelImplToJson(
  _$TutorProfileModelImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'bio': instance.bio,
  'subjects': instance.subjects,
  'hourlyRate': instance.hourlyRate,
  'currency': instance.currency,
  'averageRating': instance.averageRating,
  'totalReviews': instance.totalReviews,
  'completedSessions': instance.completedSessions,
  'isAcceptingRequests': instance.isAcceptingRequests,
  'weeklySlots': const WeeklySlotsConverter().toJson(instance.weeklySlots),
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};
