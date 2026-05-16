import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppu_connect/core/validators/profile_validators.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/profile/profile_cubit.dart';
import 'package:ppu_connect/presentation/widgets/form/app_text_field.dart';
import 'package:ppu_connect/presentation/widgets/user/user_avatar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _majorCtrl;
  late AcademicLevel _level;

  @override
  void initState() {
    super.initState();
    final profileState = context.read<ProfileCubit>().state;
    final user = profileState is ProfileLoaded ? profileState.user : null;
    _nameCtrl = TextEditingController(text: user?.fullName ?? '');
    _phoneCtrl = TextEditingController(text: user?.phoneNumber ?? '');
    _majorCtrl = TextEditingController(text: user?.major ?? '');
    _level = user?.academicLevel ?? AcademicLevel.firstYear;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _majorCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final profileState = context.read<ProfileCubit>().state;
    if (profileState is! ProfileLoaded || profileState.isSaving) return;

    final saved = await context.read<ProfileCubit>().updateUser(
          profileState.user.copyWith(
            fullName: _nameCtrl.text.trim(),
            phoneNumber: _phoneCtrl.text.trim().isEmpty
                ? null
                : _phoneCtrl.text.trim(),
            major: _majorCtrl.text.trim(),
            academicLevel: _level,
          ),
        );

    if (!mounted) return;
    if (saved) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not save profile'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  String _levelLabel(AcademicLevel level) => switch (level) {
        AcademicLevel.firstYear => '1st Year',
        AcademicLevel.secondYear => '2nd Year',
        AcademicLevel.thirdYear => '3rd Year',
        AcademicLevel.fourthYear => '4th Year',
        AcademicLevel.fifthYear => '5th Year',
        AcademicLevel.graduate => 'Graduate',
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    // Read avatar/name from whichever state has them.
    final profileState = context.watch<ProfileCubit>().state;
    final authState = context.watch<AuthBloc>().state;
    final authUser = authState is AuthAuthenticated ? authState.user : null;
    final String avatarName = _nameCtrl.text.trim().isNotEmpty
        ? _nameCtrl.text.trim()
        : (authUser?.fullName ?? 'User');
    final String? avatarUrl = profileState is ProfileLoaded
        ? (profileState.user.avatarUrl ?? authUser?.avatarUrl)
        : authUser?.avatarUrl;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: BlocSelector<ProfileCubit, ProfileState, bool>(
            selector: (s) => s is ProfileLoaded && s.isSaving,
            builder: (_, isSaving) => FilledButton(
              onPressed: isSaving ? null : _save,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Save Changes',
                      style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            // Avatar preview
            Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: cs.primary.withValues(alpha: 0.3),
                        width: 2.5,
                      ),
                    ),
                    child: UserAvatar(
                        name: avatarName, avatarUrl: avatarUrl, radius: 44),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: cs.primaryContainer,
                        shape: BoxShape.circle,
                        border: Border.all(color: cs.surface, width: 2),
                      ),
                      child: Icon(Icons.camera_alt_outlined,
                          size: 14, color: cs.onPrimaryContainer),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 280.ms).scale(
                  begin: const Offset(0.92, 0.92),
                  end: const Offset(1, 1),
                  duration: 280.ms,
                  curve: Curves.easeOut,
                ),
            const SizedBox(height: 24),

            // Personal info section
            _SectionCard(
              title: 'Personal',
              children: [
                AppTextField(
                  controller: _nameCtrl,
                  label: 'Full Name',
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  textInputAction: TextInputAction.next,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 14),
                AppTextField(
                  controller: _phoneCtrl,
                  label: 'Phone Number (optional)',
                  hint: 'e.g. +970591234567',
                  prefixIcon: const Icon(Icons.phone_outlined),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: PhoneValidator.e164,
                ),
              ],
            ).animate(delay: 60.ms).fadeIn(duration: 280.ms).slideY(
                  begin: 0.04,
                  end: 0,
                  duration: 280.ms,
                  curve: Curves.easeOut,
                ),
            const SizedBox(height: 16),

            // Academic info section
            _SectionCard(
              title: 'Academic',
              children: [
                AppTextField(
                  controller: _majorCtrl,
                  label: 'Major',
                  prefixIcon: const Icon(Icons.school_outlined),
                  textInputAction: TextInputAction.done,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Academic Level',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: AcademicLevel.values.map((l) {
                    final selected = _level == l;
                    return ChoiceChip(
                      label: Text(_levelLabel(l)),
                      selected: selected,
                      onSelected: (_) => setState(() => _level = l),
                      labelStyle: theme.textTheme.labelMedium?.copyWith(
                        fontWeight:
                            selected ? FontWeight.w700 : FontWeight.w500,
                        color: selected
                            ? cs.onSecondaryContainer
                            : cs.onSurfaceVariant,
                      ),
                      selectedColor: cs.secondaryContainer,
                      backgroundColor: cs.surfaceContainerHighest,
                      side: BorderSide(
                        color: selected
                            ? cs.secondary.withValues(alpha: 0.5)
                            : cs.outlineVariant.withValues(alpha: 0.4),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ).animate(delay: 120.ms).fadeIn(duration: 280.ms).slideY(
                  begin: 0.04,
                  end: 0,
                  duration: 280.ms,
                  curve: Curves.easeOut,
                ),
          ],
        ),
      ),
    );
  }
}

// ─── Section Card ─────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: theme.textTheme.labelMedium?.copyWith(
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ),
        Card(
          elevation: 0,
          color: cs.surfaceContainerLow,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
