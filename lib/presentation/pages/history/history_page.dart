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

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _watch());
  }

  void _watch() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<ScheduleCubit>().watch(authState.user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: BlocBuilder<ScheduleCubit, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleLoading) return _buildSkeleton(context);
          if (state is ScheduleError) {
            debugPrint('Schedule load error: ${state.message}');
            return ErrorStateWidget(message: state.message, onRetry: _watch);
          }
          if (state is ScheduleLoaded) {
            final past = state.appointments
                .where((a) =>
                    a.startAt.isBefore(DateTime.now()) ||
                    a.status == AppointmentStatus.cancelled ||
                    a.status == AppointmentStatus.completed)
                .toList()
              ..sort((a, b) => b.startAt.compareTo(a.startAt));

            if (past.isEmpty) {
              return EmptyStateWidget(
                title: 'No history yet',
                subtitle: 'Completed or cancelled sessions will appear here',
                lottieAsset: AppLottie.emptySearch,
                actionLabel: 'Discover tutors',
                action: () => context.push('/discover'),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: past.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final a = past[i];
                return AppointmentCard(
                  appointment: a,
                  peerName: a.tutorId,
                  onTap: () =>
                      context.push('/schedule/appointments/${a.id}'),
                ).animate(delay: (i * 40).ms).fadeIn(duration: 250.ms);
              },
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
