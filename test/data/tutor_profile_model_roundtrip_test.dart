import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/data/models/tutor_profile_model.dart';
import 'package:ppu_connect/data/models/weekly_slot_model.dart';
import 'package:ppu_connect/domain/value_objects/app_time_of_day.dart';

void main() {
  test('TutorProfileModel round-trips weeklySlots through JSON', () {
    final original = TutorProfileModel(
      userId: 'u1',
      subjects: const ['Math'],
      hourlyRate: 50,
      currency: 'ILS',
      averageRating: 5,
      totalReviews: 0,
      completedSessions: 0,
      isAcceptingRequests: true,
      weeklySlots: [
        WeeklySlotModel(
          id: 'slot-1',
          dayOfWeek: 3,
          startTime: const AppTimeOfDay(hour: 14, minute: 30),
          endTime: const AppTimeOfDay(hour: 15, minute: 30),
          isActive: true,
        ),
      ],
      createdAt: DateTime.utc(2026, 1, 1),
      updatedAt: DateTime.utc(2026, 1, 2),
    );

    final decoded =
        TutorProfileModel.fromJson(original.toJson());

    expect(decoded.weeklySlots, hasLength(1));
    expect(decoded.weeklySlots.first.dayOfWeek, 3);
    expect(decoded.weeklySlots.first.startTime.hour, 14);
    expect(decoded.weeklySlots.first.startTime.minute, 30);
  });
}
