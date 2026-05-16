import 'package:ppu_connect/domain/entities/app_notification.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/navigation/appointment_routes.dart';

/// Resolves in-app routes from [AppNotification] type + payload.
abstract final class NotificationDeepLink {
  static String? routeFor(AppNotification notification) {
    final payload = notification.payload;
    final requestId = payload['requestId'];
    final appointmentId = payload['appointmentId'];

    return switch (notification.type) {
      NotificationType.appointmentRequest ||
      NotificationType.appointmentExpired =>
        _requestRoute(requestId),
      NotificationType.appointmentConfirmed =>
        _appointmentRoute(appointmentId) ?? _requestRoute(requestId),
      NotificationType.appointmentCancelled =>
        _appointmentRoute(appointmentId) ?? _requestRoute(requestId),
      NotificationType.sessionStartingSoon ||
      NotificationType.sessionConfirmationRequired =>
        _appointmentConfirmRoute(appointmentId),
      NotificationType.paymentReleased ||
      NotificationType.paymentRefunded =>
        '/payments',
      NotificationType.newReview => '/reviews/my',
      NotificationType.reportUpdate => '/reports/my',
      NotificationType.tutoringRequestMatch =>
        payload['tutoringRequestId'] != null
            ? '/tutoring-requests'
            : null,
    };
  }

  static String? _requestRoute(String? requestId) {
    if (requestId == null || requestId.isEmpty) return null;
    return '/requests/$requestId';
  }

  static String? _appointmentRoute(String? appointmentId) {
    if (appointmentId == null || appointmentId.isEmpty) return null;
    return AppointmentRouteScope.schedule.appointmentDetail(appointmentId);
  }

  static String? _appointmentConfirmRoute(String? appointmentId) {
    if (appointmentId == null || appointmentId.isEmpty) return null;
    return AppointmentRouteScope.schedule.appointmentConfirm(appointmentId);
  }
}
