import 'package:flutter/material.dart';

class SubjectChipList extends StatelessWidget {
  const SubjectChipList({
    super.key,
    required this.subjects,
    this.maxVisible = 3,
    this.onTap,
  });

  final List<String> subjects;
  final int maxVisible;
  final void Function(String subject)? onTap;

  @override
  Widget build(BuildContext context) {
    final visible = subjects.take(maxVisible).toList();
    final overflow = subjects.length - maxVisible;

    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: [
        ...visible.map(
          (s) => GestureDetector(
            onTap: onTap != null ? () => onTap!(s) : null,
            child: Chip(
              label: Text(s),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              labelStyle: Theme.of(context).textTheme.labelSmall,
              visualDensity: VisualDensity.compact,
            ),
          ),
        ),
        if (overflow > 0)
          Chip(
            label: Text('+$overflow'),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
            visualDensity: VisualDensity.compact,
          ),
      ],
    );
  }
}
