import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/firestore_converters.dart';
import '../../domain/entities/weekly_slot.dart';
import '../../domain/value_objects/app_time_of_day.dart';

part 'weekly_slot_model.freezed.dart';
part 'weekly_slot_model.g.dart';

@freezed
class WeeklySlotModel with _$WeeklySlotModel {
  const factory WeeklySlotModel({
    required String id,
    required int dayOfWeek,
    @AppTimeOfDayConverter() required AppTimeOfDay startTime,
    @AppTimeOfDayConverter() required AppTimeOfDay endTime,
    required bool isActive,
  }) = _WeeklySlotModel;

  factory WeeklySlotModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklySlotModelFromJson(json);

  factory WeeklySlotModel.fromEntity(WeeklySlot entity) => WeeklySlotModel(
        id: entity.id,
        dayOfWeek: entity.dayOfWeek,
        startTime: entity.startTime,
        endTime: entity.endTime,
        isActive: entity.isActive,
      );
}

extension WeeklySlotModelX on WeeklySlotModel {
  WeeklySlot toEntity() => WeeklySlot(
        id: id,
        dayOfWeek: dayOfWeek,
        startTime: startTime,
        endTime: endTime,
        isActive: isActive,
      );
}
