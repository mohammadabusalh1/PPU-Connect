import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/core/theme/app_colors.dart';
import 'package:ppu_connect/core/utils/appointment_list_utils.dart';
import 'package:ppu_connect/domain/entities/appointment.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/widgets/feedback/status_badge.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.peerName,
    this.peerAvatarUrl,
    required this.onTap,
  });

  final Appointment appointment;
  final String peerName;
  final String? peerAvatarUrl;
  final VoidCallback onTap;

  static String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final dateFmt = DateFormat('EEE, MMM d');
    final timeFmt = DateFormat('h:mm a');
    final accent = AppColors.accentForStatus(appointment.status);
    final isCancelled = appointment.status == AppointmentStatus.cancelled;

    return Opacity(
      opacity: isCancelled ? 0.7 : 1,
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: onTap,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            // Status accent bar
            Container(width: 4, color: accent),
            const SizedBox(width: 12),
            // Peer avatar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: CircleAvatar(
                radius: 22,
                backgroundColor: accent.withValues(alpha: 0.12),
                child: Text(
                  _initials(peerName),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            appointment.subject,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              decoration: isCancelled
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        StatusBadge(status: appointment.status),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.person_outline_rounded,
                            size: 13, color: cs.outline),
                        const SizedBox(width: 4),
                        Text(
                          peerName,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(Icons.schedule_rounded,
                            size: 13, color: cs.outline),
                        const SizedBox(width: 4),
                        Text(
                          dateFmt.format(appointmentLocal(appointment.startAt)),
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: cs.onSurfaceVariant),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text('·',
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(color: cs.outline)),
                        ),
                        Flexible(
                          child: Text(
                            '${timeFmt.format(appointmentLocal(appointment.startAt))} – '
                            '${timeFmt.format(appointmentLocal(appointment.endAt))}',
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: cs.onSurfaceVariant),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Forward indicator
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(Icons.chevron_right_rounded,
                  size: 20, color: cs.onSurfaceVariant),
            ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}
