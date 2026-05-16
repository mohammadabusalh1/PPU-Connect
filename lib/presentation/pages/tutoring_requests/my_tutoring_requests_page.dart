import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/tutoring_requests/tutoring_requests_cubit.dart';
import 'package:ppu_connect/presentation/widgets/feedback/empty_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/loading_indicator.dart';

class MyTutoringRequestsPage extends StatefulWidget {
  const MyTutoringRequestsPage({super.key});

  @override
  State<MyTutoringRequestsPage> createState() =>
      _MyTutoringRequestsPageState();
}

class _MyTutoringRequestsPageState extends State<MyTutoringRequestsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _watch());
  }

  void _watch() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<TutoringRequestsCubit>().watchMy(authState.user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tutoring Requests')),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Request'),
        onPressed: () => context.push('/tutoring-requests/create'),
      ),
      body: BlocBuilder<TutoringRequestsCubit, TutoringRequestsState>(
        builder: (context, state) {
          if (state is TutoringRequestsLoading) return const LoadingIndicator();
          if (state is TutoringRequestsError) {
            return ErrorStateWidget(message: state.message, onRetry: _watch);
          }
          if (state is TutoringRequestsLoaded) {
            if (state.requests.isEmpty) {
              return const EmptyStateWidget(
                title: 'No tutoring requests',
                subtitle: 'Post a request to find a tutor',
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
              itemCount: state.requests.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final r = state.requests[i];
                return Card(
                  clipBehavior: Clip.hardEdge,
                  child: ListTile(
                    title: Text(r.subject,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    subtitle: Text(
                        DateFormat('MMM d, yyyy').format(r.createdAt)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Chip(
                          label: Text(r.status.name),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    onTap: () =>
                        context.push('/tutoring-requests/${r.id}'),
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
}
