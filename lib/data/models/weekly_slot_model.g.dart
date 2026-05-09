// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeeklySlotModelImpl _$$WeeklySlotModelImplFromJson(
  Map<String, dynamic> json,
) => _$WeeklySlotModelImpl(
  id: json['id'] as String,
  dayOfWeek: (json['dayOfWeek'] as num).toInt(),
  startTime: const AppTimeOfDayConverter().fromJson(
    json['startTime'] as Map<String, dynamic>,
  ),
  endTime: const AppTimeOfDayConverter().fromJson(
    json['endTime'] as Map<String, dynamic>,
  ),
  isActive: json['isActive'] as bool,
);

Map<String, dynamic> _$$WeeklySlotModelImplToJson(
  _$WeeklySlotModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'dayOfWeek': instance.dayOfWeek,
  'startTime': const AppTimeOfDayConverter().toJson(instance.startTime),
  'endTime': const AppTimeOfDayConverter().toJson(instance.endTime),
  'isActive': instance.isActive,
};
