import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/core/di/injection.dart';
import 'package:ppu_connect/core/utils/session_schedule_utils.dart';
import 'package:ppu_connect/core/validators/scheduling_validators.dart';
import 'package:ppu_connect/domain/entities/appointment_request.dart';
import 'package:ppu_connect/presentation/widgets/feedback/loading_indicator.dart';
import 'package:ppu_connect/domain/entities/weekly_slot.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/checkout/checkout_cubit.dart';
import 'package:ppu_connect/presentation/cubits/tutor_availability/tutor_availability_cubit.dart';
import 'package:ppu_connect/core/validators/request_validators.dart';
import 'package:ppu_connect/presentation/widgets/buttons/primary_button.dart';
import 'package:ppu_connect/presentation/widgets/form/app_text_field.dart';
import 'package:ppu_connect/presentation/widgets/payment/checkout_sheet.dart';

class CreateRequestPage extends StatefulWidget {
  const CreateRequestPage({
    super.key,
    required this.tutorId,
    this.tutorName = 'Tutor',
  });

  final String tutorId;
  final String tutorName;

  @override
  State<CreateRequestPage> createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();

  DateTime? _selectedDate;
  WeeklySlot? _selectedSlot;
  @override
  void dispose() {
    _subjectCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Set<int> _availableWeekdays(List<WeeklySlot> slots) =>
      slots.map((s) => s.dayOfWeek).toSet();

  List<WeeklySlot> _slotsForDate(List<WeeklySlot> slots, DateTime date) =>
      slots.where((s) => s.dayOfWeek == date.weekday).toList()
        ..sort((a, b) =>
            a.startTime.totalMinutes.compareTo(b.startTime.totalMinutes));

  Future<void> _pickDate(List<WeeklySlot> slots) async {
    final now = DateTime.now();
    final weekdays = _availableWeekdays(slots);
    final date = await showDatePicker(
      context: context,
      initialDate: _firstAvailableDate(now, weekdays),
      firstDate: now,
      lastDate: now.add(const Duration(days: 60)),
      selectableDayPredicate: (day) => weekdays.contains(day.weekday),
    );
    if (date == null) return;
    setState(() {
      _selectedDate = normalizeCalendarDate(date);
      _selectedSlot = null;
    });
  }

  DateTime _firstAvailableDate(DateTime from, Set<int> weekdays) {
    var d = from.add(const Duration(days: 1));
    for (var i = 0; i < 7; i++) {
      if (weekdays.contains(d.weekday)) return d;
      d = d.add(const Duration(days: 1));
    }
    return from.add(const Duration(days: 1));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null || _selectedSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date and time slot')),
      );
      return;
    }
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    final availState = context.read<TutorAvailabilityCubit>().state;
    if (availState is! TutorAvailabilityLoaded) return;

