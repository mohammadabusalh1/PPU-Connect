import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppu_connect/core/validators/scheduling_validators.dart';
import 'package:ppu_connect/domain/entities/weekly_slot.dart';
import 'package:ppu_connect/domain/value_objects/app_time_of_day.dart';
import 'package:ppu_connect/presentation/cubits/profile/profile_cubit.dart';
import 'package:ppu_connect/presentation/widgets/buttons/primary_button.dart';

class WeeklyAvailabilityPage extends StatefulWidget {
  const WeeklyAvailabilityPage({super.key});

  @override
  State<WeeklyAvailabilityPage> createState() =>
      _WeeklyAvailabilityPageState();
}

class _WeeklyAvailabilityPageState extends State<WeeklyAvailabilityPage> {
  // ISO 8601: 1=Mon … 7=Sun
  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final _slots = <WeeklySlot>[];

  @override
  void initState() {
    super.initState();
    final profileState = context.read<ProfileCubit>().state;
    if (profileState is ProfileLoaded && profileState.tutorProfile != null) {
      for (final slot in profileState.tutorProfile!.weeklySlots) {
        if (WeeklySlotValidator.validateSlot(slot) == null) {
          _slots.add(slot);
        }
      }
    }
  }

  void _showSlotError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  TimeOfDay _defaultEndAfter(TimeOfDay start) {
    final totalMinutes = start.hour * 60 + start.minute + 60;
    return TimeOfDay(hour: totalMinutes ~/ 60, minute: totalMinutes % 60);
  }

  Future<void> _addSlot(int dayIndex) async {
    final dayOfWeek = dayIndex + 1; // ISO 8601: 1=Mon
    final dayCount = _slots.where((s) => s.dayOfWeek == dayOfWeek).length;
    final countError = WeeklySlotCountValidator.maxPerDay(dayCount);
    if (countError != null) {
      _showSlotError(countError);
      return;
    }

    final start = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
      helpText: 'Start time (15-min steps)',
    );
    if (start == null || !mounted) return;

    final startTime = AppTimeOfDay(hour: start.hour, minute: start.minute);
    if (startTime.minute % 15 != 0) {
      _showSlotError(
        'Use 15-minute steps for start time (e.g. 10:00, 10:15, 10:30, 10:45)',
      );
      return;
    }

    final end = await showTimePicker(
      context: context,
      initialTime: _defaultEndAfter(start),
      helpText: 'End time (same day, 30 min – 3 hr)',
    );
    if (end == null || !mounted) return;

    final endTime = AppTimeOfDay(hour: end.hour, minute: end.minute);
    final timeError = WeeklySlotValidator.validateTimes(startTime, endTime);
    if (timeError != null) {
      _showSlotError(timeError);
      return;
    }

    final candidate = WeeklySlot(
      id: '${dayOfWeek}_${start.hour}_${start.minute}_${end.hour}_${end.minute}',
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      endTime: endTime,
      isActive: true,
    );

    final overlaps = _slots
        .where((s) => s.dayOfWeek == dayOfWeek)
        .any((s) => WeeklySlotValidator.overlaps(s, candidate));

    if (overlaps) {
      _showSlotError('This slot overlaps with an existing one');
      return;
    }

    setState(() => _slots.add(candidate));
  }

  String? _validateAllSlots() {
    final counts = <int, int>{};
    for (final slot in _slots) {
      final slotError = WeeklySlotValidator.validateSlot(slot);
      if (slotError != null) return slotError;
      counts[slot.dayOfWeek] = (counts[slot.dayOfWeek] ?? 0) + 1;
    }
    for (final count in counts.values) {
      final countError = WeeklySlotCountValidator.maxPerDay(count);
      if (countError != null) return countError;
    }
    return null;
  }

  Future<void> _save() async {
    final cubit = context.read<ProfileCubit>();
    final profileState = cubit.state;
    if (profileState is! ProfileLoaded || profileState.tutorProfile == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              profileState is ProfileError
                  ? profileState.message
                  : 'Profile not loaded. Go back and try again.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }

    final validationError = _validateAllSlots();
    if (validationError != null) {
      _showSlotError(validationError);
      return;
    }

    final saved = await cubit.updateTutorProfile(
      profileState.tutorProfile!.copyWith(
        weeklySlots: List.unmodifiable(_slots),
        updatedAt: DateTime.now().toUtc(),
      ),
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          saved ? 'Availability saved' : 'Could not save availability',
        ),
        behavior: SnackBarBehavior.floating,
        action: saved
            ? null
            : SnackBarAction(label: 'Retry', onPressed: _save),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weekly Availability')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...List.generate(7, (i) {
            final dayOfWeek = i + 1;
            final daySlots =
                _slots.where((s) => s.dayOfWeek == dayOfWeek).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _days[i],
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Add'),
                      onPressed: WeeklySlotCountValidator.maxPerDay(
                                daySlots.length,
                              ) !=
                              null
                          ? null
                          : () => _addSlot(i),
                    ),
                  ],
                ),
                if (daySlots.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'No slots',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                  )
                else
                  Wrap(
                    spacing: 8,
                    children: daySlots.map((s) {
                      return Chip(
                        label: Text('${s.startTime}–${s.endTime}'),
                        onDeleted: () => setState(() => _slots.remove(s)),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      );
                    }).toList(),
                  ),
                const Divider(),
              ],
            );
          }),
          const SizedBox(height: 24),
          // BlocSelector limits rebuilds to isSaving changes only.
          BlocSelector<ProfileCubit, ProfileState, bool>(
            selector: (s) => s is ProfileLoaded && s.isSaving,
            builder: (_, isSaving) => PrimaryButton(
              label: 'Save Availability',
              loading: isSaving,
              onPressed: _save,
            ),
          ),
        ],
      ),
    );
  }
}
