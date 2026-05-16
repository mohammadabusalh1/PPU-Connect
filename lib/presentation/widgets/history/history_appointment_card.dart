import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/core/theme/app_colors.dart';
import 'package:ppu_connect/core/utils/appointment_list_utils.dart';
import 'package:ppu_connect/domain/entities/appointment.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/widgets/feedback/outcome_badge.dart';
import 'package:ppu_connect/presentation/widgets/feedback/status_badge.dart';

class HistoryAppointmentCard extends StatefulWidget {
  const HistoryAppointmentCard({
    super.key,
    required this.appointment,
    required this.peerName,
    required this.onTap,
    this.outcome,
  });

  final Appointment appointment;
  final String peerName;
  final VoidCallback onTap;
  final SessionOutcome? outcome;

  static String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  State<HistoryAppointmentCard> createState() => _HistoryAppointmentCardState();
}

class _HistoryAppointmentCardState extends State<HistoryAppointmentCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final dateFmt = DateFormat('EEE, MMM d');
    final timeFmt = DateFormat('h:mm a');
    final accent = AppColors.accentForStatus(widget.appointment.status);
    final isCancelled = widget.appointment.status == AppointmentStatus.cancelled;

    return AnimatedScale(
      scale: _pressed ? 0.975 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: Opacity(
        opacity: isCancelled ? 0.68 : 1.0,
        child: Material(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          elevation: 0,
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
                    Container(
                      width: 4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [accent, accent.withValues(alpha: 0.3)],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 14, 10, 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: accent.withValues(alpha: 0.45),
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: accent.withValues(alpha: 0.1),
                                child: Text(
                                  HistoryAppointmentCard._initials(widget.peerName),
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    color: accent,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.appointment.subject,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      decoration: isCancelled
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.person_outline_rounded,
                                          size: 12, color: cs.outline),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          widget.peerName,
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                  color: cs.onSurfaceVariant),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Icon(Icons.schedule_rounded,
                                          size: 12, color: cs.outline),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          '${dateFmt.format(appointmentLocal(widget.appointment.startAt))}'
                                          ' · ${timeFmt.format(appointmentLocal(widget.appointment.startAt))}'
                                          '–${timeFmt.format(appointmentLocal(widget.appointment.endAt))}',
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: cs.onSurfaceVariant,
                                            fontSize: 11,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 6,
                                    runSpacing: 4,
                                    children: [
                                      StatusBadge(
                                          status: widget.appointment.status),
                                      if (widget.outcome != null)
                                        OutcomeBadge(outcome: widget.outcome!),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Icon(
                                Icons.chevron_right_rounded,
                                size: 20,
                                color: cs.outlineVariant,
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
      ),
    );
  }
}
