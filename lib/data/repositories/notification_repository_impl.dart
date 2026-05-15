import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/datasources/notification_remote_data_source.dart';
import 'package:ppu_connect/data/models/app_notification_model.dart';
import 'package:ppu_connect/domain/entities/app_notification.dart';
import 'package:ppu_connect/domain/repositories/notification_repository.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  const NotificationRepositoryImpl(this._ds);
  final NotificationRemoteDataSource _ds;

  @override
  Stream<List<AppNotification>> watchNotifications(String userId) => _ds
      .watchNotifications(userId)
      .map((list) => list.map((m) => m.toEntity()).toList());

  @override
  Future<void> markAsRead(String notificationId) => _ds.markAsRead(notificationId);

  @override
  Future<void> markAllAsRead(String userId) => _ds.markAllAsRead(userId);

  @override
  Future<int> getUnreadCount(String userId) => _ds.getUnreadCount(userId);
}
