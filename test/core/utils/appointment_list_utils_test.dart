import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/core/utils/appointment_list_utils.dart';
import 'package:ppu_connect/domain/entities/appointment.dart';
import 'package:ppu_connect/domain/enums/enums.dart';

Appointment _appt({
  required String id,
  required DateTime startAt,
  required DateTime endAt,
  AppointmentStatus status = AppointmentStatus.confirmed,
  DateTime? cancelledAt,
}) {
  return Appointment(
    id: id,
    appointmentRequestId: 'r1',
    tutorId: 't1',
    seekerId: 's1',
    subject: 'Math',
    startAt: startAt,
    endAt: endAt,
    status: status,
    cancelledAt: cancelledAt,
    createdAt: DateTime.utc(2025, 1, 1),
    updatedAt: DateTime.utc(2025, 1, 1),
  );
}

void main() {
  final now = DateTime(2025, 5, 16, 14);

  test('isPastAppointment includes expired terminal status', () {
    final future = DateTime.utc(2025, 6, 1, 10);
    final a = _appt(
      id: '1',
      startAt: future,
      endAt: future.add(const Duration(hours: 1)),
      status: AppointmentStatus.expired,
    );
    expect(isPastAppointment(a, now), isTrue);
  });

  test('isUpcomingAppointment excludes expired', () {
    final future = DateTime.utc(2025, 6, 1, 10);
    final a = _appt(
      id: '1',
      startAt: future,
      endAt: future.add(const Duration(hours: 1)),
      status: AppointmentStatus.expired,
    );
    expect(isUpcomingAppointment(a, now), isFalse);
  });

  test('pastSectionHeader labels future-dated items as Upcoming', () {
    final future = DateTime.utc(2025, 6, 1, 10);
    expect(pastSectionHeader(future, now), 'Upcoming');
  });

  test('isPastAppointment uses endAt for confirmed sessions', () {
    final start = DateTime.utc(2025, 5, 16, 12);
    final end = DateTime.utc(2025, 5, 16, 16);
    final inProgress = _appt(id: '1', startAt: start, endAt: end);
    expect(isPastAppointment(inProgress, now), isFalse);
    expect(isUpcomingAppointment(inProgress, now), isTrue);
  });
}
