import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/data/models/tutor_profile_model.dart';
import 'package:ppu_connect/data/models/weekly_slot_model.dart';
import 'package:ppu_connect/domain/value_objects/app_time_of_day.dart';

void main() {
  test('TutorProfileModel.toJson encodes weeklySlots as maps for Firestore', () {
    final model = TutorProfileModel(
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
          dayOfWeek: 1,
          startTime: const AppTimeOfDay(hour: 10, minute: 0),
          endTime: const AppTimeOfDay(hour: 11, minute: 0),
          isActive: true,
        ),
      ],
      createdAt: DateTime.utc(2026, 1, 1),
      updatedAt: DateTime.utc(2026, 1, 1),
    );

    final json = model.toJson();
    final slots = json['weeklySlots'] as List<dynamic>;

    expect(slots, hasLength(1));
    expect(slots.first, isA<Map<String, dynamic>>());
    expect(slots.first['dayOfWeek'], 1);
    expect(slots.first['startTime'], {'hour': 10, 'minute': 0});
    expect(slots.first, isNot(isA<WeeklySlotModel>()));
  });
}
