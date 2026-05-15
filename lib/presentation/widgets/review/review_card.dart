import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppu_connect/domain/entities/review.dart';
import 'package:ppu_connect/presentation/widgets/tutor/rating_stars.dart';
import 'package:ppu_connect/presentation/widgets/user/user_avatar.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
    required this.authorName,
    this.authorAvatarUrl,
  });

  final Review review;
  final String authorName;
  final String? authorAvatarUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                UserAvatar(
                  name: authorName,
                  avatarUrl: authorAvatarUrl,
                  radius: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authorName,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        DateFormat('MMM d, yyyy').format(review.createdAt),
                        style: theme.textTheme.labelSmall
                            ?.copyWith(color: cs.outline),
                      ),
                    ],
                  ),
                ),
                RatingStars(rating: review.rating.toDouble()),
              ],
            ),
            if (review.comment != null && review.comment!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                review.comment!,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
