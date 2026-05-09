import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/enums.dart';

part 'app_notification.freezed.dart';

@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String userId,
    required NotificationType type,
    required String title,
    required String body,
    required Map<String, String> payload,
    required bool isRead,
    DateTime? readAt,
    required DateTime createdAt,
  }) = _AppNotification;
}
