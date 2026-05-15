import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/app_notification.dart';
import 'package:ppu_connect/domain/repositories/notification_repository.dart';

part 'notifications_state.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repo) : super(const NotificationsInitial());
  final NotificationRepository _repo;
  StreamSubscription<List<AppNotification>>? _sub;

  void watch(String userId) {
    _sub?.cancel();
    emit(const NotificationsLoading());
    _sub = _repo.watchNotifications(userId).listen(
      (list) {
        if (isClosed) return;
        emit(NotificationsLoaded(notifications: list));
      },
      onError: (e) {
        if (isClosed) return;
        emit(NotificationsError(e.toString().replaceFirst('Exception: ', '')));
      },
    );
  }

  Future<void> markRead(String id) => _repo.markAsRead(id);
  Future<void> markAllRead(String userId) => _repo.markAllAsRead(userId);

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
