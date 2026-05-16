import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/core/di/injection.dart';
import 'package:ppu_connect/core/theme/app_colors.dart';
import 'package:ppu_connect/core/utils/appointment_list_utils.dart';
import 'package:ppu_connect/domain/entities/appointment.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/repositories/session_confirmation_repository.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/schedule/schedule_cubit.dart';
import 'package:ppu_connect/presentation/navigation/appointment_routes.dart';
import 'package:ppu_connect/presentation/widgets/feedback/loading_indicator.dart';
import 'package:ppu_connect/presentation/widgets/feedback/outcome_badge.dart';
import 'package:ppu_connect/presentation/widgets/feedback/status_badge.dart';

class SessionDetailPage extends StatelessWidget {
  const SessionDetailPage({
    super.key,
    required this.appointmentId,
    this.routeScope = AppointmentRouteScope.history,
  });

  final String appointmentId;
  final AppointmentRouteScope routeScope;

  static String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
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
            appBar: AppBar(title: const Text('Session')),
            body: const Center(child: Text('Session not found')),
          );
        }

        final authState = context.read<AuthBloc>().state;
        final myId = authState is AuthAuthenticated ? authState.user.id : '';
        final isTutor = appt.tutorId == myId;
        final peerName =
            isTutor ? (appt.seekerName ?? 'Student') : (appt.tutorName ?? 'Tutor');
        final accent = AppColors.accentForStatus(appt.status);
        final repo = getIt<SessionConfirmationRepository>();

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          body: StreamBuilder(
            stream: repo.watchForAppointment(appointmentId),
            builder: (context, snap) {
              final confirmation = snap.data;
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  _DetailHero(
                    appt: appt,
                    peerName: peerName,
                    isTutor: isTutor,
                    accent: accent,
                    confirmation: confirmation,
                    initials: _initials(peerName),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: _DetailInfoCard(
                      appt: appt,
                      isTutor: isTutor,
                      peerName: peerName,
                    ),
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar: _BottomActions(
            appt: appt,
            routeScope: routeScope,
          ),
        );
      },
    );
  }
}

// ─── Hero Header ──────────────────────────────────────────────────────────────

class _DetailHero extends StatelessWidget {
  const _DetailHero({
    required this.appt,
    required this.peerName,
    required this.isTutor,
    required this.accent,
    required this.initials,
    this.confirmation,
  });

  final Appointment appt;
  final String peerName;
  final bool isTutor;
  final Color accent;
  final String initials;
  final dynamic confirmation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final topPad = MediaQuery.of(context).padding.top + kToolbarHeight;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            accent.withValues(alpha: 0.18),
            accent.withValues(alpha: 0.06),
            cs.surface,
          ],
          stops: const [0.0, 0.65, 1.0],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, topPad + 12, 24, 28),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: accent.withValues(alpha: 0.5), width: 3),
                boxShadow: [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.2),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 38,
                backgroundColor: accent.withValues(alpha: 0.12),
                child: Text(
                  initials,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: accent,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              appt.subject,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isTutor ? Icons.school_outlined : Icons.person_outline_rounded,
                  size: 14,
                  color: cs.onSurfaceVariant,
                ),
                const SizedBox(width: 5),
                Text(
                  peerName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              alignment: WrapAlignment.center,
              children: [
                StatusBadge(status: appt.status),
                if (confirmation?.outcome != null)
                  OutcomeBadge(outcome: confirmation!.outcome!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Info Card ────────────────────────────────────────────────────────────────

class _DetailInfoCard extends StatelessWidget {
  const _DetailInfoCard({
    required this.appt,
    required this.isTutor,
    required this.peerName,
  });

  final Appointment appt;
  final bool isTutor;
  final String peerName;

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('EEEE, MMMM d, yyyy');
    final timeFmt = DateFormat('h:mm a');
    final startLocal = appointmentLocal(appt.startAt);
    final endLocal = appointmentLocal(appt.endAt);
    final duration = endLocal.difference(startLocal);
    final durationStr = duration.inMinutes >= 60
        ? '${duration.inHours}h ${duration.inMinutes.remainder(60)}m'
        : '${duration.inMinutes}m';

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Date',
            value: dateFmt.format(startLocal),
            isFirst: true,
          ),
          _InfoRow(
            icon: Icons.access_time_rounded,
            label: 'Time',
            value:
                '${timeFmt.format(startLocal)} – ${timeFmt.format(endLocal)}',
          ),
          _InfoRow(
            icon: Icons.hourglass_bottom_rounded,
            label: 'Duration',
            value: durationStr,
          ),
          _InfoRow(
            icon: isTutor
                ? Icons.school_outlined
                : Icons.person_outline_rounded,
            label: isTutor ? 'Student' : 'Tutor',
            value: peerName,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isFirst = false,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(
      children: [
        if (!isFirst) Divider(height: 1, indent: 56, color: cs.outlineVariant),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: cs.primaryContainer.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: cs.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Bottom Actions ───────────────────────────────────────────────────────────

class _BottomActions extends StatelessWidget {
  const _BottomActions({required this.appt, required this.routeScope});

  final Appointment appt;
  final AppointmentRouteScope routeScope;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final now = DateTime.now();

    final showReview = appt.status == AppointmentStatus.completed;
    final showConfirm = appt.status == AppointmentStatus.confirmed &&
        appointmentLocal(appt.endAt).isBefore(now);

    if (!showReview && !showConfirm) return const SizedBox.shrink();

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        decoration: BoxDecoration(
          color: cs.surface,
          border: Border(top: BorderSide(color: cs.outlineVariant, width: 0.5)),
        ),
        child: Row(
          children: [
            if (showReview)
              Expanded(
                child: FilledButton.icon(
                  icon: const Icon(Icons.rate_review_outlined),
                  label: const Text('Write a Review'),
                  onPressed: () => context.push(
                    '/reviews/write?appointmentId=${appt.id}&tutorId=${appt.tutorId}',
                  ),
                ),
              ),
            if (showReview && showConfirm) const SizedBox(width: 10),
            if (showConfirm)
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.fact_check_outlined),
                  label: const Text('Confirm Session'),
                  onPressed: () =>
                      context.push(routeScope.appointmentConfirm(appt.id)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
