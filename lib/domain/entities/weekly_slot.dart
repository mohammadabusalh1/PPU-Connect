import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/app_time_of_day.dart';

part 'weekly_slot.freezed.dart';

@freezed
class WeeklySlot with _$WeeklySlot {
  const factory WeeklySlot({
    required String id,
    /// ISO 8601: 1 = Monday … 7 = Sunday
    required int dayOfWeek,
    required AppTimeOfDay startTime,
    required AppTimeOfDay endTime,
    required bool isActive,
  }) = _WeeklySlot;
}
