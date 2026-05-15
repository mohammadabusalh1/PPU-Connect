import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/profile_setup/profile_setup_cubit.dart';
import 'package:ppu_connect/presentation/widgets/buttons/primary_button.dart';
import 'package:ppu_connect/presentation/widgets/form/app_text_field.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  final _academicFormKey = GlobalKey<FormState>();

  final _majorCtrl = TextEditingController();
  final _gpaCtrl = TextEditingController();
  final _rateCtrl = TextEditingController();
  final _bioCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _majorCtrl.dispose();
    _gpaCtrl.dispose();
    _rateCtrl.dispose();
    _bioCtrl.dispose();
    _subjectCtrl.dispose();
    super.dispose();
  }

  void _next() {
    final cubit = context.read<ProfileSetupCubit>();
    switch (cubit.state.currentStep) {
      case 0:
        cubit.nextStep();
        _goToPage(1);

      case 1:
        if (!(_academicFormKey.currentState?.validate() ?? false)) return;
        cubit.updateAcademicInfo(
          major: _majorCtrl.text.trim(),
          gpa: double.tryParse(_gpaCtrl.text.trim()),
        );
        if (cubit.state.showTutorSteps) {
          cubit.nextStep();
          _goToPage(2);
        } else {
          _doSave();
        }

      case 2:
        final rate = double.tryParse(_rateCtrl.text.trim()) ?? 0;
        if (rate <= 0) {
          _showError('Enter a valid hourly rate.');
          return;
        }
        if (cubit.state.subjects.isEmpty) {
          _showError('Add at least one subject before continuing.');
          return;
        }
        cubit.updateTutorDetails(
          bio: _bioCtrl.text.trim().isEmpty ? null : _bioCtrl.text.trim(),
          hourlyRate: rate,
        );
        _doSave();
    }
  }

  void _back() {
    final cubit = context.read<ProfileSetupCubit>();
    cubit.prevStep();
    _goToPage(cubit.state.currentStep);
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _doSave() {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final cubit = context.read<ProfileSetupCubit>();
    cubit.updatePersonalInfo(
      fullName: authState.user.fullName,
      phoneNumber: authState.user.phoneNumber,
      avatarUrl: authState.user.avatarUrl,
    );
    cubit.save(authState.user.id, email: authState.user.email);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _continueLabel(int step, bool showTutor) {
    final isLast = (step == 1 && !showTutor) || (step == 2 && showTutor);
    return isLast ? 'Get Started' : 'Continue';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileSetupCubit, ProfileSetupState>(
      listener: (context, state) {
        if (state.isDone) context.go('/discover');
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: state.currentStep > 0
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: _back,
                  )
                : null,
            title: _StepProgress(
              current: state.currentStep,
              total: state.showTutorSteps ? 3 : 2,
            ),
            centerTitle: true,
          ),
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _RoleStep(
                selected: state.role,
                onSelect: (role) {
                  HapticFeedback.selectionClick();
                  context.read<ProfileSetupCubit>().updateRole(role);
                },
              ),
              _AcademicStep(
                formKey: _academicFormKey,
                majorCtrl: _majorCtrl,
                gpaCtrl: _gpaCtrl,
                academicLevel: state.academicLevel,
                onLevelChanged: (level) => context
                    .read<ProfileSetupCubit>()
                    .updateAcademicInfo(academicLevel: level),
              ),
              if (state.showTutorSteps)
                _TutorStep(
                  rateCtrl: _rateCtrl,
                  bioCtrl: _bioCtrl,
                  subjectCtrl: _subjectCtrl,
                  subjects: state.subjects,
                  onAddSubject: (s) {
                    final updated = [...state.subjects, s];
                    context
                        .read<ProfileSetupCubit>()
                        .updateTutorDetails(subjects: updated);
                  },
                  onRemoveSubject: (s) {
                    final updated =
                        state.subjects.where((x) => x != s).toList();
                    context
                        .read<ProfileSetupCubit>()
                        .updateTutorDetails(subjects: updated);
                  },
                ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              12,
              24,
              MediaQuery.of(context).padding.bottom + 24,
            ),
            child: PrimaryButton(
              label: _continueLabel(state.currentStep, state.showTutorSteps),
              loading: state.isSaving,
              onPressed: state.currentStep == 0 ? _next : _next,
            ),
          ),
        );
      },
    );
  }
}

// ── Progress indicator ──────────────────────────────────────────────────────

