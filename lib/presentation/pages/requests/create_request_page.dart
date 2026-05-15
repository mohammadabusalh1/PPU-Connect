import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/domain/entities/appointment_request.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/appointment_requests/appointment_requests_cubit.dart';
import 'package:ppu_connect/presentation/widgets/buttons/primary_button.dart';
import 'package:ppu_connect/presentation/widgets/form/app_text_field.dart';

class CreateRequestPage extends StatefulWidget {
  const CreateRequestPage({super.key, required this.tutorId});

  final String tutorId;

  @override
  State<CreateRequestPage> createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  DateTime? _startAt;
  DateTime? _endAt;
  bool _submitting = false;

  @override
  void dispose() {
    _subjectCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime({required bool isStart}) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );
    if (time == null || !mounted) return;
    final dt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      if (isStart) {
        _startAt = dt;
        if (_endAt != null && _endAt!.isBefore(dt)) _endAt = null;
      } else {
        _endAt = dt;
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_startAt == null || _endAt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select start and end time')),
      );
      return;
    }
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    setState(() => _submitting = true);
    final now = DateTime.now();
    final request = AppointmentRequest(
      id: '',
      senderId: authState.user.id,
      receiverId: widget.tutorId,
      tutorId: widget.tutorId,
      seekerId: authState.user.id,
      subject: _subjectCtrl.text.trim(),
      note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
      proposedStartAt: _startAt!,
      proposedEndAt: _endAt!,
      status: RequestStatus.pending,
      expiresAt: _startAt!.subtract(const Duration(hours: 1)),
      createdAt: now,
      updatedAt: now,
    );

    await context.read<AppointmentRequestsCubit>().sendRequest(request);
    if (!mounted) return;
    setState(() => _submitting = false);
    final cubitState = context.read<AppointmentRequestsCubit>().state;
    if (cubitState is! AppointmentRequestsError) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request sent!')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('EEE, MMM d · h:mm a');

    return Scaffold(
      appBar: AppBar(title: const Text('Request Session')),
      body: BlocListener<AppointmentRequestsCubit, AppointmentRequestsState>(
        listener: (context, state) {
          if (state is AppointmentRequestsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              AppTextField(
                controller: _subjectCtrl,
                label: 'Subject',
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              _DateTimeTile(
                label: 'Select Start Time',
                value: _startAt != null ? dateFmt.format(_startAt!) : null,
                onTap: () => _pickDateTime(isStart: true),
              ),
              const SizedBox(height: 12),
              _DateTimeTile(
                label: 'Select End Time',
                value: _endAt != null ? dateFmt.format(_endAt!) : null,
                onTap: () => _pickDateTime(isStart: false),
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _noteCtrl,
                label: 'Note (optional)',
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Send Request',
                loading: _submitting,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateTimeTile extends StatelessWidget {
  const _DateTimeTile({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: cs.outline),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined, size: 18, color: cs.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value ?? label,
                style: value != null
                    ? Theme.of(context).textTheme.bodyMedium
                    : Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: cs.outline),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: cs.outline),
          ],
        ),
      ),
    );
  }
}
