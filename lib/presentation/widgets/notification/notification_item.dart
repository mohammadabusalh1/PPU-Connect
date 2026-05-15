import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/domain/entities/app_notification.dart';
import 'package:ppu_connect/domain/enums/enums.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final AppNotification notification;
  final VoidCallback onTap;

  IconData _iconFor(NotificationType type) => switch (type) {
        NotificationType.appointmentRequest => Icons.person_add_alt_1_rounded,
        NotificationType.appointmentConfirmed => Icons.event_available_rounded,
        NotificationType.appointmentCancelled => Icons.event_busy_rounded,
        NotificationType.appointmentExpired => Icons.timer_off_rounded,
        NotificationType.sessionStartingSoon => Icons.notifications_active_rounded,
        NotificationType.sessionConfirmationRequired =>
          Icons.fact_check_outlined,
        NotificationType.paymentReleased => Icons.payments_rounded,
        NotificationType.paymentRefunded => Icons.currency_exchange_rounded,
        NotificationType.newReview => Icons.star_rounded,
        NotificationType.reportUpdate => Icons.flag_rounded,
        NotificationType.tutoringRequestMatch => Icons.people_alt_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final unread = !notification.isRead;

    return InkWell(
      onTap: onTap,
      child: Container(
        color: unread ? cs.primaryContainer.withValues(alpha: 0.3) : null,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor:
                  cs.primaryContainer.withValues(alpha: unread ? 0.8 : 0.4),
              child: Icon(
                _iconFor(notification.type),
                size: 20,
                color: cs.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: unread ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    notification.body,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: cs.onSurfaceVariant),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('MMM d, h:mm a').format(notification.createdAt),
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: cs.outline),
                  ),
                ],
              ),
            ),
            if (unread)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
