import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/domain/entities/app_notification.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/navigation/notification_deep_link.dart';

void main() {
  group('NotificationDeepLink.routeFor', () {
    test('routes appointment request to request detail', () {
      final route = NotificationDeepLink.routeFor(
        AppNotification(
          id: 'n1',
          userId: 'u1',
          type: NotificationType.appointmentRequest,
          title: 't',
          body: 'b',
          payload: {'requestId': 'req-1'},
          isRead: false,
          createdAt: DateTime.utc(2030, 1, 1),
        ),
      );
      expect(route, '/requests/req-1');
    });

    test('routes confirmed to schedule appointment when appointmentId set', () {
      final route = NotificationDeepLink.routeFor(
        AppNotification(
          id: 'n1',
          userId: 'u1',
          type: NotificationType.appointmentConfirmed,
          title: 't',
          body: 'b',
          payload: {
            'requestId': 'req-1',
            'appointmentId': 'appt-1',
          },
          isRead: false,
          createdAt: DateTime.utc(2030, 1, 1),
        ),
      );
      expect(route, '/schedule/appointments/appt-1');
    });
  });
}
