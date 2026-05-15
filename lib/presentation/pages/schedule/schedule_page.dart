import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/core/constants/app_constants.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/schedule/schedule_cubit.dart';
import 'package:ppu_connect/presentation/widgets/appointment/appointment_card.dart';
import 'package:ppu_connect/presentation/widgets/feedback/empty_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:shimmer/shimmer.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) => _watch());
  }

  void _watch() {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Schedule'),
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.send_outlined),
            tooltip: 'Sent Requests',
            onPressed: () => context.push('/requests/sent'),
          ),
        ],
      ),
      body: BlocBuilder<ScheduleCubit, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleLoading) return const _Skeleton();
          if (state is ScheduleError) {
            debugPrint('Schedule load error: ${state.message}');
            return ErrorStateWidget(
              message: state.message,
              onRetry: _watch,
            );
          }
          if (state is ScheduleLoaded) {
            final now = DateTime.now();
            final upcoming = state.appointments
                .where((a) =>
                    a.startAt.isAfter(now) &&
                    a.status != AppointmentStatus.cancelled)
                .toList()
              ..sort((a, b) => a.startAt.compareTo(b.startAt));
            final past = state.appointments
                .where((a) => a.startAt.isBefore(now) || a.status == AppointmentStatus.cancelled)
                .toList()
              ..sort((a, b) => b.startAt.compareTo(a.startAt));

            return TabBarView(
              controller: _tabs,
              children: [
                _AppointmentList(
                  appointments: upcoming,
                  emptyTitle: 'No upcoming sessions',
                  subtitle: 'Book a session and it will show up here',
                  lottieAsset: AppLottie.emptySearch,
                  actionLabel: 'Discover tutors',
                  action: () => context.push('/discover'),
                ),
                _AppointmentList(
                  appointments: past,
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

class _AppointmentList extends StatelessWidget {
  const _AppointmentList({
    required this.appointments,
    required this.emptyTitle,
    this.subtitle,
    this.lottieAsset,
    this.action,
    this.actionLabel,
  });

  final List appointments;
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
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: appointments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final a = appointments[i];
        return AppointmentCard(
          appointment: a,
          peerName: a.tutorId,
          onTap: () => context.push('/schedule/appointments/${a.id}'),
        ).animate(delay: (i * 40).ms).fadeIn(duration: 250.ms);
      },
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      baseColor: cs.surfaceContainerHighest,
      highlightColor: cs.surface,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) => Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
