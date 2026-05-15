import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/core/di/injection.dart';
import 'package:ppu_connect/domain/repositories/session_confirmation_repository.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/widgets/buttons/primary_button.dart';

class SessionConfirmationPage extends StatefulWidget {
  const SessionConfirmationPage({super.key, required this.appointmentId});

  final String appointmentId;

  @override
  State<SessionConfirmationPage> createState() =>
      _SessionConfirmationPageState();
}

class _SessionConfirmationPageState extends State<SessionConfirmationPage> {
  bool _attended = true;
  bool _submitting = false;

  Future<void> _submit() async {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    setState(() => _submitting = true);
    try {
      final repo = getIt<SessionConfirmationRepository>();
      if (_attended) {
        await repo.confirmAttendance(widget.appointmentId, authState.user.id);
      } else {
        await repo.reportNoShow(widget.appointmentId, authState.user.id);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Session confirmed!')),
        );
        context.go('/schedule');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Session')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Did the session take place?',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          RadioGroup<bool>(
            groupValue: _attended,
            onChanged: (v) {
              if (v != null) setState(() => _attended = v);
            },
            child: Column(
              children: const [
                RadioListTile<bool>(
                  value: true,
                  title: Text('Yes, the session was completed'),
                  contentPadding: EdgeInsets.zero,
                ),
                RadioListTile<bool>(
                  value: false,
                  title: Text('No, the other party did not show up'),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            label: 'Submit Confirmation',
            loading: _submitting,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
