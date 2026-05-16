import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TutorCardSkeleton extends StatelessWidget {
  const TutorCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Widget box(double w, double h, {double r = 8}) => Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(r),
          ),
        )
            .animate(onPlay: (c) => c.repeat())
            .shimmer(
              duration: 1400.ms,
              color: cs.surface.withValues(alpha: 0.55),
            );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: avatar + name/major/rating + price badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                box(60, 60, r: 30),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      box(140, 16),
                      const SizedBox(height: 8),
                      box(96, 12),
                      const SizedBox(height: 8),
                      box(72, 12),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                box(70, 32, r: 10),
              ],
            ),
            const SizedBox(height: 12),
            // Bio lines
            Row(children: [Expanded(child: box(double.infinity, 12))]),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: box(double.infinity, 12)),
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 12),
            // Subject chips
            Row(
              children: [
                box(64, 26, r: 13),
                const SizedBox(width: 8),
                box(64, 26, r: 13),
                const SizedBox(width: 8),
                box(40, 26, r: 13),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 8),
            // Footer
            Row(
              children: [
                box(120, 11),
                const Spacer(),
                box(80, 11),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
