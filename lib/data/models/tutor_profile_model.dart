import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/firestore_converters.dart';
import '../../domain/entities/tutor_profile.dart';
import 'weekly_slot_model.dart';

part 'tutor_profile_model.freezed.dart';
part 'tutor_profile_model.g.dart';

@freezed
class TutorProfileModel with _$TutorProfileModel {
  const factory TutorProfileModel({
    required String userId,
    String? bio,
    required List<String> subjects,
    required double hourlyRate,
    required String currency,
    required double averageRating,
    required int totalReviews,
    required int completedSessions,
    required bool isAcceptingRequests,
    @WeeklySlotsConverter() required List<WeeklySlotModel> weeklySlots,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _TutorProfileModel;

  factory TutorProfileModel.fromJson(Map<String, dynamic> json) =>
      _$TutorProfileModelFromJson(json);

  factory TutorProfileModel.fromEntity(TutorProfile entity) =>
      TutorProfileModel(
        userId: entity.userId,
        bio: entity.bio,
        subjects: List<String>.from(entity.subjects),
        hourlyRate: entity.hourlyRate,
        currency: entity.currency,
        averageRating: entity.averageRating,
        totalReviews: entity.totalReviews,
        completedSessions: entity.completedSessions,
        isAcceptingRequests: entity.isAcceptingRequests,
        weeklySlots:
            entity.weeklySlots.map(WeeklySlotModel.fromEntity).toList(),
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}

class WeeklySlotsConverter
    implements JsonConverter<List<WeeklySlotModel>, List<dynamic>> {
  const WeeklySlotsConverter();

  @override
  List<WeeklySlotModel> fromJson(List<dynamic> json) => json
      .map((e) => WeeklySlotModel.fromJson(e as Map<String, dynamic>))
      .toList();

  @override
  List<dynamic> toJson(List<WeeklySlotModel> slots) =>
      slots.map((e) => e.toJson()).toList();
}

extension TutorProfileModelX on TutorProfileModel {
  TutorProfile toEntity() => TutorProfile(
        userId: userId,
        bio: bio,
        subjects: subjects,
        hourlyRate: hourlyRate,
        currency: currency,
        averageRating: averageRating,
        totalReviews: totalReviews,
        completedSessions: completedSessions,
        isAcceptingRequests: isAcceptingRequests,
        weeklySlots: weeklySlots.map((e) => e.toEntity()).toList(),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
