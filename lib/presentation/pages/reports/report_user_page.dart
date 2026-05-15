import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/domain/entities/report.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/reports/reports_cubit.dart';
import 'package:ppu_connect/presentation/widgets/buttons/primary_button.dart';
import 'package:ppu_connect/presentation/widgets/form/app_text_field.dart';

class ReportUserPage extends StatefulWidget {
  const ReportUserPage({super.key, required this.reportedId});

  final String reportedId;

  @override
  State<ReportUserPage> createState() => _ReportUserPageState();
}

class _ReportUserPageState extends State<ReportUserPage> {
  ReportReason _reason = ReportReason.inappropriateBehavior;
  final _detailsCtrl = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _detailsCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_detailsCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide details')),
      );
      return;
    }
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    setState(() => _submitting = true);
    final report = Report(
      id: '',
      reporterId: authState.user.id,
      reportedUserId: widget.reportedId,
      reason: _reason,
      description: _detailsCtrl.text.trim(),
      status: ReportStatus.open,
      createdAt: DateTime.now(),
    );

    await context.read<ReportsCubit>().submit(report);
    if (!mounted) return;
    setState(() => _submitting = false);

    if (context.read<ReportsCubit>().state is ReportSubmitSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Report submitted. We'll review it shortly.")),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report User')),
      body: BlocListener<ReportsCubit, ReportsState>(
        listener: (context, state) {
          if (state is ReportsError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Select a reason',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            RadioGroup<ReportReason>(
              groupValue: _reason,
              onChanged: (v) {
                if (v != null) setState(() => _reason = v);
              },
              child: Column(
                children: ReportReason.values
                    .map(
                      (r) => RadioListTile<ReportReason>(
                        value: r,
                        title: Text(_reasonLabel(r)),
                        contentPadding: EdgeInsets.zero,
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _detailsCtrl,
              label: 'Details',
              maxLines: 4,
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Submit Report',
              loading: _submitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  String _reasonLabel(ReportReason r) => switch (r) {
        ReportReason.noShow => 'No Show',
        ReportReason.inappropriateBehavior => 'Inappropriate Behavior',
        ReportReason.harassment => 'Harassment',
        ReportReason.fraud => 'Fraud',
        ReportReason.fakeProfile => 'Fake Profile',
        ReportReason.other => 'Other',
      };
}
