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
import 'package:ppu_connect/presentation/widgets/appointment/appointment_card.dart';
import 'package:ppu_connect/presentation/widgets/appointment/appointment_section_header.dart';
import 'package:ppu_connect/presentation/widgets/feedback/empty_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/loading_indicator.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  void _retryWatch() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<ScheduleCubit>().watch(authState.user.id);
    }
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final role =
        authState is AuthAuthenticated ? authState.user.role : UserRole.seeker;
    final isTutor = role == UserRole.tutor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Schedule'),
        bottom: TabBar(
          controller: _tabs,
          dividerColor: Colors.transparent,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
          ],
        ),
        actions: [
          if (!isTutor)
            IconButton(
              icon: const Icon(Icons.send_outlined),
              tooltip: 'Sent Requests',
              onPressed: () => context.push('/requests/sent'),
            ),
        ],
      ),
      body: BlocBuilder<ScheduleCubit, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleLoading || state is ScheduleInitial) {
            return const LoadingIndicator();
          }
          if (state is ScheduleError) {
            return ErrorStateWidget(message: state.message, onRetry: _retryWatch);
          }
          if (state is ScheduleLoaded) {
            final now = DateTime.now();
            final upcoming = state.appointments
                .where((a) => isUpcomingAppointment(a, now))
                .toList()
              ..sort((a, b) => a.startAt.compareTo(b.startAt));
            final past = state.appointments
                .where((a) => isPastAppointment(a, now))
                .toList()
              ..sort((a, b) =>
                  historySortInstant(b).compareTo(historySortInstant(a)));

            return TabBarView(
              controller: _tabs,
              children: [
                _AppointmentList(
                  appointments: upcoming,
                  isTutor: isTutor,
                  isUpcoming: true,
                  emptyTitle: 'No upcoming sessions',
                  subtitle: isTutor
                      ? 'Accepted requests will appear here'
                      : 'Book a session and it will show up here',
                  lottieAsset: AppLottie.emptySearch,
                  actionLabel: !isTutor ? 'Discover tutors' : null,
                  action: !isTutor ? () => context.push('/discover') : null,
                ),
                _AppointmentList(
                  appointments: past,
                  isTutor: isTutor,
                  isUpcoming: false,
                  emptyTitle: 'No past sessions',
                  subtitle: 'Completed or cancelled sessions will appear here',
                  lottieAsset: AppLottie.emptySearch,
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

// ── List with date-group section headers ────────────────────────────────────

class _AppointmentList extends StatelessWidget {
  const _AppointmentList({
    required this.appointments,
    required this.isTutor,
    required this.isUpcoming,
    required this.emptyTitle,
    this.subtitle,
    this.lottieAsset,
    this.action,
    this.actionLabel,
  });

  final List<Appointment> appointments;
  final bool isTutor;
  final bool isUpcoming;
  final String emptyTitle;
  final String? subtitle;
  final String? lottieAsset;
  final VoidCallback? action;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return EmptyStateWidget(
        title: emptyTitle,
        subtitle: subtitle,
        lottieAsset: lottieAsset,
        action: action,
        actionLabel: actionLabel,
      );
    }

    final items = isUpcoming
        ? groupAppointmentsByUpcomingHeader(appointments)
        : groupAppointmentsByPastHeader(appointments);

    var cardIndex = 0;

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final item = items[i];
        if (item is String) {
          return AppointmentSectionHeader(label: item);
        }
        final appt = item as Appointment;
        final peerName =
            isTutor ? (appt.seekerName ?? 'Student') : (appt.tutorName ?? 'Tutor');
        final delay = (cardIndex * 30).ms;
        cardIndex++;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: AppointmentCard(
            appointment: appt,
            peerName: peerName,
            onTap: () => context.push(
              AppointmentRouteScope.schedule.appointmentDetail(appt.id),
            ),
          ).animate(delay: delay).fadeIn(duration: 220.ms).slideY(
                begin: 0.04,
                end: 0,
                duration: 220.ms,
                curve: Curves.easeOut,
              ),
        );
      },
    );
  }

}
