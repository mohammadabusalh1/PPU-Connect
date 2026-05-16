import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/core/theme/app_colors.dart';
import 'package:ppu_connect/domain/entities/tutor_profile.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/profile/profile_cubit.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/tutor/subject_chip_list.dart';
import 'package:ppu_connect/presentation/widgets/user/user_avatar.dart';
import 'package:ppu_connect/presentation/widgets/feedback/loading_indicator.dart';

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

  void _load({bool forceRefresh = false}) {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<ProfileCubit>().load(
            authState.user.id,
            forceRefresh: forceRefresh,
          );
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
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listenWhen: (_, curr) => curr is ProfileInitial,
        listener: (context, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) => _load());
        },
        builder: (context, state) {
          final authState = context.watch<AuthBloc>().state;
          final authUser =
              authState is AuthAuthenticated ? authState.user : null;

          if (state is ProfileInitial || state is ProfileLoading) {
            return const LoadingIndicator();
          }

          if (state is ProfileError) {
            if (authUser != null) {
              return ListView(
                children: [
                  _ProfileHero(
                    name: _displayName(authUser, authUser),
                    avatarUrl: authUser.avatarUrl,
                    role: authUser.role,
                    major: authUser.major,
                    level: authUser.academicLevel,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ErrorStateWidget(
                        message: state.message, onRetry: _load),
                  ),
                ],
              );
            }
            return ErrorStateWidget(message: state.message, onRetry: _load);
          }

          if (state is ProfileLoaded) {
            final user = state.user;
            final tutor = state.tutorProfile;
            final name = _displayName(user, authUser);
            const delay = 60;

            return RefreshIndicator(
              onRefresh: () async => _load(forceRefresh: true),
              child: ListView(
                children: [
                  _ProfileHero(
                    name: name,
                    avatarUrl: user.avatarUrl ?? authUser?.avatarUrl,
                    role: user.role,
                    major: user.major.isNotEmpty
                        ? user.major
                        : (authUser?.major ?? ''),
                    level: user.academicLevel,
                    tutorProfile: tutor,
                  ),
                  const SizedBox(height: 12),

                  // About / bio card (tutor only)
                  if (tutor != null &&
                      (tutor.bio?.isNotEmpty == true ||
                          tutor.subjects.isNotEmpty))
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: _AboutCard(tutor: tutor)
                          .animate(delay: (delay * 1).ms)
                          .fadeIn(duration: 280.ms)
                          .slideY(begin: 0.05, end: 0, duration: 280.ms),
                    ),

                  // Profile actions
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: _ActionsSection(
                      title: 'Profile',
                      items: [
                        _MenuItem(
                          icon: Icons.edit_outlined,
                          iconColor: cs.primary,
                          label: 'Edit Profile',
                          onTap: () => context.push('/profile/edit'),
                        ),
                        if (tutor != null)
                          _MenuItem(
                            icon: Icons.edit_calendar_outlined,
                            iconColor: AppColors.tutor,
                            label: 'Manage Availability',
                            onTap: () =>
                                context.push('/profile/availability'),
                          ),
                        if (user.role != UserRole.seeker)
                          _MenuItem(
                            icon: Icons.reviews_outlined,
                            iconColor: AppColors.gold,
                            label: 'My Reviews',
                            onTap: () => context.push('/reviews/my'),
                          ),
                      ],
                    ).animate(delay: (delay * 2).ms).fadeIn(duration: 280.ms).slideY(begin: 0.05, end: 0, duration: 280.ms),
                  ),

                  // Account actions
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: _ActionsSection(
                      title: 'Account',
                      items: [
                        _MenuItem(
                          icon: Icons.payment_outlined,
                          iconColor: AppColors.info,
                          label: 'Payment History',
                          onTap: () => context.push('/payments'),
                        ),
                        _MenuItem(
                          icon: Icons.flag_outlined,
                          iconColor: AppColors.warning,
                          label: 'My Reports',
                          onTap: () => context.push('/reports/my'),
                        ),
                      ],
                    ).animate(delay: (delay * 3).ms).fadeIn(duration: 280.ms).slideY(begin: 0.05, end: 0, duration: 280.ms),
                  ),

                  // Sign out
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 48),
                    child: _ActionsSection(
                      items: [
                        _MenuItem(
                          icon: Icons.logout_rounded,
                          iconColor: cs.error,
                          label: 'Sign Out',
                          labelColor: cs.error,
                          onTap: () => context
                              .read<AuthBloc>()
                              .add(const AuthSignOutRequested()),
                        ),
                      ],
                    ).animate(delay: (delay * 4).ms).fadeIn(duration: 280.ms).slideY(begin: 0.05, end: 0, duration: 280.ms),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ─── Profile Hero ─────────────────────────────────────────────────────────────

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({
    required this.name,
    this.avatarUrl,
    required this.role,
    required this.major,
    required this.level,
    this.tutorProfile,
  });

  final String name;
  final String? avatarUrl;
  final UserRole role;
  final String major;
  final AcademicLevel level;
  final TutorProfile? tutorProfile;

  Color _roleColor() => switch (role) {
        UserRole.seeker => AppColors.seeker,
        UserRole.tutor => AppColors.tutor,
        UserRole.both => AppColors.both,
      };

  String _roleLabel() => switch (role) {
        UserRole.seeker => 'Seeker',
        UserRole.tutor => 'Tutor',
        UserRole.both => 'Tutor & Seeker',
      };

  String _levelLabel(AcademicLevel l) => switch (l) {
        AcademicLevel.firstYear => '1st Year',
        AcademicLevel.secondYear => '2nd Year',
        AcademicLevel.thirdYear => '3rd Year',
        AcademicLevel.fourthYear => '4th Year',
        AcademicLevel.fifthYear => '5th Year',
        AcademicLevel.graduate => 'Graduate',
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final roleColor = _roleColor();
    const topPad = 20.0;
    final tutor = tutorProfile;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            roleColor.withValues(alpha: 0.22),
            roleColor.withValues(alpha: 0.07),
            cs.surface,
          ],
          stops: const [0.0, 0.55, 1.0],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, topPad, 24, 28),
        child: Column(
          children: [
            // Avatar with role-colored ring + glow
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: roleColor.withValues(alpha: 0.5), width: 3),
                boxShadow: [
                  BoxShadow(
                    color: roleColor.withValues(alpha: 0.28),
                    blurRadius: 22,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: UserAvatar(
                  name: name, avatarUrl: avatarUrl, radius: 48),
            ),
            const SizedBox(height: 16),

            // Name
            Text(
              name,
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),

            // Major + academic level
            if (major.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school_outlined,
                      size: 14, color: cs.onSurfaceVariant),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      '$major · ${_levelLabel(level)}',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: cs.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 12),

            // Role badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: roleColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: roleColor.withValues(alpha: 0.4)),
              ),
              child: Text(
                _roleLabel(),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: roleColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            // Accepting-requests status (tutor only)
            if (tutor != null) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: tutor.isAcceptingRequests
                          ? AppColors.success
                          : cs.outline,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    tutor.isAcceptingRequests
                        ? 'Accepting requests'
                        : 'Not accepting requests',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: tutor.isAcceptingRequests
                          ? AppColors.success
                          : cs.outline,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],

            // Tutor stat boxes
            if (tutor != null) ...[
              const SizedBox(height: 20),
              Row(
                children: [
                  _StatBox(
                    icon: Icons.star_rounded,
                    iconColor: AppColors.gold,
                    value: tutor.averageRating.toStringAsFixed(1),
                    label: '${tutor.totalReviews} reviews',
                  ),
                  const SizedBox(width: 10),
                  _StatBox(
                    icon: Icons.school_outlined,
                    iconColor: AppColors.tutor,
                    value: '${tutor.completedSessions}',
                    label: 'sessions',
                  ),
                  const SizedBox(width: 10),
                  _StatBox(
                    icon: Icons.payments_outlined,
                    iconColor: AppColors.info,
                    value:
                        '${tutor.hourlyRate.toStringAsFixed(0)} ${tutor.currency}',
                    label: 'per hour',
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Expanded(
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: cs.surface.withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(14),
          border:
              Border.all(color: cs.outlineVariant.withValues(alpha: 0.5)),
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(height: 5),
            Text(
              value,
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 1),
            Text(
              label,
              style: theme.textTheme.labelSmall
                  ?.copyWith(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── About Card ───────────────────────────────────────────────────────────────

class _AboutCard extends StatelessWidget {
  const _AboutCard({required this.tutor});

  final TutorProfile tutor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            if (tutor.bio?.isNotEmpty == true) ...[
              const SizedBox(height: 8),
              Text(
                tutor.bio!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                  height: 1.55,
                ),
              ),
            ],
            if (tutor.subjects.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                'Subjects',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              SubjectChipList(subjects: tutor.subjects),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Actions Section ──────────────────────────────────────────────────────────

class _MenuItem {
  const _MenuItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.labelColor,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final Color? labelColor;
  final VoidCallback onTap;
}

class _ActionsSection extends StatelessWidget {
  const _ActionsSection({this.title, required this.items});

  final String? title;
  final List<_MenuItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              title!,
              style: theme.textTheme.labelMedium?.copyWith(
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
        Card(
          elevation: 0,
          color: cs.surfaceContainerLow,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  if (i > 0)
                    Divider(
                      height: 1,
                      indent: 56,
                      color: cs.outlineVariant.withValues(alpha: 0.5),
                    ),
                  _MenuTile(item: items[i]),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.item});

  final _MenuItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return InkWell(
      onTap: item.onTap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: item.iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, size: 18, color: item.iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: item.labelColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                size: 20, color: cs.outlineVariant),
          ],
        ),
      ),
    );
  }
}
