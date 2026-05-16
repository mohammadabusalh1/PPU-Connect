import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/domain/entities/appointment_request.dart';
import 'package:ppu_connect/domain/entities/tutor_profile.dart';
import 'package:ppu_connect/presentation/cubits/checkout/checkout_cubit.dart';
import 'package:ppu_connect/presentation/widgets/payment/card_input_widget.dart';

class CheckoutSheet extends StatefulWidget {
  const CheckoutSheet({
    super.key,
    required this.draft,
    required this.tutorProfile,
    required this.tutorName,
  });

  final AppointmentRequest draft;
  final TutorProfile tutorProfile;
  final String tutorName;

  @override
  State<CheckoutSheet> createState() => _CheckoutSheetState();
}

class _CheckoutSheetState extends State<CheckoutSheet> {
  final _cardKey = GlobalKey<CardInputWidgetState>();

  double get _durationHours =>
      widget.draft.proposedEndAt
          .difference(widget.draft.proposedStartAt)
          .inMinutes /
      60.0;

  double get _total => widget.tutorProfile.hourlyRate * _durationHours;

  void _onPay(BuildContext context) {
    final cardState = _cardKey.currentState;
    if (cardState == null) return;

    final card = cardState.validate();
    if (card == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all card fields correctly'),
        ),
      );
      return;
    }

    context.read<CheckoutCubit>().pay(
          draft: widget.draft,
          tutorProfile: widget.tutorProfile,
          card: card,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fmt = NumberFormat.currency(symbol: widget.tutorProfile.currency, decimalDigits: 2);
    final timeFmt = DateFormat('h:mm a');

    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listenWhen: (previous, current) =>
          current is CheckoutSuccess || current is CheckoutError,
      listener: (context, state) {
        if (state is CheckoutSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!context.mounted) return;
            Navigator.of(context).pop(true);
          });
        } else if (state is CheckoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          context.read<CheckoutCubit>().reset();
        }
      },
      builder: (context, state) {
        final loading = state is CheckoutLoading;
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: MediaQuery.viewInsetsOf(context).bottom + 24,
            ),
            child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Price Summary', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              _SummaryRow(label: 'Tutor', value: widget.tutorName),
              _SummaryRow(label: 'Subject', value: widget.draft.subject),
              _SummaryRow(
                label: 'Time',
                value:
                    '${timeFmt.format(widget.draft.proposedStartAt)} – ${timeFmt.format(widget.draft.proposedEndAt)}',
              ),
              _SummaryRow(
                label: 'Rate',
                value: '${fmt.format(widget.tutorProfile.hourlyRate)}/hr',
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                  Text(
                    fmt.format(_total),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text('Card Details', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              CardInputWidget(key: _cardKey),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: loading ? null : () => _onPay(context),
                child: loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text('Pay ${fmt.format(_total)}'),
              ),
            ],
            ),
          ),
        );
      },
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(label,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.outline)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
