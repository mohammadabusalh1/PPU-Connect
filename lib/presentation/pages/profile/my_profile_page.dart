import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/profile/profile_cubit.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/tutor/rating_stars.dart';
import 'package:ppu_connect/presentation/widgets/tutor/subject_chip_list.dart';
import 'package:ppu_connect/presentation/widgets/user/role_badge.dart';
import 'package:ppu_connect/presentation/widgets/user/user_avatar.dart';
import 'package:shimmer/shimmer.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  void _load() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<ProfileCubit>().load(authState.user.id);
    }
  }

  String _displayName(User user, User? authUser) {
    final fromProfile = user.fullName.trim();
    if (fromProfile.isNotEmpty) return fromProfile;
    final fromAuth = authUser?.fullName.trim() ?? '';
    if (fromAuth.isNotEmpty) return fromAuth;
    return 'User';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listenWhen: (prev, curr) => curr is ProfileInitial,
        listener: (context, state) {
          if (state is ProfileInitial) {
            WidgetsBinding.instance.addPostFrameCallback((_) => _load());
          }
        },
        builder: (context, state) {
          final authState = context.watch<AuthBloc>().state;
          final authUser =
              authState is AuthAuthenticated ? authState.user : null;

          if (state is ProfileInitial || state is ProfileLoading) {
            return const _Skeleton();
          }
          if (state is ProfileError) {
            debugPrint('Profile load error: ${state.message}');
            if (authUser != null) {
              return ListView(
                children: [
                  _Header(
                    name: _displayName(authUser, authUser),
                    avatarUrl: authUser.avatarUrl,
                    role: authUser.role,
                    major: authUser.major,
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ErrorStateWidget(
                      message: state.message,
                      onRetry: _load,
                    ),
                  ),
                ],
              );
            }
            return ErrorStateWidget(message: state.message, onRetry: _load);
          }
          if (state is ProfileLoaded) {
            final user = state.user;
            final tutor = state.tutorProfile;
            return ListView(
              children: [
                _Header(
                  name: _displayName(user, authUser),
                  avatarUrl: user.avatarUrl ?? authUser?.avatarUrl,
                  role: user.role,
                  major: user.major.isNotEmpty
                      ? user.major
                      : (authUser?.major ?? ''),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.edit_outlined),
                  title: const Text('Edit Profile'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/profile/edit'),
                ),
                if (tutor != null) ...[
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('Tutor Stats',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: cs.outline,
                        )),
                  ),
                  _StatRow(
                    icon: Icons.star_rounded,
                    label: 'Rating',
                    value: RatingStars(
                      rating: tutor.averageRating,
                      reviewCount: tutor.totalReviews,
                    ),
                  ),
                  _StatRow(
                    icon: Icons.school_outlined,
                    label: 'Completed Sessions',
                    value: Text('${tutor.completedSessions}',
                        style: theme.textTheme.bodyMedium),
                  ),
                  if (tutor.bio != null && tutor.bio!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(tutor.bio!,
                          style: theme.textTheme.bodyMedium),
                    ),
                  if (tutor.subjects.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: SubjectChipList(subjects: tutor.subjects),
                    ),
                  ListTile(
                    leading: const Icon(Icons.edit_calendar_outlined),
                    title: const Text('Manage Availability'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/profile/availability'),
                  ),
                ],
                if (user.role != UserRole.seeker) ...[
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.reviews_outlined),
                    title: const Text('My Reviews'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/reviews/my'),
                  ),
                ],
                ListTile(
                  leading: const Icon(Icons.payment_outlined),
                  title: const Text('Payment History'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/payments'),
                ),
                ListTile(
                  leading: const Icon(Icons.flag_outlined),
                  title: const Text('My Reports'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/reports/my'),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.logout),
                    label: const Text('Sign Out'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: cs.error,
                    ),
                    onPressed: () =>
                        context.read<AuthBloc>().add(const AuthSignOutRequested()),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.name,
    this.avatarUrl,
    required this.role,
    required this.major,
  });

  final String name;
  final String? avatarUrl;
  final UserRole role;
  final String major;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          UserAvatar(name: name, avatarUrl: avatarUrl, radius: 40),
          const SizedBox(height: 12),
          Text(
            name,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(major,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.outline)),
          const SizedBox(height: 8),
          RoleBadge(role: role),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: value,
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      baseColor: cs.surfaceContainerHighest,
      highlightColor: cs.surface,
      child: Column(
        children: [
          const SizedBox(height: 32),
          const CircleAvatar(radius: 40),
          const SizedBox(height: 12),
          Container(height: 20, width: 140, color: Colors.white),
          const SizedBox(height: 8),
          Container(height: 14, width: 100, color: Colors.white),
        ],
      ),
    );
  }
}
