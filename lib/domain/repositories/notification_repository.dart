import 'package:ppu_connect/domain/entities/app_notification.dart';
import 'package:ppu_connect/domain/entities/notification_inbox.dart';

abstract interface class NotificationRepository {
  Stream<NotificationInbox> watchInbox(String userId);
  Future<void> createNotification(AppNotification notification);
  Future<void> markAsRead(String notificationId);
  Future<void> markAllAsRead(String userId);
  Future<int> getUnreadCount(String userId);
}