class _StepProgress extends StatelessWidget {
  const _StepProgress({required this.current, required this.total});
  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final active = i <= current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          height: 4,
          width: active ? 24 : 16,
          decoration: BoxDecoration(
            color: active ? cs.primary : cs.outlineVariant,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}

// ── Step 0: Role Selection ──────────────────────────────────────────────────

class _RoleStep extends StatelessWidget {
  const _RoleStep({required this.selected, required this.onSelect});
  final UserRole selected;
  final ValueChanged<UserRole> onSelect;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How will you use\nPPU Connect?',
            style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose your primary role. You can always change this later.',
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 32),
          _RoleCard(
            role: UserRole.seeker,
            icon: Icons.search_rounded,
            title: 'Find a Tutor',
            description:
                'Browse student tutors, send booking requests, and attend sessions.',
            selected: selected == UserRole.seeker,
            onTap: () => onSelect(UserRole.seeker),
          ),
          const SizedBox(height: 16),
          _RoleCard(
            role: UserRole.tutor,
            icon: Icons.school_rounded,
            title: 'Offer Tutoring',
            description:
                'Set your subjects and rate, accept requests, and earn from your knowledge.',
            selected: selected == UserRole.tutor,
            onTap: () => onSelect(UserRole.tutor),
          ),
          const SizedBox(height: 16),
          _RoleCard(
            role: UserRole.both,
            icon: Icons.swap_horiz_rounded,
            title: 'Both',
            description:
                'Find tutors for some subjects while teaching others you excel in.',
            selected: selected == UserRole.both,
            onTap: () => onSelect(UserRole.both),
          ),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.role,
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  final UserRole role;
  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Semantics(
      button: true,
      selected: selected,
      label: title,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: selected
              ? cs.primaryContainer.withValues(alpha: 0.4)
              : cs.surfaceContainerLow,
          border: Border.all(
            color: selected ? cs.primary : cs.outlineVariant,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: selected ? cs.primary : cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    size: 26,
                    color: selected ? cs.onPrimary : cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: tt.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: selected ? cs.primary : cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: selected ? 1 : 0,
                  child: Icon(Icons.check_circle_rounded, color: cs.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Step 1: Academic Info ───────────────────────────────────────────────────

class _AcademicStep extends StatelessWidget {
  const _AcademicStep({
    required this.formKey,
    required this.majorCtrl,
    required this.gpaCtrl,
    required this.academicLevel,
    required this.onLevelChanged,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController majorCtrl;
  final TextEditingController gpaCtrl;
  final AcademicLevel academicLevel;
  final ValueChanged<AcademicLevel?> onLevelChanged;

  static const _levelLabels = {
    AcademicLevel.firstYear: '1st Year',
    AcademicLevel.secondYear: '2nd Year',
    AcademicLevel.thirdYear: '3rd Year',
    AcademicLevel.fourthYear: '4th Year',
    AcademicLevel.fifthYear: '5th Year',
    AcademicLevel.graduate: 'Graduate',
  };

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Academic Info',
              style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'This helps tutors and seekers know your background.',
              style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 32),
            AppTextField(
              label: 'Major',
              hint: 'e.g. Computer Engineering',
              controller: majorCtrl,
              prefixIcon: const Icon(Icons.book_outlined),
              textInputAction: TextInputAction.next,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Major is required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<AcademicLevel>(
              initialValue: academicLevel,
              decoration: const InputDecoration(
                labelText: 'Academic Year',
                prefixIcon: Icon(Icons.calendar_today_outlined),
              ),
              items: AcademicLevel.values
                  .map((l) => DropdownMenuItem(
                        value: l,
                        child: Text(_levelLabels[l]!),
                      ))
                  .toList(),
              onChanged: onLevelChanged,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'GPA (optional)',
              hint: 'e.g. 3.5',
              controller: gpaCtrl,
              prefixIcon: const Icon(Icons.grade_outlined),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              validator: (v) {
                if (v == null || v.isEmpty) return null;
                final d = double.tryParse(v);
                if (d == null || d < 0 || d > 4) {
                  return 'Enter a GPA between 0 and 4';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ── Step 2: Tutor Profile ───────────────────────────────────────────────────

class _TutorStep extends StatelessWidget {
  const _TutorStep({
    required this.rateCtrl,
    required this.bioCtrl,
    required this.subjectCtrl,
    required this.subjects,
    required this.onAddSubject,
    required this.onRemoveSubject,
  });

  final TextEditingController rateCtrl;
  final TextEditingController bioCtrl;
  final TextEditingController subjectCtrl;
  final List<String> subjects;
  final ValueChanged<String> onAddSubject;
  final ValueChanged<String> onRemoveSubject;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set Up Your Tutor Profile',
              style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Help students find you by describing what you teach.',
              style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 32),

            // Subjects
            Text('Subjects you teach', style: tt.titleSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: 'Add a subject',
                    hint: 'e.g. Calculus II',
                    controller: subjectCtrl,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _addSubject(context),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: () => _addSubject(context),
                  icon: const Icon(Icons.add),
                  tooltip: 'Add subject',
                ),
              ],
            ),
            if (subjects.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: subjects
                    .map((s) => Chip(
                          label: Text(s),
                          onDeleted: () => onRemoveSubject(s),
                          deleteIconColor: cs.onSurfaceVariant,
                        ))
                    .toList(),
              ),
            ] else ...[
              const SizedBox(height: 8),
              Text(
                'Add at least one subject',
                style:
                    tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
              ),
            ],
            const SizedBox(height: 24),

            // Hourly rate
            AppTextField(
              label: 'Hourly Rate',
              hint: 'e.g. 50',
              controller: rateCtrl,
              prefixIcon: const Icon(Icons.payments_outlined),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text('ILS/hr',
                    style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              validator: (v) {
                final d = double.tryParse(v ?? '');
                if (d == null || d <= 0) return 'Enter a valid rate';
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Bio
            AppTextField(
              label: 'Bio (optional)',
              hint: 'Tell students about your experience and teaching style…',
              controller: bioCtrl,
              maxLines: 4,
              maxLength: 300,
            ),

            // Subject validation hint
            if (subjects.isEmpty) ...[
              const SizedBox(height: 12),
              Text(
                '* At least one subject is required to continue.',
                style: tt.bodySmall
                    ?.copyWith(color: cs.error),
              ),
            ],
          ],
        ),
    );
  }

  void _addSubject(BuildContext context) {
    final s = subjectCtrl.text.trim();
    if (s.isNotEmpty) {
      onAddSubject(s);
      subjectCtrl.clear();
    }
  }
}
