import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/domain/entities/review.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/reviews/reviews_cubit.dart';
import 'package:ppu_connect/presentation/widgets/buttons/primary_button.dart';
import 'package:ppu_connect/presentation/widgets/form/app_text_field.dart';

class WriteReviewPage extends StatefulWidget {
  const WriteReviewPage({
    super.key,
    required this.appointmentId,
    required this.tutorId,
  });

  final String appointmentId;
  final String tutorId;

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  int _rating = 5;
  final _commentCtrl = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    setState(() => _submitting = true);
    final now = DateTime.now();
    final review = Review(
      id: '',
      appointmentId: widget.appointmentId,
      authorId: authState.user.id,
      tutorId: widget.tutorId,
      rating: _rating,
      comment: _commentCtrl.text.trim().isEmpty
          ? null
          : _commentCtrl.text.trim(),
      isVisible: true,
      createdAt: now,
    );

    await context.read<ReviewsCubit>().submit(review);
    if (!mounted) return;
    setState(() => _submitting = false);

    if (context.read<ReviewsCubit>().state is ReviewSubmitSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review submitted!')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Write a Review')),
      body: BlocListener<ReviewsCubit, ReviewsState>(
        listener: (context, state) {
          if (state is ReviewsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Rate your experience',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                final star = i + 1;
                return GestureDetector(
                  onTap: () => setState(() => _rating = star),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      star <= _rating
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 40,
                      color: star <= _rating
                          ? const Color(0xFFF5C518)
                          : cs.outline,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            AppTextField(
              controller: _commentCtrl,
              label: 'Comment (optional)',
              maxLines: 4,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Submit Review',
              loading: _submitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
