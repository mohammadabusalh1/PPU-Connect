import 'package:flutter/material.dart';

class PasswordStrengthBar extends StatelessWidget {
  const PasswordStrengthBar({super.key, required this.score});

  /// 0–4: 0 = empty, 1 = weak, 2 = fair, 3 = good, 4 = strong
  final int score;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = switch (score) {
      0 => cs.surfaceContainerHighest,
      1 => cs.error,
      2 => Colors.orange,
      3 => Colors.amber,
      _ => Colors.green,
    };
    final label = switch (score) {
      0 => '',
      1 => 'Weak',
      2 => 'Fair',
      3 => 'Good',
      _ => 'Strong',
    };

    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: score / 4,
              color: color,
              backgroundColor: cs.surfaceContainerHighest,
              minHeight: 4,
            ),
          ),
        ),
        if (label.isNotEmpty) ...[
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: color),
          ),
        ],
      ],
    );
  }
}