    final startAt = sessionStartOnDate(
      _selectedDate!,
      _selectedSlot!.startTime,
    );
    final endAt = sessionEndOnDate(
      _selectedDate!,
      _selectedSlot!.startTime,
      _selectedSlot!.endTime,
    );
    final timeError = SlotTimeValidator.endAfterStart(startAt, endAt);
    if (timeError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(timeError)),
      );
      return;
    }
    final expiresAt = startAt.subtract(const Duration(hours: 1));
    final now = DateTime.now();

    final draft = AppointmentRequest(
      id: '',
      senderId: authState.user.id,
      senderName: authState.user.fullName,
      senderAvatarUrl: authState.user.avatarUrl,
      receiverId: widget.tutorId,
      tutorId: widget.tutorId,
      seekerId: authState.user.id,
      subject: _subjectCtrl.text.trim(),
      note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
      proposedStartAt: startAt,
      proposedEndAt: endAt,
      status: RequestStatus.pending,
      expiresAt: expiresAt,
      createdAt: now,
      updatedAt: now,
    );

    final ok = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => BlocProvider(
        create: (_) => getIt<CheckoutCubit>(),
        child: CheckoutSheet(
          draft: draft,
          tutorProfile: availState.tutorProfile,
          tutorName: widget.tutorName,
        ),
      ),
    );
    if (ok == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request sent & payment held')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tutorId.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Request Session')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text('Invalid tutor. Go back and try again.'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Request Session')),
      body: BlocBuilder<TutorAvailabilityCubit, TutorAvailabilityState>(
          builder: (context, availState) {
            if (availState is TutorAvailabilityLoading ||
                availState is TutorAvailabilityInitial) {
              return const LoadingIndicator();
            }
            if (availState is TutorAvailabilityError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 48),
                      const SizedBox(height: 12),
                      Text(availState.message, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () => context
                            .read<TutorAvailabilityCubit>()
                            .load(widget.tutorId),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (availState is TutorAvailabilityLoaded) {
              if (availState.slots.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'This tutor has no available time slots at the moment.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return _buildForm(availState);
            }
            return const SizedBox.shrink();
          },
        ),
    );
  }

  Widget _buildForm(TutorAvailabilityLoaded availState) {
    final dateFmt = DateFormat('EEE, MMM d, yyyy');
    final slotsForDay = _selectedDate != null
        ? _slotsForDate(availState.slots, _selectedDate!)
        : <WeeklySlot>[];

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppTextField(
            controller: _subjectCtrl,
            label: 'Subject',
            validator: RequestSubjectValidator.required,
          ),
          const SizedBox(height: 20),
          _SectionLabel(
            icon: Icons.calendar_month_rounded,
            text: 'Pick a Date',
          ),
          const SizedBox(height: 8),
          _DateTile(
            value:
                _selectedDate != null ? dateFmt.format(_selectedDate!) : null,
            onTap: () => _pickDate(availState.slots),
          ),
          if (_selectedDate != null) ...[
            const SizedBox(height: 20),
            _SectionLabel(
              icon: Icons.schedule_rounded,
              text: 'Available Time Slots',
            ),
            const SizedBox(height: 8),
            ...slotsForDay.map((slot) {
              final booked =
                  availState.isSlotBookedOnDate(slot, _selectedDate!);
              return _SlotTile(
                slot: slot,
                selected: !booked && _selectedSlot == slot,
                isBooked: booked,
                onTap: booked
                    ? null
                    : () => setState(() => _selectedSlot = slot),
              );
            }),
          ],
          const SizedBox(height: 20),
          AppTextField(
            controller: _noteCtrl,
            label: 'Note (optional)',
            maxLines: 3,
            validator: RequestNotesValidator.optionalForAppointment,
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            label: 'Continue to Payment',
            onPressed: _submit,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 16, color: cs.primary),
        const SizedBox(width: 6),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: cs.primary, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _DateTile extends StatelessWidget {
  const _DateTile({required this.value, required this.onTap});
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
          border: Border.all(color: value != null ? cs.primary : cs.outline),
          borderRadius: BorderRadius.circular(12),
          color:
              value != null ? cs.primaryContainer.withValues(alpha: 0.3) : null,
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined,
                size: 18, color: value != null ? cs.primary : cs.outline),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value ?? 'Tap to choose a date',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: value != null ? null : cs.outline,
                    ),
              ),
            ),
            Icon(Icons.arrow_drop_down,
                color: value != null ? cs.primary : cs.outline),
          ],
        ),
      ),
    );
  }
}

class _SlotTile extends StatelessWidget {
  const _SlotTile({
    required this.slot,
    required this.selected,
    required this.isBooked,
    required this.onTap,
  });
  final WeeklySlot slot;
  final bool selected;
  final bool isBooked;
  final VoidCallback? onTap;

  String _fmt(int h, int m) {
    final period = h < 12 ? 'AM' : 'PM';
    final hour = h % 12 == 0 ? 12 : h % 12;
    final min = m.toString().padLeft(2, '0');
    return '$hour:$min $period';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final start = _fmt(slot.startTime.hour, slot.startTime.minute);
    final end = _fmt(slot.endTime.hour, slot.endTime.minute);
    final refDay = DateTime(2000, 1, 1);
    final durationMins = sessionEndOnDate(refDay, slot.startTime, slot.endTime)
        .difference(sessionStartOnDate(refDay, slot.startTime))
        .inMinutes;
    final durationLabel =
        durationMins >= 60 ? '${durationMins ~/ 60}h' : '${durationMins}m';

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Opacity(
          opacity: isBooked ? 0.5 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isBooked
                    ? cs.outlineVariant
                    : selected
                        ? cs.primary
                        : cs.outlineVariant,
                width: selected ? 2 : 1,
              ),
              color: isBooked
                  ? cs.surfaceContainerHighest
                  : selected
                      ? cs.primaryContainer
                      : cs.surface,
            ),
            child: Row(
              children: [
                Icon(
                  isBooked
                      ? Icons.block_rounded
                      : Icons.access_time_rounded,
                  size: 20,
                  color: isBooked
                      ? cs.error
                      : selected
                          ? cs.primary
                          : cs.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '$start – $end',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isBooked
                              ? cs.onSurfaceVariant
                              : selected
                                  ? cs.onPrimaryContainer
                                  : null,
                          decoration: isBooked
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isBooked
                        ? cs.errorContainer
                        : selected
                            ? cs.primary.withValues(alpha: 0.15)
                            : cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isBooked ? 'Booked' : durationLabel,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isBooked
                              ? cs.onErrorContainer
                              : selected
                                  ? cs.primary
                                  : cs.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                if (selected && !isBooked) ...[
                  const SizedBox(width: 8),
                  Icon(Icons.check_circle_rounded, size: 20, color: cs.primary),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
