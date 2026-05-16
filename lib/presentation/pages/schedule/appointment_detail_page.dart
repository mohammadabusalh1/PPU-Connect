import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/core/theme/app_colors.dart';
import 'package:ppu_connect/core/utils/appointment_list_utils.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/schedule/schedule_cubit.dart';
import 'package:ppu_connect/presentation/navigation/appointment_routes.dart';
import 'package:ppu_connect/presentation/widgets/feedback/loading_indicator.dart';
import 'package:ppu_connect/presentation/widgets/feedback/status_badge.dart';

class AppointmentDetailPage extends StatelessWidget {
  const AppointmentDetailPage({
    super.key,
    required this.appointmentId,
    this.routeScope = AppointmentRouteScope.schedule,
  });

  final String appointmentId;
  final AppointmentRouteScope routeScope;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return BlocBuilder<ScheduleCubit, ScheduleState>(
      builder: (context, state) {
        if (state is! ScheduleLoaded) {
          return const Scaffold(
            body: LoadingIndicator(),
          );
        }

        final appt =
            state.appointments.where((a) => a.id == appointmentId).firstOrNull;
        if (appt == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Appointment not found')),
          );
        }

        final authState = context.read<AuthBloc>().state;
        final myId = authState is AuthAuthenticated ? authState.user.id : '';
        final isTutor = appt.tutorId == myId;
        final peerName =
            isTutor ? (appt.seekerName ?? 'Student') : (appt.tutorName ?? 'Tutor');
        final dateFmt = DateFormat('EEEE, MMMM d, yyyy');
        final timeFmt = DateFormat('h:mm a');
        final now = DateTime.now();
        final canCancel = appt.status == AppointmentStatus.confirmed &&
            appointmentLocal(appt.endAt).isAfter(now);
        final canConfirm = appt.status == AppointmentStatus.confirmed &&
            !appointmentLocal(appt.endAt).isAfter(now);
        final accent = AppColors.accentForStatus(appt.status);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Appointment'),
            surfaceTintColor: accent.withValues(alpha: 0.08),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Status header ──────────────────────────────────────────────
              Container(
                color: accent.withValues(alpha: 0.08),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusBadge(status: appt.status),
                    const SizedBox(height: 10),
                    Text(
                      appt.subject,
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              // ── Info card + CTAs ───────────────────────────────────────────
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      child: Column(
                        children: [
                          _InfoTile(
                            icon: Icons.calendar_today_outlined,
                            label: 'Date',
                            value: dateFmt.format(appointmentLocal(appt.startAt)),
                          ),
                          Divider(
                              height: 1,
                              indent: 56,
                              color: cs.outlineVariant.withValues(alpha: 0.5)),
                          _InfoTile(
                            icon: Icons.access_time_rounded,
                            label: 'Time',
                            value:
                                '${timeFmt.format(appointmentLocal(appt.startAt))} – '
                                '${timeFmt.format(appointmentLocal(appt.endAt))}',
                          ),
                          Divider(
                              height: 1,
                              indent: 56,
                              color: cs.outlineVariant.withValues(alpha: 0.5)),
                          _InfoTile(
                            icon: Icons.person_outline_rounded,
                            label: isTutor ? 'Student' : 'Tutor',
                            value: peerName,
                          ),
                          if (appt.cancellationReason != null) ...[
                            Divider(
                                height: 1,
                                indent: 56,
                                color: cs.outlineVariant.withValues(alpha: 0.5)),
                            _InfoTile(
                              icon: Icons.info_outline_rounded,
                              label: 'Cancellation Reason',
                              value: appt.cancellationReason!,
                              iconColor: cs.error,
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (appt.status == AppointmentStatus.completed) ...[
                      FilledButton.icon(
                        icon: const Icon(Icons.rate_review_outlined),
                        label: const Text('Write a Review'),
                        onPressed: () => context.push(
                            '/reviews/write?appointmentId=${appt.id}&tutorId=${appt.tutorId}'),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (canConfirm)
                      FilledButton.icon(
                        icon: const Icon(Icons.fact_check_outlined),
                        label: const Text('Confirm Session'),
                        onPressed: () => context.push(
                          routeScope.appointmentConfirm(appt.id),
                        ),
                      ),
                    if (canConfirm) const SizedBox(height: 12),
                    if (canCancel)
                      OutlinedButton.icon(
                        icon: const Icon(Icons.cancel_outlined),
                        label: const Text('Cancel Appointment'),
                        style: OutlinedButton.styleFrom(
                            foregroundColor: cs.error,
                            side: BorderSide(
                                color: cs.error.withValues(alpha: 0.5))),
                        onPressed: () => context.push(
                          routeScope.appointmentCancel(appt.id),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return ListTile(
      leading: Icon(icon, color: iconColor ?? cs.primary, size: 22),
      title: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(color: cs.outline),
      ),
      subtitle: Text(value, style: theme.textTheme.bodyMedium),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }
}
