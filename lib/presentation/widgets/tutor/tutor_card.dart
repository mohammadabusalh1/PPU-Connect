import 'package:flutter/material.dart';
import 'package:ppu_connect/domain/entities/tutor_profile.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/presentation/widgets/tutor/rating_stars.dart';
import 'package:ppu_connect/presentation/widgets/tutor/subject_chip_list.dart';
import 'package:ppu_connect/presentation/widgets/user/user_avatar.dart';

class TutorCard extends StatelessWidget {
  const TutorCard({
    super.key,
    required this.user,
    required this.profile,
    required this.onTap,
  });

  final User user;
  final TutorProfile profile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  UserAvatar(
                    name: user.fullName,
                    avatarUrl: user.avatarUrl,
                    radius: 26,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullName,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          user.major,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: cs.outline,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RatingStars(
                        rating: profile.averageRating,
                        reviewCount: profile.totalReviews,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${profile.currency} ${profile.hourlyRate.toStringAsFixed(0)}/hr',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: cs.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  profile.bio!,
                  style: theme.textTheme.bodySmall?.copyWith(color: cs.outline),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 10),
              SubjectChipList(subjects: profile.subjects),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 14,
                    color: profile.isAcceptingRequests
                        ? const Color(0xFF2E7D32)
                        : cs.outline,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    profile.isAcceptingRequests
                        ? 'Accepting requests'
                        : 'Not accepting',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: profile.isAcceptingRequests
                          ? const Color(0xFF2E7D32)
                          : cs.outline,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${profile.completedSessions} sessions',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: cs.outline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
