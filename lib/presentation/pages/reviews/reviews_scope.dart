import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppu_connect/core/di/injection.dart';
import 'package:ppu_connect/presentation/cubits/reviews/reviews_cubit.dart';

/// Ensures [ReviewsCubit] is available when opened from a shell tab.
class ReviewsScope extends StatelessWidget {
  const ReviewsScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ReviewsCubit>(),
      child: child,
    );
  }
}
