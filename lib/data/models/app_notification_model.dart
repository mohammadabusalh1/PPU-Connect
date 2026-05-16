import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/firestore_converters.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/enums/enums.dart';

part 'app_notification_model.freezed.dart';
part 'app_notification_model.g.dart';

@freezed
class AppNotificationModel with _$AppNotificationModel {
  const factory AppNotificationModel({
    required String id,
    required String userId,
    @NotificationTypeConverter() required NotificationType type,
    required String title,
    required String body,
    @StringMapConverter() @Default({}) Map<String, String> payload,
    required bool isRead,
    @NullableTimestampConverter() DateTime? readAt,
    @TimestampConverter() required DateTime createdAt,
  }) = _AppNotificationModel;

  factory AppNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationModelFromJson(json);

  factory AppNotificationModel.fromEntity(AppNotification entity) =>
      AppNotificationModel(
        id: entity.id,
        userId: entity.userId,
        type: entity.type,
        title: entity.title,
        body: entity.body,
        payload: Map<String, String>.from(entity.payload),
        isRead: entity.isRead,
        readAt: entity.readAt,
        createdAt: entity.createdAt,
      );
}

extension AppNotificationModelX on AppNotificationModel {
  AppNotification toEntity() => AppNotification(
        id: id,
        userId: userId,
        type: type,
        title: title,
        body: body,
        payload: payload,
        isRead: isRead,
        readAt: readAt,
        createdAt: createdAt,
      );
}
