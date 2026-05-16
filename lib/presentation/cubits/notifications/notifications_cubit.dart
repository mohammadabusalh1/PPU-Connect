import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/app_notification.dart';
import 'package:ppu_connect/domain/entities/notification_inbox.dart';
import 'package:ppu_connect/domain/repositories/notification_repository.dart';

part 'notifications_state.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repo) : super(const NotificationsInitial());

  final NotificationRepository _repo;
  StreamSubscription<NotificationInbox>? _sub;

  void watch(String userId) {
    if (userId.isEmpty) return;
    _sub?.cancel();
    emit(const NotificationsLoading());
    _sub = _repo.watchInbox(userId).listen(
      (inbox) {
        if (isClosed) return;
        emit(
          NotificationsLoaded(
            notifications: inbox.notifications,
            unreadCount: inbox.unreadCount,
          ),
        );
      },
      onError: (e) {
        if (isClosed) return;
        emit(NotificationsError(_messageFrom(e)));
      },
    );
  }

  void reset() {
    _sub?.cancel();
    _sub = null;
    emit(const NotificationsInitial());
  }

  Future<({bool ok, String? error})> markRead(String id) async {
    try {
      await _repo.markAsRead(id);
      return (ok: true, error: null);
    } catch (e) {
      return (ok: false, error: _messageFrom(e));
    }
  }

  Future<({bool ok, String? error})> markAllRead(String userId) async {
    try {
      await _repo.markAllAsRead(userId);
      return (ok: true, error: null);
    } catch (e) {
      return (ok: false, error: _messageFrom(e));
    }
  }

  String _messageFrom(Object e) =>
      e.toString().replaceFirst('Exception: ', '');

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
