import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/core/di/injection.dart';
import 'package:ppu_connect/domain/entities/payment.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/repositories/payment_repository.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/loading_indicator.dart';

class PaymentDetailPage extends StatelessWidget {
  const PaymentDetailPage({super.key, required this.paymentId});

  final String paymentId;

  @override
  Widget build(BuildContext context) {
    return _PaymentDetailView(paymentId: paymentId);
  }
}

class _PaymentDetailView extends StatefulWidget {
  const _PaymentDetailView({required this.paymentId});
  final String paymentId;

  @override
  State<_PaymentDetailView> createState() => _PaymentDetailViewState();
}

class _PaymentDetailViewState extends State<_PaymentDetailView> {
  Payment? _payment;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final payment = await getIt<PaymentRepository>().getPaymentById(widget.paymentId);
      if (!mounted) return;
      setState(() { _payment = payment; _loading = false; });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Detail')),
      body: Builder(builder: (context) {
        if (_loading) return const LoadingIndicator();
        if (_error != null) {
          return ErrorStateWidget(message: _error!, onRetry: _load);
        }
        if (_payment == null) {
          return const Center(child: Text('Payment not found'));
        }
        return _PaymentDetail(
          payment: _payment!,
          onRefundSuccess: (updated) => setState(() => _payment = updated),
        );
      }),
    );
  }
}

class _PaymentDetail extends StatelessWidget {
  const _PaymentDetail({required this.payment, required this.onRefundSuccess});
  final Payment payment;
  final ValueChanged<Payment> onRefundSuccess;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fmt = NumberFormat.currency(symbol: payment.currency, decimalDigits: 2);
    final dateFmt = DateFormat('MMM d, yyyy • h:mm a');

    final (statusColor, statusLabel) = switch (payment.status) {
      PaymentStatus.pending => (const Color(0xFFF57F17), 'Pending'),
      PaymentStatus.held => (const Color(0xFFF57F17), 'Held'),
      PaymentStatus.released => (const Color(0xFF2E7D32), 'Released'),
      PaymentStatus.refunded => (theme.colorScheme.primary, 'Refunded'),
    };

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // Amount hero
        Center(
          child: Column(
            children: [
              Text(
                fmt.format(payment.amount),
                style: theme.textTheme.displaySmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusLabel,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Card info
        Card(
          child: ListTile(
            leading: const Icon(Icons.credit_card_outlined),
            title: Text(payment.cardBrand),
            subtitle:
                Text('•••• •••• •••• ${payment.cardLast4}'),
          ),
        ),
        const SizedBox(height: 12),

        // Info rows
        Card(
          child: Column(
            children: [
              _InfoTile(
                label: 'Date',
                value: dateFmt.format(payment.createdAt.toLocal()),
              ),
              if (payment.appointmentId != null)
                _InfoTile(
                  label: 'Appointment',
                  value: payment.appointmentId!,
                ),
              if (payment.refundRequestedAt != null)
                _InfoTile(
                  label: 'Refund Requested',
                  value: dateFmt
                      .format(payment.refundRequestedAt!.toLocal()),
                ),
              if (payment.refundReason != null)
                _InfoTile(
                  label: 'Refund Reason',
                  value: payment.refundReason!,
                ),
            ],
          ),
        ),

        // Refund action
        if (payment.status == PaymentStatus.held) ...[
          const SizedBox(height: 24),
          OutlinedButton.icon(
            icon: const Icon(Icons.undo_rounded),
            label: const Text('Request Refund'),
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.colorScheme.error,
              side: BorderSide(color: theme.colorScheme.error),
            ),
            onPressed: () => _showRefundDialog(context),
          ),
        ],
      ],
    );
  }

  Future<void> _showRefundDialog(BuildContext context) async {
    final reasonCtrl = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Request Refund'),
        content: TextField(
          controller: reasonCtrl,
          decoration: const InputDecoration(
            labelText: 'Reason',
            hintText: 'Why are you requesting a refund?',
          ),
          maxLines: 3,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final reason = reasonCtrl.text.trim();
    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a reason')),
      );
      return;
    }

    try {
      await getIt<PaymentRepository>().requestRefund(payment.id, reason: reason);
      if (!context.mounted) return;
      final updated = payment.copyWith(
        status: PaymentStatus.refunded,
        refundReason: reason,
        refundRequestedAt: DateTime.now(),
      );
      onRefundSuccess(updated);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Refund requested successfully')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
      );
    }
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      dense: true,
      title:
          Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline)),
      subtitle: Text(value, style: theme.textTheme.bodyMedium),
    );
  }
}
