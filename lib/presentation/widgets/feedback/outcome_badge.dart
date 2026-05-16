import 'package:flutter/material.dart';
import 'package:ppu_connect/core/theme/app_colors.dart';
import 'package:ppu_connect/domain/enums/enums.dart';

class OutcomeBadge extends StatelessWidget {
  const OutcomeBadge({super.key, required this.outcome});

  final SessionOutcome outcome;

  static (String label, Color color) _style(SessionOutcome o) => switch (o) {
        SessionOutcome.completed => ('Completed', AppColors.completed),
        SessionOutcome.seekerAbsent => ('Seeker absent', AppColors.warning),
        SessionOutcome.tutorAbsent => ('Tutor absent', AppColors.warning),
        SessionOutcome.bothAbsent => ('No show', AppColors.expired),
        SessionOutcome.disputed => ('Disputed', AppColors.error),
      };

  @override
  Widget build(BuildContext context) {
    final (label, color) = _style(outcome);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
