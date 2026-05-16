import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/appointment_requests/appointment_requests_cubit.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:shimmer/shimmer.dart';

class RequestDetailPage extends StatefulWidget {
  const RequestDetailPage({super.key, required this.requestId});

  final String requestId;

  @override
  State<RequestDetailPage> createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
  bool _acting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _watch());
  }

  void _watch() {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final cubit = context.read<AppointmentRequestsCubit>();
    final role = authState.user.role;
    if (role == UserRole.tutor || role == UserRole.both) {
      cubit.watchIncoming(authState.user.id);
    } else {
      cubit.watchSent(authState.user.id);
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Theme.of(context).colorScheme.error : null,
      ),
    );
  }

  Future<void> _handleAccept(String requestId) async {
    setState(() => _acting = true);
    final result =
        await context.read<AppointmentRequestsCubit>().accept(requestId);
    if (!mounted) return;
    setState(() => _acting = false);
    if (result.ok) {
      _showMessage('Request accepted');
      context.pop();
    } else {
      _showMessage(result.error ?? 'Failed to accept request', isError: true);
    }
  }

  Future<void> _handleReject(String requestId) async {
    setState(() => _acting = true);
    final result =
        await context.read<AppointmentRequestsCubit>().reject(requestId);
    if (!mounted) return;
    setState(() => _acting = false);
    if (result.ok) {
      _showMessage('Request rejected');
      context.pop();
    } else {
      _showMessage(result.error ?? 'Failed to reject request', isError: true);
    }
  }

  Future<void> _handleCancel(String requestId) async {
    setState(() => _acting = true);
    final result =
        await context.read<AppointmentRequestsCubit>().cancel(requestId);
    if (!mounted) return;
    setState(() => _acting = false);
    if (result.ok) {
      _showMessage('Request cancelled');
      context.pop();
    } else {
      _showMessage(result.error ?? 'Failed to cancel request', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Request Detail')),
      body: BlocBuilder<AppointmentRequestsCubit, AppointmentRequestsState>(
        builder: (context, state) {
          if (state is AppointmentRequestsLoading) {
            return _buildSkeleton(context);
          }
          if (state is AppointmentRequestsError) {
            return ErrorStateWidget(message: state.message, onRetry: _watch);
          }
          if (state is AppointmentRequestsLoaded) {
            final req =
                state.requests.where((r) => r.id == widget.requestId).firstOrNull;
            if (req == null) {
              return const Center(child: Text('Request not found'));
            }

            final authState = context.read<AuthBloc>().state;
            final myId = authState is AuthAuthenticated ? authState.user.id : '';
            final isTutor = req.tutorId == myId;
            final isPending = req.status == RequestStatus.pending;
            final dateFmt = DateFormat('EEE, MMM d, yyyy · h:mm a');

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _InfoTile(
                  icon: Icons.book_outlined,
                  label: 'Subject',
                  value: req.subject,
                ),
                _InfoTile(
                  icon: Icons.play_circle_outline,
                  label: 'Proposed Start',
                  value: dateFmt.format(req.proposedStartAt),
                ),
                _InfoTile(
                  icon: Icons.stop_circle_outlined,
                  label: 'Proposed End',
                  value: dateFmt.format(req.proposedEndAt),
                ),
                _InfoTile(
                  icon: Icons.info_outline,
                  label: 'Status',
                  value: req.status.name.toUpperCase(),
                ),
                if (req.note != null && req.note!.isNotEmpty)
                  _InfoTile(
                    icon: Icons.notes_outlined,
                    label: 'Note',
                    value: req.note!,
                  ),
                const SizedBox(height: 24),
                if (isTutor && isPending) ...[
                  FilledButton.icon(
                    icon: _acting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.check_rounded),
                    label: const Text('Accept Request'),
                    onPressed:
                        _acting ? null : () => _handleAccept(req.id),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.close_rounded),
                    label: const Text('Reject Request'),
                    style: OutlinedButton.styleFrom(foregroundColor: cs.error),
                    onPressed:
                        _acting ? null : () => _handleReject(req.id),
                  ),
                ] else if (!isTutor && isPending) ...[
                  OutlinedButton.icon(
                    icon: const Icon(Icons.cancel_outlined),
                    label: const Text('Cancel Request'),
                    style: OutlinedButton.styleFrom(foregroundColor: cs.error),
                    onPressed:
                        _acting ? null : () => _handleCancel(req.id),
                  ),
                ],
              ],
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
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: List.generate(
          4,
          (_) => Container(
            height: 60,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: theme.colorScheme.outline)),
                const SizedBox(height: 2),
                Text(value, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
