import 'package:freezed_annotation/freezed_annotation.dart';

import 'weekly_slot.dart';

part 'tutor_profile.freezed.dart';

@freezed
class TutorProfile with _$TutorProfile {
  const factory TutorProfile({
    required String userId,
    String? bio,
    required List<String> subjects,
    required double hourlyRate,
    required String currency,
    required double averageRating,
    required int totalReviews,
    required int completedSessions,
    required bool isAcceptingRequests,
    required List<WeeklySlot> weeklySlots,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _TutorProfile;
}
