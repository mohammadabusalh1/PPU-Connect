import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ppu_connect/domain/entities/app_notification.dart';
import 'package:ppu_connect/domain/entities/notification_inbox.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/repositories/notification_repository.dart';
import 'package:ppu_connect/presentation/cubits/notifications/notifications_cubit.dart';

class _MockNotificationRepository extends Mock
    implements NotificationRepository {}

AppNotification _notification() => AppNotification(
      id: 'n1',
      userId: 'user1',
      type: NotificationType.appointmentRequest,
      title: 'Title',
      body: 'Body',
      payload: const {},
      isRead: false,
      createdAt: DateTime.utc(2030, 1, 1),
    );

void main() {
  late _MockNotificationRepository repo;

  setUp(() {
    repo = _MockNotificationRepository();
  });

  test('initial state is NotificationsInitial', () {
    final cubit = NotificationsCubit(repo);
    expect(cubit.state, isA<NotificationsInitial>());
    cubit.close();
  });

  blocTest<NotificationsCubit, NotificationsState>(
    'emits loaded with authoritative unread count',
    build: () {
      when(() => repo.watchInbox('user1')).thenAnswer(
        (_) => Stream.value(
          NotificationInbox(
            notifications: [_notification()],
            unreadCount: 3,
          ),
        ),
      );
      return NotificationsCubit(repo);
    },
    act: (cubit) => cubit.watch('user1'),
    expect: () => [
      isA<NotificationsLoading>(),
      predicate<NotificationsLoaded>(
        (s) => s.notifications.length == 1 && s.unreadCount == 3,
      ),
    ],
  );

  test('markRead returns ok:false on failure without changing state', () async {
    when(() => repo.markAsRead('n1'))
        .thenThrow(Exception('permission-denied'));
    final cubit = NotificationsCubit(repo);

    final result = await cubit.markRead('n1');

    expect(result.ok, isFalse);
    expect(result.error, 'permission-denied');
    expect(cubit.state, isA<NotificationsInitial>());
    await cubit.close();
  });

  test('reset cancels subscription and returns to initial', () async {
    final controller = StreamController<NotificationInbox>();
    when(() => repo.watchInbox('user1')).thenAnswer((_) => controller.stream);
    final cubit = NotificationsCubit(repo)..watch('user1');

    cubit.reset();

    expect(cubit.state, isA<NotificationsInitial>());
    await controller.close();
    await cubit.close();
  });
}
