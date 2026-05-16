import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/core/di/injection.dart';
import 'package:ppu_connect/domain/entities/user_display.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/cubits/profile/profile_cubit.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/tutor/rating_stars.dart';
import 'package:ppu_connect/presentation/widgets/tutor/subject_chip_list.dart';
import 'package:ppu_connect/presentation/widgets/user/role_badge.dart';
import 'package:ppu_connect/presentation/widgets/user/user_avatar.dart';
import 'package:ppu_connect/presentation/widgets/feedback/loading_indicator.dart';

class PublicProfilePage extends StatelessWidget {
  const PublicProfilePage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..load(userId),
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) return const LoadingIndicator();
            if (state is ProfileError) {
              return ErrorStateWidget(
                message: state.message,
                onRetry: () => context.read<ProfileCubit>().load(userId),
              );
            }
            if (state is ProfileLoaded) {
              final user = state.user;
              final tutor = state.tutorProfile;
              return ListView(
                children: [
                  _buildHeader(context, user.displayName, user.avatarUrl,
                      user.role, user.major),
                  if (tutor != null) ...[
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            RatingStars(
                              rating: tutor.averageRating,
                              reviewCount: tutor.totalReviews,
                              size: 18,
                            ),
                            const Spacer(),
                            Text(
                              '${tutor.currency} ${tutor.hourlyRate.toStringAsFixed(0)}/hr',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ]),
                          if (tutor.bio != null && tutor.bio!.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            Text(tutor.bio!),
                          ],
                          const SizedBox(height: 12),
                          SubjectChipList(subjects: tutor.subjects),
                          const SizedBox(height: 16),
                          Text(
                            '${tutor.completedSessions} sessions completed',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.outline,
                                ),
                          ),
                        ],
                      ),
                    ),
                    if (tutor.isAcceptingRequests)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: FilledButton.icon(
                          icon: const Icon(Icons.send_rounded),
                          label: const Text('Request Session'),
                          onPressed: () => context.push(
                              '/requests/create?tutorId=$userId&tutorName=${Uri.encodeComponent(user.displayName)}'),
                        ),
                      ),
                  ],
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.flag_outlined),
                    title: const Text('Report User'),
                    textColor: Theme.of(context).colorScheme.error,
                    iconColor: Theme.of(context).colorScheme.error,
                    onTap: () =>
                        context.push('/reports/create?reportedId=$userId'),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String name, String? avatarUrl,
      UserRole role, String major) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          UserAvatar(name: name, avatarUrl: avatarUrl, radius: 40),
          const SizedBox(height: 12),
          Text(name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(major,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline)),
          const SizedBox(height: 8),
          RoleBadge(role: role),
        ],
      ),
    );
  }
}
