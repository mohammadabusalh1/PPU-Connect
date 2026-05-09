// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportModelImpl _$$ReportModelImplFromJson(Map<String, dynamic> json) =>
    _$ReportModelImpl(
      id: json['id'] as String,
      reporterId: json['reporterId'] as String,
      reportedUserId: json['reportedUserId'] as String,
      appointmentId: json['appointmentId'] as String?,
      reason: const ReportReasonConverter().fromJson(json['reason'] as String),
      description: json['description'] as String,
      status: const ReportStatusConverter().fromJson(json['status'] as String),
      resolvedAt: const NullableTimestampConverter().fromJson(
        json['resolvedAt'],
      ),
      adminNote: json['adminNote'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$ReportModelImplToJson(
  _$ReportModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'reporterId': instance.reporterId,
  'reportedUserId': instance.reportedUserId,
  'appointmentId': instance.appointmentId,
  'reason': const ReportReasonConverter().toJson(instance.reason),
  'description': instance.description,
  'status': const ReportStatusConverter().toJson(instance.status),
  'resolvedAt': const NullableTimestampConverter().toJson(instance.resolvedAt),
  'adminNote': instance.adminNote,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};
