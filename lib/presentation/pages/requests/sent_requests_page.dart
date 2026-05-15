import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/appointment_requests/appointment_requests_cubit.dart';
import 'package:ppu_connect/presentation/widgets/appointment/request_card.dart';
import 'package:ppu_connect/presentation/widgets/feedback/empty_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:shimmer/shimmer.dart';

class SentRequestsPage extends StatefulWidget {
  const SentRequestsPage({super.key});

  @override
  State<SentRequestsPage> createState() => _SentRequestsPageState();
}

class _SentRequestsPageState extends State<SentRequestsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _watch());
  }

  void _watch() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<AppointmentRequestsCubit>().watchSent(authState.user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sent Requests')),
      body: BlocBuilder<AppointmentRequestsCubit, AppointmentRequestsState>(
        builder: (context, state) {
          if (state is AppointmentRequestsLoading) return const _Skeleton();
          if (state is AppointmentRequestsError) {
            return ErrorStateWidget(message: state.message, onRetry: _watch);
          }
          if (state is AppointmentRequestsLoaded) {
            if (state.requests.isEmpty) {
              return const EmptyStateWidget(
                title: 'No sent requests',
                subtitle: 'Browse tutors and request a session',
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.requests.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) => RequestCard(request: state.requests[i])
                  .animate(delay: (i * 40).ms)
                  .fadeIn(duration: 250.ms),
            );
          }
          return const SizedBox.shrink();
        },
      ),
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
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) => Container(
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
