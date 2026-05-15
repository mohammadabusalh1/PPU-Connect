import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/presentation/cubits/schedule/schedule_cubit.dart';
import 'package:ppu_connect/presentation/widgets/buttons/primary_button.dart';
import 'package:ppu_connect/presentation/widgets/form/app_text_field.dart';

class CancelAppointmentPage extends StatefulWidget {
  const CancelAppointmentPage({super.key, required this.appointmentId});

  final String appointmentId;

  @override
  State<CancelAppointmentPage> createState() => _CancelAppointmentPageState();
}

class _CancelAppointmentPageState extends State<CancelAppointmentPage> {
  final _reasonCtrl = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _reasonCtrl.dispose();
    super.dispose();
  }

  Future<void> _cancel() async {
    setState(() => _submitting = true);
    await context.read<ScheduleCubit>().cancel(
          widget.appointmentId,
          reason: _reasonCtrl.text.trim().isEmpty
              ? null
              : _reasonCtrl.text.trim(),
        );
    if (mounted) {
      setState(() => _submitting = false);
      context.go('/schedule');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Cancel Appointment')),
      body: BlocListener<ScheduleCubit, ScheduleState>(
        listener: (context, state) {
          if (state is ScheduleError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.warning_amber_rounded, size: 56, color: cs.error),
              const SizedBox(height: 16),
              Text(
                'Cancel this appointment?',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'This action cannot be undone. Please provide a reason.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: cs.outline),
              ),
              const SizedBox(height: 24),
              AppTextField(
                controller: _reasonCtrl,
                label: 'Reason (optional)',
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Yes, Cancel Appointment',
                loading: _submitting,
                onPressed: _cancel,
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => context.pop(),
                child: const Text('Keep Appointment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
