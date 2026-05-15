import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/presentation/cubits/tutoring_requests/tutoring_requests_cubit.dart';
import 'package:ppu_connect/presentation/widgets/feedback/empty_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:shimmer/shimmer.dart';

class BrowseTutoringRequestsPage extends StatefulWidget {
  const BrowseTutoringRequestsPage({super.key});

  @override
  State<BrowseTutoringRequestsPage> createState() =>
      _BrowseTutoringRequestsPageState();
}

class _BrowseTutoringRequestsPageState
    extends State<BrowseTutoringRequestsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TutoringRequestsCubit>().loadOpen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Open Tutoring Requests')),
      body: BlocBuilder<TutoringRequestsCubit, TutoringRequestsState>(
        builder: (context, state) {
          if (state is TutoringRequestsLoading) return _buildSkeleton(context);
          if (state is TutoringRequestsError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () =>
                  context.read<TutoringRequestsCubit>().loadOpen(),
            );
          }
          if (state is TutoringRequestsLoaded) {
            if (state.requests.isEmpty) {
              return const EmptyStateWidget(
                title: 'No open requests',
                subtitle: 'Check back later for new tutoring requests',
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.requests.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final r = state.requests[i];
                return Card(
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () =>
                        context.push('/discover/tutoring-requests/${r.id}'),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r.subject,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            r.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Posted ${DateFormat('MMM d').format(r.createdAt)}',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outline,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
