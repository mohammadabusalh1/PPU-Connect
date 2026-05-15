import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/appointment_requests/appointment_requests_cubit.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:shimmer/shimmer.dart';

class RequestDetailPage extends StatelessWidget {
  const RequestDetailPage({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Request Detail')),
      body: BlocBuilder<AppointmentRequestsCubit, AppointmentRequestsState>(
        builder: (context, state) {
          if (state is AppointmentRequestsLoading) {
            return _buildSkeleton(context);
          }
          if (state is AppointmentRequestsError) {
            return ErrorStateWidget(message: state.message, onRetry: () {});
          }
          if (state is AppointmentRequestsLoaded) {
            final req = state.requests.where((r) => r.id == requestId).firstOrNull;
            if (req == null) {
              return const Center(child: Text('Request not found'));
            }

            final authState = context.read<AuthBloc>().state;
            final myId = authState is AuthAuthenticated ? authState.user.id : '';
            final isTutor = req.tutorId == myId;
            final isPending = req.status == RequestStatus.pending;
            final dateFmt = DateFormat('EEE, MMM d, yyyy · h:mm a');

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _InfoTile(
                  icon: Icons.book_outlined,
                  label: 'Subject',
                  value: req.subject,
                ),
                _InfoTile(
                  icon: Icons.play_circle_outline,
                  label: 'Proposed Start',
                  value: dateFmt.format(req.proposedStartAt),
                ),
                _InfoTile(
                  icon: Icons.stop_circle_outlined,
                  label: 'Proposed End',
                  value: dateFmt.format(req.proposedEndAt),
                ),
                _InfoTile(
                  icon: Icons.info_outline,
                  label: 'Status',
                  value: req.status.name.toUpperCase(),
                ),
                if (req.note != null && req.note!.isNotEmpty)
                  _InfoTile(
                    icon: Icons.notes_outlined,
                    label: 'Note',
                    value: req.note!,
                  ),
                const SizedBox(height: 24),
                if (isTutor && isPending) ...[
                  FilledButton.icon(
                    icon: const Icon(Icons.check_rounded),
                    label: const Text('Accept Request'),
                    onPressed: () async {
                      await context
                          .read<AppointmentRequestsCubit>()
                          .accept(req.id);
                      if (context.mounted) context.pop();
                    },
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.close_rounded),
                    label: const Text('Reject Request'),
                    style: OutlinedButton.styleFrom(foregroundColor: cs.error),
                    onPressed: () async {
                      await context
                          .read<AppointmentRequestsCubit>()
                          .reject(req.id);
                      if (context.mounted) context.pop();
                    },
                  ),
                ] else if (!isTutor && isPending) ...[
                  OutlinedButton.icon(
                    icon: const Icon(Icons.cancel_outlined),
                    label: const Text('Cancel Request'),
                    style: OutlinedButton.styleFrom(foregroundColor: cs.error),
                    onPressed: () async {
                      await context
                          .read<AppointmentRequestsCubit>()
                          .cancel(req.id);
                      if (context.mounted) context.pop();
                    },
                  ),
                ],
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      baseColor: cs.surfaceContainerHighest,
      highlightColor: cs.surface,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: List.generate(
          4,
          (_) => Container(
            height: 60,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: theme.colorScheme.outline)),
                const SizedBox(height: 2),
                Text(value, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
