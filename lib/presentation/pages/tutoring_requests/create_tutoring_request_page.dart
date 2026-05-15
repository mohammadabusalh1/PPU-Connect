import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/domain/entities/tutoring_request.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/tutoring_requests/tutoring_requests_cubit.dart';
import 'package:ppu_connect/presentation/widgets/buttons/primary_button.dart';
import 'package:ppu_connect/presentation/widgets/form/app_text_field.dart';

class CreateTutoringRequestPage extends StatefulWidget {
  const CreateTutoringRequestPage({super.key});

  @override
  State<CreateTutoringRequestPage> createState() =>
      _CreateTutoringRequestPageState();
}

class _CreateTutoringRequestPageState
    extends State<CreateTutoringRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _selectedDays = <int>{};
  bool _submitting = false;

  static const _dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void dispose() {
    _subjectCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    setState(() => _submitting = true);
    final now = DateTime.now();
    final request = TutoringRequest(
      id: '',
      seekerId: authState.user.id,
      subject: _subjectCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      preferredDays: _selectedDays.toList()..sort(),
      status: RequestStatus.pending,
      respondedTutorIds: const [],
      expiresAt: now.add(const Duration(days: 7)),
      createdAt: now,
      updatedAt: now,
    );

    await context.read<TutoringRequestsCubit>().create(request);
    if (!mounted) return;
    setState(() => _submitting = false);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Tutoring Request')),
      body: BlocListener<TutoringRequestsCubit, TutoringRequestsState>(
        listener: (context, state) {
          if (state is TutoringRequestsError) {
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
              AppTextField(
                controller: _descCtrl,
                label: 'Description',
                maxLines: 4,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              Text(
                'Preferred Days',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: List.generate(7, (i) {
                  final selected = _selectedDays.contains(i);
                  return FilterChip(
                    label: Text(_dayLabels[i]),
                    selected: selected,
                    onSelected: (v) => setState(() {
                      if (v) {
                        _selectedDays.add(i);
                      } else {
                        _selectedDays.remove(i);
                      }
                    }),
                  );
                }),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Post Request',
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
