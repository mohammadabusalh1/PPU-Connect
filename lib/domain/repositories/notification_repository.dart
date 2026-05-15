import 'package:ppu_connect/domain/entities/app_notification.dart';

abstract interface class NotificationRepository {
  Stream<List<AppNotification>> watchNotifications(String userId);
  Future<void> markAsRead(String notificationId);
  Future<void> markAllAsRead(String userId);
  Future<int> getUnreadCount(String userId);
}
