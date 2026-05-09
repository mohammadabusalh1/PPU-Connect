// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      major: json['major'] as String,
      academicLevel: const AcademicLevelConverter().fromJson(
        json['academicLevel'] as String,
      ),
      gpa: (json['gpa'] as num?)?.toDouble(),
      role: const UserRoleConverter().fromJson(json['role'] as String),
      isActive: json['isActive'] as bool,
      reportCount: (json['reportCount'] as num).toInt(),
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'avatarUrl': instance.avatarUrl,
      'major': instance.major,
      'academicLevel': const AcademicLevelConverter().toJson(
        instance.academicLevel,
      ),
      'gpa': instance.gpa,
      'role': const UserRoleConverter().toJson(instance.role),
      'isActive': instance.isActive,
      'reportCount': instance.reportCount,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
