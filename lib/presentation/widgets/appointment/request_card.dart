import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/domain/entities/appointment_request.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/widgets/user/user_avatar.dart';

enum RequestCardPerspective { incoming, sent }

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.request,
    this.perspective = RequestCardPerspective.incoming,
  });

  final AppointmentRequest request;
  final RequestCardPerspective perspective;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final dateFmt = DateFormat('EEE, MMM d · h:mm a');

    final (statusColor, statusLabel) = switch (request.status) {
      RequestStatus.pending => (cs.primary, 'Pending'),
      RequestStatus.accepted => (const Color(0xFF2E7D32), 'Accepted'),
      RequestStatus.rejected => (cs.error, 'Rejected'),
      RequestStatus.cancelled => (cs.outline, 'Cancelled'),
      RequestStatus.expired => (cs.outline, 'Expired'),
    };

    final isSent = perspective == RequestCardPerspective.sent;
    final displayName =
        isSent ? (request.receiverName ?? 'Tutor') : request.senderName;
    final displayAvatarUrl =
        isSent ? request.receiverAvatarUrl : request.senderAvatarUrl;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: request.id.isEmpty
            ? null
            : () => context.push('/requests/${request.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  UserAvatar(
                    name: displayName,
                    avatarUrl: displayAvatarUrl,
                    radius: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      displayName,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      request.subject,
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: statusColor.withValues(alpha: 0.4)),
                    ),
                    child: Text(
                      statusLabel,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(children: [
                Icon(Icons.calendar_today_outlined,
                    size: 14, color: cs.outline),
                const SizedBox(width: 4),
                Text(
                  dateFmt.format(request.proposedStartAt.toLocal()),
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: cs.outline),
                ),
              ]),
              if (request.note != null && request.note!.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  request.note!,
                  style: theme.textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
