import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/core/constants/app_constants.dart';
import 'package:ppu_connect/core/utils/appointment_list_utils.dart';
import 'package:ppu_connect/domain/entities/appointment.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/schedule/schedule_cubit.dart';
import 'package:ppu_connect/presentation/navigation/appointment_routes.dart';
import 'package:ppu_connect/presentation/navigation/shell_tab_reselect_notifier.dart';
import 'package:ppu_connect/presentation/widgets/feedback/empty_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/history/history_appointment_card.dart';
import 'package:ppu_connect/presentation/widgets/history/interacted_users_grid.dart';
import 'package:ppu_connect/presentation/widgets/history/session_history_card.dart';
import 'package:ppu_connect/presentation/widgets/feedback/loading_indicator.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  static const _historyTabIndex = 2;

  late final TabController _tabs;
  late final ScrollController _sessionsScroll;
  late final ScrollController _appointmentsScroll;
  late final ScrollController _peopleScroll;
  final _scope = AppointmentRouteScope.history;
  ShellTabReselectNotifier? _reselectNotifier;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
    _sessionsScroll = ScrollController();
    _appointmentsScroll = ScrollController();
    _peopleScroll = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reselectNotifier = ShellTabReselectScope.maybeOf(context);
      _reselectNotifier?.addListener(_onShellReselect);
    });
  }

  void _onShellReselect() {
    if (_reselectNotifier?.lastIndex != _historyTabIndex) return;
    final controller = switch (_tabs.index) {
      0 => _sessionsScroll,
      1 => _appointmentsScroll,
      _ => _peopleScroll,
    };
    if (!controller.hasClients) return;
    controller.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _reselectNotifier?.removeListener(_onShellReselect);
    _tabs.dispose();
    _sessionsScroll.dispose();
    _appointmentsScroll.dispose();
    _peopleScroll.dispose();
    super.dispose();
  }

  void _retryWatch() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<ScheduleCubit>().watch(authState.user.id);
    }
  }

  List<InteractedPeer> _peersFrom(List<Appointment> past, bool isTutor) {
    final countMap = <String, int>{};
    final nameMap = <String, String>{};
    final roleMap = <String, bool>{};
    for (final a in past) {
      final peerId = isTutor ? a.seekerId : a.tutorId;
      final peerName =
          isTutor ? (a.seekerName ?? 'Student') : (a.tutorName ?? 'Tutor');
      countMap[peerId] = (countMap[peerId] ?? 0) + 1;
      nameMap[peerId] = peerName;
      roleMap[peerId] = !isTutor;
    }
    return countMap.entries
        .map((e) => InteractedPeer(
              id: e.key,
              name: nameMap[e.key]!,
              isTutor: roleMap[e.key]!,
              sessionCount: e.value,
            ))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final role =
        authState is AuthAuthenticated ? authState.user.role : UserRole.seeker;
    final isTutor = role == UserRole.tutor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        bottom: TabBar(
          controller: _tabs,
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(text: 'Sessions'),
            Tab(text: 'Appointments'),
            Tab(text: 'People'),
          ],
        ),
      ),
      body: BlocBuilder<ScheduleCubit, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleLoading || state is ScheduleInitial) {
            return const LoadingIndicator();
          }
          if (state is ScheduleError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: _retryWatch,
            );
          }
          if (state is ScheduleLoaded) {
            final now = DateTime.now();
            final past = state.appointments
                .where((a) => isPastAppointment(a, now))
                .toList()
              ..sort((a, b) =>
                  historySortInstant(b).compareTo(historySortInstant(a)));
            final sessions =
                past.where((a) => isSessionHistory(a, now)).toList();

            return TabBarView(
              controller: _tabs,
              children: [
                _HistoryAppointmentList(
                  scrollController: _sessionsScroll,
                  appointments: sessions,
                  isTutor: isTutor,
                  emptyTitle: 'No sessions yet',
                  emptySubtitle:
                      'Completed and ended sessions will appear here',
                  lottieAsset: AppLottie.emptySearch,
                  detailPath: (id) => _scope.sessionDetail(id),
                  showStatsStrip: true,
                  cardBuilder: (a, peerName, onTap) => SessionHistoryCard(
                    appointment: a,
                    peerName: peerName,
                    onTap: onTap,
                  ),
                ),
                _HistoryAppointmentList(
                  scrollController: _appointmentsScroll,
                  appointments: past,
                  isTutor: isTutor,
                  emptyTitle: 'No history yet',
                  emptySubtitle:
                      'Completed or cancelled sessions will appear here',
                  lottieAsset: AppLottie.emptySearch,
                  actionLabel: !isTutor ? 'Discover tutors' : null,
                  action: !isTutor ? () => context.push('/discover') : null,
                  detailPath: (id) => _scope.appointmentDetail(id),
                ),
                _PeopleTab(
                  scrollController: _peopleScroll,
                  peers: _peersFrom(past, isTutor),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ─── Stats Strip ─────────────────────────────────────────────────────────────

class _StatsStrip extends StatelessWidget {
  const _StatsStrip({required this.appointments});

  final List<Appointment> appointments;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    final completed = appointments
        .where((a) => a.status == AppointmentStatus.completed)
        .length;
    final cancelled = appointments
        .where((a) => a.status == AppointmentStatus.cancelled)
        .length;
    final totalMins = appointments
        .where((a) => a.status == AppointmentStatus.completed)
        .fold<int>(0, (sum, a) {
      return sum +
          appointmentLocal(a.endAt)
              .difference(appointmentLocal(a.startAt))
              .inMinutes;
    });
    final hoursStr = totalMins >= 60
        ? '${(totalMins / 60).toStringAsFixed(1)} hrs'
        : '$totalMins min';

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _StatChip(
              icon: Icons.check_circle_outline_rounded,
              label: '$completed completed',
              color: cs.primary,
              theme: theme,
            ),
            const SizedBox(width: 8),
            if (totalMins > 0) ...[
              _StatChip(
                icon: Icons.timer_outlined,
                label: hoursStr,
                color: cs.tertiary,
                theme: theme,
              ),
              const SizedBox(width: 8),
            ],
            if (cancelled > 0)
              _StatChip(
                icon: Icons.cancel_outlined,
                label: '$cancelled cancelled',
                color: cs.error,
                theme: theme,
              ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.theme,
  });

  final IconData icon;
  final String label;
  final Color color;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Date Pill Header ─────────────────────────────────────────────────────────

class _HistoryDateChip extends StatelessWidget {
  const _HistoryDateChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
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

// ─── Appointment List ─────────────────────────────────────────────────────────

class _HistoryAppointmentList extends StatelessWidget {
  const _HistoryAppointmentList({
    required this.scrollController,
    required this.appointments,
    required this.isTutor,
    required this.emptyTitle,
    this.emptySubtitle,
    this.lottieAsset,
    this.action,
    this.actionLabel,
    required this.detailPath,
    this.cardBuilder,
    this.showStatsStrip = false,
  });

  final ScrollController scrollController;
  final List<Appointment> appointments;
  final bool isTutor;
  final String emptyTitle;
  final String? emptySubtitle;
  final String? lottieAsset;
  final VoidCallback? action;
  final String? actionLabel;
  final String Function(String id) detailPath;
  final Widget Function(Appointment a, String peerName, VoidCallback onTap)?
      cardBuilder;
  final bool showStatsStrip;

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return EmptyStateWidget(
        title: emptyTitle,
        subtitle: emptySubtitle,
        lottieAsset: lottieAsset,
        action: action,
        actionLabel: actionLabel,
      );
    }

    final items = groupAppointmentsByPastHeader(appointments);
    var cardIndex = 0;

    return RefreshIndicator(
      onRefresh: () async {
        final authState = context.read<AuthBloc>().state;
        if (authState is AuthAuthenticated) {
          context.read<ScheduleCubit>().watch(authState.user.id);
        }
      },
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        itemCount: items.length + (showStatsStrip ? 1 : 0),
        itemBuilder: (context, i) {
          if (showStatsStrip && i == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: _StatsStrip(appointments: appointments)
                  .animate()
                  .fadeIn(duration: 300.ms),
            );
          }
          final itemIndex = showStatsStrip ? i - 1 : i;
          final item = items[itemIndex];

          if (item is String) {
            return _HistoryDateChip(label: item);
          }

          final a = item as Appointment;
          final peerName =
              isTutor ? (a.seekerName ?? 'Student') : (a.tutorName ?? 'Tutor');
          void onTap() => context.push(detailPath(a.id));
          final delay = (cardIndex * 40).ms;
          cardIndex++;

          final card = cardBuilder?.call(a, peerName, onTap) ??
              HistoryAppointmentCard(
                appointment: a,
                peerName: peerName,
                onTap: onTap,
              );

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: card
                .animate(delay: delay)
                .fadeIn(duration: 250.ms)
                .slideY(begin: 0.04, end: 0, duration: 250.ms),
          );
        },
      ),
    );
  }
}

// ─── People Tab ───────────────────────────────────────────────────────────────

class _PeopleTab extends StatelessWidget {
  const _PeopleTab({
    required this.scrollController,
    required this.peers,
  });

  final ScrollController scrollController;
  final List<InteractedPeer> peers;

  @override
  Widget build(BuildContext context) {
    if (peers.isEmpty) {
      return const EmptyStateWidget(
        title: 'No people yet',
        subtitle: 'Students and tutors you have met will appear here',
        lottieAsset: AppLottie.emptySearch,
      );
    }
    return InteractedUsersGrid(
      scrollController: scrollController,
      peers: peers,
    );
  }
}
