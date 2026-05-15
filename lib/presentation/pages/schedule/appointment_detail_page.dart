import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/schedule/schedule_cubit.dart';
import 'package:ppu_connect/presentation/widgets/feedback/status_badge.dart';

class AppointmentDetailPage extends StatelessWidget {
  const AppointmentDetailPage({super.key, required this.appointmentId});

  final String appointmentId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Appointment')),
      body: BlocBuilder<ScheduleCubit, ScheduleState>(
        builder: (context, state) {
          if (state is! ScheduleLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          final appt = state.appointments
              .where((a) => a.id == appointmentId)
              .firstOrNull;
          if (appt == null) {
            return const Center(child: Text('Appointment not found'));
          }

          final authState = context.read<AuthBloc>().state;
          final myId =
              authState is AuthAuthenticated ? authState.user.id : '';
          final dateFmt = DateFormat('EEE, MMM d, yyyy');
          final timeFmt = DateFormat('h:mm a');
          final canCancel = appt.status == AppointmentStatus.confirmed &&
              appt.startAt.isAfter(DateTime.now());

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      appt.subject,
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  StatusBadge(status: appt.status),
                ],
              ),
              const SizedBox(height: 20),
              _Row(Icons.calendar_today_outlined, 'Date',
                  dateFmt.format(appt.startAt)),
              _Row(Icons.access_time_rounded, 'Time',
                  '${timeFmt.format(appt.startAt)} – ${timeFmt.format(appt.endAt)}'),
              _Row(Icons.person_outline_rounded, 'Peer',
                  appt.tutorId == myId ? appt.seekerId : appt.tutorId),
              if (appt.cancellationReason != null)
                _Row(Icons.info_outline, 'Cancellation Reason',
                    appt.cancellationReason!),
              const SizedBox(height: 32),
              if (appt.status == AppointmentStatus.completed) ...[
                FilledButton.icon(
                  icon: const Icon(Icons.rate_review_outlined),
                  label: const Text('Write a Review'),
                  onPressed: () =>
                      context.push('/reviews/write?appointmentId=${appt.id}'),
                ),
                const SizedBox(height: 12),
              ],
              if (canCancel)
                OutlinedButton.icon(
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text('Cancel Appointment'),
                  style: OutlinedButton.styleFrom(foregroundColor: cs.error),
                  onPressed: () => context
                      .push('/schedule/appointments/${appt.id}/cancel'),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.icon, this.label, this.value);

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: theme.textTheme.labelSmall
                      ?.copyWith(color: theme.colorScheme.outline)),
              Text(value, style: theme.textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}
