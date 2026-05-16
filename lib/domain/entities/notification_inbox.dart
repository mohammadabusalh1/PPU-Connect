import 'package:ppu_connect/domain/entities/app_notification.dart';

/// Notifications list plus authoritative unread count from Firestore.
class NotificationInbox {
  const NotificationInbox({
    required this.notifications,
    required this.unreadCount,
  });

  final List<AppNotification> notifications;
  final int unreadCount;
}
