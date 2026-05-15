import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/core/theme/app_colors.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/reports/reports_cubit.dart';
import 'package:ppu_connect/presentation/widgets/feedback/empty_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:shimmer/shimmer.dart';

class MyReportsPage extends StatefulWidget {
  const MyReportsPage({super.key});

  @override
  State<MyReportsPage> createState() => _MyReportsPageState();
}

class _MyReportsPageState extends State<MyReportsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  void _load() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<ReportsCubit>().watchMy(authState.user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Reports')),
      body: BlocBuilder<ReportsCubit, ReportsState>(
        builder: (context, state) {
          if (state is ReportsLoading) return _buildSkeleton(context);
          if (state is ReportsError) {
            return ErrorStateWidget(message: state.message, onRetry: _load);
          }
          if (state is ReportsLoaded) {
            if (state.reports.isEmpty) {
              return const EmptyStateWidget(
                title: 'No reports',
                subtitle: "You haven't submitted any reports",
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.reports.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final r = state.reports[i];
                final (color, label) = switch (r.status) {
                  ReportStatus.open => (AppColors.pending, 'Open'),
                  ReportStatus.underReview => (AppColors.info, 'Under Review'),
                  ReportStatus.resolved => (AppColors.completed, 'Resolved'),
                  ReportStatus.dismissed => (AppColors.expired, 'Dismissed'),
                };
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: color.withValues(alpha: 0.15),
                      child: Icon(Icons.flag_rounded, color: color),
                    ),
                    title: Text(
                      _reasonLabel(r.reason),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      DateFormat('MMM d, yyyy').format(r.createdAt),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        label,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(
                              color: color,
                              fontWeight: FontWeight.w600,
                            ),
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

  String _reasonLabel(ReportReason r) => switch (r) {
        ReportReason.noShow => 'No Show',
        ReportReason.inappropriateBehavior => 'Inappropriate Behavior',
        ReportReason.harassment => 'Harassment',
        ReportReason.fraud => 'Fraud',
        ReportReason.fakeProfile => 'Fake Profile',
        ReportReason.other => 'Other',
      };

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
          height: 72,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
