import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/datasources/notification_remote_data_source.dart';
import 'package:ppu_connect/data/models/app_notification_model.dart';
import 'package:ppu_connect/domain/entities/app_notification.dart';
import 'package:ppu_connect/domain/entities/notification_inbox.dart';
import 'package:ppu_connect/domain/repositories/notification_repository.dart';
import 'package:ppu_connect/domain/validators/app_notification_rules.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  const NotificationRepositoryImpl(this._ds);

  final NotificationRemoteDataSource _ds;

  @override
  Stream<NotificationInbox> watchInbox(String userId) async* {
    await for (final models in _ds.watchNotifications(userId)) {
      final notifications = models.map((m) => m.toEntity()).toList();
      final unreadCount = await _ds.getUnreadCount(userId);
      yield NotificationInbox(
        notifications: notifications,
        unreadCount: unreadCount,
      );
    }
  }

  @override
  Future<void> createNotification(AppNotification notification) async {
    final error = AppNotificationRules.validateForCreate(notification);
    if (error != null) throw Exception(error);
    await _ds.createNotification(AppNotificationModel.fromEntity(notification));
  }

  @override
  Future<void> markAsRead(String notificationId) =>
      _ds.markAsRead(notificationId);

  @override
  Future<void> markAllAsRead(String userId) => _ds.markAllAsRead(userId);

  @override
  Future<int> getUnreadCount(String userId) => _ds.getUnreadCount(userId);
}
