import 'package:ppu_connect/domain/entities/app_notification.dart';

/// Validation for in-app notifications (see MODELS.md).
abstract final class AppNotificationRules {
  static const maxTitleLength = 100;
  static const maxBodyLength = 300;

  static String? validateForCreate(AppNotification notification) {
    if (notification.userId.isEmpty) return 'Recipient is required';
    if (notification.title.trim().isEmpty) return 'Title is required';
    if (notification.title.length > maxTitleLength) {
      return 'Title must be $maxTitleLength characters or fewer';
    }
    if (notification.body.trim().isEmpty) return 'Body is required';
    if (notification.body.length > maxBodyLength) {
      return 'Body must be $maxBodyLength characters or fewer';
    }
    return null;
  }
}
