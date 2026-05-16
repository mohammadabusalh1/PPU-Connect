import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/core/constants/app_constants.dart';
import 'package:ppu_connect/domain/entities/app_notification.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/notifications/notifications_cubit.dart';
import 'package:ppu_connect/presentation/navigation/notification_deep_link.dart';
import 'package:ppu_connect/presentation/widgets/feedback/empty_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/notification/notification_item.dart';
import 'package:ppu_connect/presentation/widgets/feedback/loading_indicator.dart';

/// Uses [NotificationsCubit] from the shell — do not provide a second instance.
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          BlocBuilder<NotificationsCubit, NotificationsState>(
            buildWhen: (prev, curr) =>
                curr is NotificationsLoaded || prev is NotificationsLoaded,
            builder: (context, state) {
              if (state is NotificationsLoaded && state.unreadCount > 0) {
                return TextButton.icon(
                  onPressed: () => _markAllRead(context),
                  icon: const Icon(Icons.done_all_rounded, size: 16),
                  label: Text('All (${state.unreadCount})'),
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading || state is NotificationsInitial) {
            return const LoadingIndicator();
          }
          if (state is NotificationsError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () => _ensureWatching(context),
            );
          }
          if (state is NotificationsLoaded) {
            if (state.notifications.isEmpty) {
              return const EmptyStateWidget(
                lottieAsset: AppLottie.emptySearch,
                title: 'All caught up',
                subtitle: "No notifications yet — we'll let you know when something happens.",
              );
            }

            final items = _groupByDate(state.notifications);
            var cardIndex = 0;

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: items.length + (state.unreadCount > 0 ? 1 : 0),
              itemBuilder: (context, i) {
                // Unread summary chip at very top
                if (state.unreadCount > 0 && i == 0) {
                  return _UnreadChip(count: state.unreadCount)
                      .animate()
                      .fadeIn(duration: 250.ms);
                }

                final itemIndex =
                    state.unreadCount > 0 ? i - 1 : i;
                final item = items[itemIndex];

                if (item is String) {
                  return _DateChip(label: item);
                }

                final notification = item as AppNotification;
                final delay = (cardIndex * 35).ms;
                cardIndex++;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: NotificationItem(
                    notification: notification,
                    onTap: () => _onTap(context, notification),
                  )
                      .animate(delay: delay)
                      .fadeIn(duration: 240.ms)
                      .slideY(
                        begin: 0.04,
                        end: 0,
                        duration: 240.ms,
                        curve: Curves.easeOut,
                      ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _ensureWatching(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<NotificationsCubit>().watch(authState.user.id);
    }
  }

  Future<void> _markAllRead(BuildContext context) async {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final result = await context
        .read<NotificationsCubit>()
        .markAllRead(authState.user.id);
    if (!context.mounted) return;
    if (!result.ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.error ?? 'Could not mark all as read'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _onTap(
    BuildContext context,
    AppNotification notification,
  ) async {
    if (!notification.isRead) {
      final result =
          await context.read<NotificationsCubit>().markRead(notification.id);
      if (!context.mounted) return;
      if (!result.ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.error ?? 'Could not mark as read'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
    final route = NotificationDeepLink.routeFor(notification);
    if (!context.mounted) return;
    if (route != null) context.push(route);
  }
}

// ─── Date Grouping ────────────────────────────────────────────────────────────

String _dateLabel(DateTime utc) {
  final dt = utc.toLocal();
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(dt.year, dt.month, dt.day);
  final diff = today.difference(day).inDays;
  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';
  if (diff < 7) return 'This Week';
  return DateFormat('MMMM yyyy').format(dt);
}

List<Object> _groupByDate(List<AppNotification> notifications) {
  final items = <Object>[];
  String? lastLabel;
  for (final n in notifications) {
    final label = _dateLabel(n.createdAt);
    if (label != lastLabel) {
      items.add(label);
      lastLabel = label;
    }
    items.add(n);
  }
  return items;
}

// ─── Widgets ──────────────────────────────────────────────────────────────────

class _UnreadChip extends StatelessWidget {
  const _UnreadChip({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: cs.primary,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$count unread',
            style: theme.textTheme.labelMedium?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
          ),
        ),
      ),
    );
  }
}
