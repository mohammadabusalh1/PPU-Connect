import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/domain/entities/appointment_request.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/validators/appointment_request_rules.dart';

AppointmentRequest _request({
  DateTime? start,
  RequestStatus status = RequestStatus.pending,
}) {
  final startAt = start ?? DateTime.utc(2030, 6, 1, 14);
  final endAt = startAt.add(const Duration(hours: 1));
  return AppointmentRequest(
    id: 'r1',
    senderId: 'seeker',
    senderName: 'Seeker',
    receiverId: 'tutor',
    tutorId: 'tutor',
    seekerId: 'seeker',
    subject: 'Math',
    proposedStartAt: startAt,
    proposedEndAt: endAt,
    status: status,
    expiresAt: startAt.subtract(const Duration(hours: 1)),
    createdAt: DateTime.utc(2030, 5, 1),
    updatedAt: DateTime.utc(2030, 5, 1),
  );
}

void main() {
  group('AppointmentRequestRules.validateForSend', () {
    test('returns null for a valid future request', () {
      final request = _request(start: DateTime.utc(2030, 6, 1, 14));
      final now = DateTime.utc(2030, 5, 1);
      expect(AppointmentRequestRules.validateForSend(request, now), isNull);
    });

    test('rejects past start time', () {
      final request = _request(start: DateTime.utc(2020, 1, 1, 10));
      final now = DateTime.utc(2030, 1, 1);
      expect(
        AppointmentRequestRules.validateForSend(request, now),
        contains('future'),
      );
    });

    test('rejects self-request', () {
      final request = _request().copyWith(seekerId: 'same', tutorId: 'same');
      expect(
        AppointmentRequestRules.validateForSend(
          request,
          DateTime.utc(2030, 1, 1),
        ),
        contains('yourself'),
      );
    });
  });

  group('AppointmentRequestRules.withEffectiveStatus', () {
    test('marks pending as expired after expiresAt', () {
      final request = _request(
        start: DateTime.utc(2030, 6, 1, 14),
      ).copyWith(
        expiresAt: DateTime.utc(2030, 6, 1, 12),
        status: RequestStatus.pending,
      );
      final effective = AppointmentRequestRules.withEffectiveStatus(
        request,
        DateTime.utc(2030, 6, 1, 13),
      );
      expect(effective.status, RequestStatus.expired);
    });
  });
}
