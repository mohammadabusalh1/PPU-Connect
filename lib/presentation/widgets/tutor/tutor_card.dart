import 'package:flutter/material.dart';
import 'package:ppu_connect/core/theme/app_colors.dart';
import 'package:ppu_connect/domain/entities/tutor_profile.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/entities/user_display.dart';
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
    final accepting = profile.isAcceptingRequests;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ────────────────────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar with availability indicator dot
                  Stack(
                    children: [
                      UserAvatar(
                        name: user.displayName,
                        avatarUrl: user.avatarUrl,
                        radius: 30,
                      ),
                      if (accepting)
                        Positioned(
                          right: 1,
                          bottom: 1,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              shape: BoxShape.circle,
                              border: Border.all(color: cs.surface, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  // Name, major, rating
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.displayName,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          user.major,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        RatingStars(
                          rating: profile.averageRating,
                          reviewCount: profile.totalReviews,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Price badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${profile.currency} ${profile.hourlyRate.toStringAsFixed(0)}/hr',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: cs.onPrimaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              // ── Bio ───────────────────────────────────────────────────────
              if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  profile.bio!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              // ── Subjects ──────────────────────────────────────────────────
              const SizedBox(height: 10),
              SubjectChipList(subjects: profile.subjects),

              // ── Footer ────────────────────────────────────────────────────
              const SizedBox(height: 10),
              const Divider(height: 1),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    accepting
                        ? Icons.check_circle_rounded
                        : Icons.do_not_disturb_rounded,
                    size: 14,
                    color: accepting ? AppColors.success : cs.outline,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    accepting ? 'Accepting requests' : 'Not accepting',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: accepting ? AppColors.success : cs.outline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.school_outlined, size: 13, color: cs.outline),
                  const SizedBox(width: 3),
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
