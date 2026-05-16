import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppu_connect/core/constants/app_constants.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/reviews/reviews_cubit.dart';
import 'package:ppu_connect/presentation/pages/reviews/reviews_scope.dart';
import 'package:ppu_connect/presentation/widgets/feedback/empty_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/review/review_card.dart';
import 'package:shimmer/shimmer.dart';

class MyReviewsPage extends StatelessWidget {
  const MyReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReviewsScope(child: _MyReviewsView());
  }
}

class _MyReviewsView extends StatefulWidget {
  const _MyReviewsView();

  @override
  State<_MyReviewsView> createState() => _MyReviewsViewState();
}

class _MyReviewsViewState extends State<_MyReviewsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  void _load() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<ReviewsCubit>().loadForTutor(authState.user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reviews About Me')),
      body: BlocBuilder<ReviewsCubit, ReviewsState>(
        builder: (context, state) {
          if (state is ReviewsLoading) return _buildSkeleton(context);
          if (state is ReviewsError) {
            return ErrorStateWidget(message: state.message, onRetry: _load);
          }
          if (state is ReviewsLoaded) {
            if (state.reviews.isEmpty) {
              return const EmptyStateWidget(
                lottieAsset: AppLottie.emptySearch,
                title: 'No reviews yet',
                subtitle: 'Complete sessions to receive reviews',
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.reviews.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final r = state.reviews[i];
                return ReviewCard(
                  review: r,
                  authorName: r.authorId,
                ).animate(delay: (i * 40).ms).fadeIn(duration: 250.ms);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      baseColor: cs.surfaceContainerHighest,
      highlightColor: cs.surface,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) => Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
