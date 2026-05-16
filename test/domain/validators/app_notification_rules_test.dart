import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/domain/entities/app_notification.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/validators/app_notification_rules.dart';

AppNotification _notification({String title = 'Hi', String body = 'Body'}) {
  return AppNotification(
    id: '',
    userId: 'user1',
    type: NotificationType.appointmentRequest,
    title: title,
    body: body,
    payload: const {},
    isRead: false,
    createdAt: DateTime.utc(2030, 1, 1),
  );
}

void main() {
  group('AppNotificationRules.validateForCreate', () {
    test('returns null for valid notification', () {
      expect(AppNotificationRules.validateForCreate(_notification()), isNull);
    });

    test('rejects empty userId', () {
      final n = _notification().copyWith(userId: '');
      expect(
        AppNotificationRules.validateForCreate(n),
        contains('Recipient'),
      );
    });

    test('rejects title over max length', () {
      final n = _notification(title: 'x' * 101);
      expect(
        AppNotificationRules.validateForCreate(n),
        isNotNull,
      );
    });
  });
}
