import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/cubits/profile/profile_cubit.dart';
import 'package:ppu_connect/presentation/widgets/buttons/primary_button.dart';
import 'package:ppu_connect/presentation/widgets/form/app_text_field.dart';

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
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileCubit>().state;
    final user = state is ProfileLoaded ? state.user : null;
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
    final state = context.read<ProfileCubit>().state;
    if (state is! ProfileLoaded) return;

    setState(() => _saving = true);
    await context.read<ProfileCubit>().updateUser(
          state.user.copyWith(
            fullName: _nameCtrl.text.trim(),
            phoneNumber: _phoneCtrl.text.trim().isEmpty
                ? null
                : _phoneCtrl.text.trim(),
            major: _majorCtrl.text.trim(),
            academicLevel: _level,
          ),
        );
    if (mounted) {
      setState(() => _saving = false);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppTextField(
              controller: _nameCtrl,
              label: 'Full Name',
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _phoneCtrl,
              label: 'Phone Number (optional)',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _majorCtrl,
              label: 'Major',
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<AcademicLevel>(
              initialValue: _level,
              decoration: const InputDecoration(
                labelText: 'Academic Level',
                border: OutlineInputBorder(),
              ),
              items: AcademicLevel.values.map((l) {
                return DropdownMenuItem(
                  value: l,
                  child: Text(_levelLabel(l)),
                );
              }).toList(),
              onChanged: (l) {
                if (l != null) setState(() => _level = l);
              },
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Save Changes',
              loading: _saving,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }

  String _levelLabel(AcademicLevel level) => switch (level) {
        AcademicLevel.firstYear => '1st Year',
        AcademicLevel.secondYear => '2nd Year',
        AcademicLevel.thirdYear => '3rd Year',
        AcademicLevel.fourthYear => '4th Year',
        AcademicLevel.fifthYear => '5th Year',
        AcademicLevel.graduate => 'Graduate',
      };
}
