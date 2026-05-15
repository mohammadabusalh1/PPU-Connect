part of 'notifications_cubit.dart';

sealed class NotificationsState {
  const NotificationsState();
}

final class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

final class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();
}

final class NotificationsLoaded extends NotificationsState {
  const NotificationsLoaded({required this.notifications});
  final List<AppNotification> notifications;
  int get unreadCount => notifications.where((n) => !n.isRead).length;
}

final class NotificationsError extends NotificationsState {
  const NotificationsError(this.message);
  final String message;
}
