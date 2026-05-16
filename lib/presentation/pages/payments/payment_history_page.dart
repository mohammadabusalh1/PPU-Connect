import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/payments/payments_cubit.dart';
import 'package:ppu_connect/presentation/pages/payments/payments_scope.dart';
import 'package:ppu_connect/presentation/widgets/feedback/empty_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:shimmer/shimmer.dart';

class PaymentHistoryPage extends StatelessWidget {
  const PaymentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PaymentsScope(child: _PaymentHistoryView());
  }
}

class _PaymentHistoryView extends StatefulWidget {
  const _PaymentHistoryView();

  @override
  State<_PaymentHistoryView> createState() => _PaymentHistoryViewState();
}

class _PaymentHistoryViewState extends State<_PaymentHistoryView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  void _load() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<PaymentsCubit>().load(authState.user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment History')),
      body: BlocBuilder<PaymentsCubit, PaymentsState>(
        builder: (context, state) {
          if (state is PaymentsLoading) return _buildSkeleton(context);
          if (state is PaymentsError) {
            debugPrint('Payments load error: ${state.message}');
            return ErrorStateWidget(message: state.message, onRetry: _load);
          }
          if (state is PaymentsLoaded) {
            if (state.payments.isEmpty) {
              return const EmptyStateWidget(
                title: 'No payments',
                subtitle: 'Completed sessions will appear here',
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.payments.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final p = state.payments[i];
                final dateFmt = DateFormat('MMM d, yyyy');
                final (statusColor, statusLabel) = switch (p.status) {
                  PaymentStatus.pending => (
                      const Color(0xFFF57F17),
                      'Pending'
                    ),
                  PaymentStatus.held => (const Color(0xFFF57F17), 'Held'),
                  PaymentStatus.released => (
                      const Color(0xFF2E7D32),
                      'Released'
                    ),
                  PaymentStatus.refunded => (
                      Theme.of(context).colorScheme.primary,
                      'Refunded'
                    ),
                };
                return Card(
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () => context.push('/payments/${p.id}'),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            statusColor.withValues(alpha: 0.15),
                        child: Icon(Icons.payments_outlined,
                            color: statusColor),
                      ),
                      title: Text(
                          '${p.currency} ${p.amount.toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      subtitle: Text(dateFmt.format(p.createdAt)),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          statusLabel,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
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
