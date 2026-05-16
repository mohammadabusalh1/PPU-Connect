import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/presentation/cubits/profile/profile_cubit.dart';
import 'package:ppu_connect/presentation/widgets/buttons/primary_button.dart';
import 'package:ppu_connect/presentation/widgets/form/app_text_field.dart';

class TutorProfileEditPage extends StatefulWidget {
  const TutorProfileEditPage({super.key});

  @override
  State<TutorProfileEditPage> createState() => _TutorProfileEditPageState();
}

class _TutorProfileEditPageState extends State<TutorProfileEditPage> {
  final _bioCtrl = TextEditingController();
  final _rateCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _subjects = <String>[];
  bool _acceptingRequests = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileCubit>().state;
    if (state is ProfileLoaded && state.tutorProfile != null) {
      final t = state.tutorProfile!;
      _bioCtrl.text = t.bio ?? '';
      _rateCtrl.text = t.hourlyRate.toStringAsFixed(0);
      _subjects.addAll(t.subjects);
      _acceptingRequests = t.isAcceptingRequests;
    }
  }

  @override
  void dispose() {
    _bioCtrl.dispose();
    _rateCtrl.dispose();
    _subjectCtrl.dispose();
    super.dispose();
  }

  void _addSubject() {
    final s = _subjectCtrl.text.trim();
    if (s.isNotEmpty && !_subjects.contains(s)) {
      setState(() {
        _subjects.add(s);
        _subjectCtrl.clear();
      });
    }
  }

  Future<void> _save() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final state = context.read<ProfileCubit>().state;
    if (state is! ProfileLoaded || state.tutorProfile == null) return;

    final rate = double.tryParse(_rateCtrl.text.trim()) ?? 0;
    if (rate <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid hourly rate')),
      );
      return;
    }

    setState(() => _saving = true);
    final saved = await context.read<ProfileCubit>().updateTutorProfile(
          state.tutorProfile!.copyWith(
            bio: _bioCtrl.text.trim().isEmpty ? null : _bioCtrl.text.trim(),
            hourlyRate: rate,
            subjects: List.unmodifiable(_subjects),
            isAcceptingRequests: _acceptingRequests,
          ),
        );
    if (mounted) {
      setState(() => _saving = false);
      if (saved) {
        context.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not save tutor profile')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Tutor Profile')),
        body: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(16),
          children: [
          AppTextField(
            controller: _bioCtrl,
            label: 'Bio (optional)',
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: _rateCtrl,
            label: 'Hourly Rate (ILS)',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          SwitchListTile(
            value: _acceptingRequests,
            onChanged: (v) => setState(() => _acceptingRequests = v),
            title: const Text('Accepting Requests'),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 20),
          Text(
            'Subjects',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: _subjectCtrl,
                  label: 'Add subject',
                  onFieldSubmitted: (_) => _addSubject(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: _addSubject,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_subjects.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: _subjects
                  .map(
                    (s) => Chip(
                      label: Text(s),
                      onDeleted: () => setState(() => _subjects.remove(s)),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  )
                  .toList(),
            ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.edit_calendar_outlined),
            title: const Text('Manage Weekly Availability'),
            trailing: const Icon(Icons.chevron_right),
            contentPadding: EdgeInsets.zero,
            onTap: () => context.push('/profile/availability'),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Save',
            loading: _saving,
            onPressed: _save,
          ),
        ],
        ),
      ),
    );
  }
}
