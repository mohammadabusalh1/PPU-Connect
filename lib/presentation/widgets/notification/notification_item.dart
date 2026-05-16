import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/core/theme/app_colors.dart';
import 'package:ppu_connect/domain/entities/app_notification.dart';
import 'package:ppu_connect/domain/enums/enums.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final AppNotification notification;
  final VoidCallback onTap;

  static (IconData, Color) styleFor(NotificationType type) => switch (type) {
        NotificationType.appointmentRequest => (
          Icons.person_add_alt_1_rounded,
          AppColors.seeker
        ),
        NotificationType.appointmentConfirmed => (
          Icons.event_available_rounded,
          AppColors.confirmed
        ),
        NotificationType.appointmentCancelled => (
          Icons.event_busy_rounded,
          AppColors.error
        ),
        NotificationType.appointmentExpired => (
          Icons.timer_off_rounded,
          AppColors.expired
        ),
        NotificationType.sessionStartingSoon => (
          Icons.notifications_active_rounded,
          AppColors.warning
        ),
        NotificationType.sessionConfirmationRequired => (
          Icons.fact_check_outlined,
          AppColors.warning
        ),
        NotificationType.paymentReleased => (
          Icons.payments_rounded,
          AppColors.released
        ),
        NotificationType.paymentRefunded => (
          Icons.currency_exchange_rounded,
          AppColors.refunded
        ),
        NotificationType.newReview => (Icons.star_rounded, AppColors.gold),
        NotificationType.reportUpdate => (
          Icons.flag_rounded,
          AppColors.warning
        ),
        NotificationType.tutoringRequestMatch => (
          Icons.people_alt_rounded,
          AppColors.both
        ),
      };

  static String relativeTime(DateTime utc) {
    final dt = utc.toLocal();
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM d').format(dt);
  }

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final unread = !widget.notification.isRead;
    final (icon, color) = NotificationItem.styleFor(widget.notification.type);

    return AnimatedScale(
      scale: _pressed ? 0.975 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: Material(
        color: unread
            ? color.withValues(alpha: 0.06)
            : cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTapDown: (_) {
            setState(() => _pressed = true);
            HapticFeedback.lightImpact();
          },
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          onTap: widget.onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Gradient accent band — unread only, RTL-aware via Row start
                  if (unread)
                    Container(
                      width: 4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [color, color.withValues(alpha: 0.3)],
                        ),
                      ),
                    ),
                  // Content
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        unread ? 12 : 16, 14, 12, 14,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Type icon in rounded container
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(icon, size: 20, color: color),
                          ),
                          const SizedBox(width: 12),
                          // Title + body
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.notification.title,
                                        style: theme.textTheme.titleSmall
                                            ?.copyWith(
                                          fontWeight: unread
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          NotificationItem.relativeTime(
                                              widget.notification.createdAt),
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
                                            color: unread
                                                ? color
                                                : cs.outline,
                                            fontWeight: unread
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                          ),
                                        ),
                                        if (unread) ...[
                                          const SizedBox(height: 5),
                                          Container(
                                            width: 7,
                                            height: 7,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: color,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.notification.body,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: cs.onSurfaceVariant,
                                    height: 1.4,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
