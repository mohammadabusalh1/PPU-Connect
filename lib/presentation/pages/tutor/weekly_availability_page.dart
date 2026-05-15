import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileCubit>().state;
    if (state is ProfileLoaded && state.tutorProfile != null) {
      _slots.addAll(state.tutorProfile!.weeklySlots);
    }
  }

  Future<void> _addSlot(int dayIndex) async {
    final start = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
      helpText: 'Start time',
    );
    if (start == null || !mounted) return;
    final end = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: (start.hour + 1) % 24, minute: start.minute),
      helpText: 'End time',
    );
    if (end == null || !mounted) return;

    // dayIndex 0=Mon → dayOfWeek 1=Mon per ISO 8601
    setState(() {
      _slots.add(WeeklySlot(
        id: '',
        dayOfWeek: dayIndex + 1,
        startTime: AppTimeOfDay(hour: start.hour, minute: start.minute),
        endTime: AppTimeOfDay(hour: end.hour, minute: end.minute),
        isActive: true,
      ));
    });
  }

  Future<void> _save() async {
    final state = context.read<ProfileCubit>().state;
    if (state is! ProfileLoaded || state.tutorProfile == null) return;
    setState(() => _saving = true);
    await context.read<ProfileCubit>().updateTutorProfile(
          state.tutorProfile!.copyWith(weeklySlots: List.unmodifiable(_slots)),
        );
    if (mounted) {
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Availability saved')),
      );
    }
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
                      onPressed: () => _addSlot(i),
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
          PrimaryButton(
            label: 'Save Availability',
            loading: _saving,
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}
