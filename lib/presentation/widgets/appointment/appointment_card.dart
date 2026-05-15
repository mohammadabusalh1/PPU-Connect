import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/domain/entities/appointment.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final dateFmt = DateFormat('EEE, MMM d');
    final timeFmt = DateFormat('h:mm a');

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      appointment.subject,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  StatusBadge(status: appointment.status),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.person_outline_rounded,
                      size: 16, color: cs.outline),
                  const SizedBox(width: 4),
                  Text(
                    peerName,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: cs.outline),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.calendar_today_outlined,
                      size: 16, color: cs.outline),
                  const SizedBox(width: 4),
                  Text(
                    dateFmt.format(appointment.startAt),
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: cs.outline),
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.access_time_rounded, size: 16, color: cs.outline),
                  const SizedBox(width: 4),
                  Text(
                    '${timeFmt.format(appointment.startAt)} – ${timeFmt.format(appointment.endAt)}',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: cs.outline),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
