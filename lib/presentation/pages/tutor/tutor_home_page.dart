import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/core/theme/app_colors.dart';
import 'package:ppu_connect/domain/entities/appointment_request.dart';
import 'package:ppu_connect/domain/entities/tutor_profile.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/appointment_requests/appointment_requests_cubit.dart';
import 'package:ppu_connect/presentation/cubits/notifications/notifications_cubit.dart';
import 'package:ppu_connect/presentation/cubits/profile/profile_cubit.dart';
import 'package:ppu_connect/presentation/widgets/appointment/request_card.dart';
import 'package:ppu_connect/presentation/widgets/user/user_avatar.dart';
import 'package:ppu_connect/presentation/widgets/feedback/loading_indicator.dart';

class TutorHomePage extends StatefulWidget {
  const TutorHomePage({super.key});

  @override
  State<TutorHomePage> createState() => _TutorHomePageState();
}

class _TutorHomePageState extends State<TutorHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  void _init() {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final userId = authState.user.id;
    if (context.read<ProfileCubit>().state is ProfileInitial) {
      context.read<ProfileCubit>().load(userId);
    }
    context.read<AppointmentRequestsCubit>().watchIncoming(userId);
  }

  Future<void> _toggleAccepting(TutorProfile profile) async {
    HapticFeedback.lightImpact();
    await context.read<ProfileCubit>().updateTutorProfile(
          profile.copyWith(isAcceptingRequests: !profile.isAcceptingRequests),
        );
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  String _levelLabel(AcademicLevel? level) => switch (level) {
        AcademicLevel.firstYear => '1st Year',
        AcademicLevel.secondYear => '2nd Year',
        AcademicLevel.thirdYear => '3rd Year',
        AcademicLevel.fourthYear => '4th Year',
        AcademicLevel.fifthYear => '5th Year',
        AcademicLevel.graduate => 'Graduate',
        null => '',
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          final user =
              authState is AuthAuthenticated ? authState.user : null;

          return BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, profileState) {
              return BlocBuilder<AppointmentRequestsCubit,
                  AppointmentRequestsState>(
                builder: (context, reqState) {
                  final isPageLoading = profileState is ProfileLoading ||
                      profileState is ProfileInitial ||
                      reqState is AppointmentRequestsLoading ||
                      reqState is AppointmentRequestsInitial;

                  if (isPageLoading) {
                    return const LoadingIndicator();
                  }

                  return CustomScrollView(
                    slivers: [
                      _HeaderSliver(
                        user: user,
                        greeting: _greeting(),
                        levelLabel: _levelLabel(user?.academicLevel),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            const SizedBox(height: 24),
                            _AvailabilityCard(onToggle: _toggleAccepting),
                            const SizedBox(height: 24),
                            const _StatsGrid(),
                            const SizedBox(height: 40),
                            const _PendingRequestsSection(),
                            const SizedBox(height: 16),
                          ]),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _HeaderSliver extends StatelessWidget {
  const _HeaderSliver({
    required this.user,
    required this.greeting,
    required this.levelLabel,
  });

  final User? user;
  final String greeting;
  final String levelLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      expandedHeight: 210,
      pinned: true,
      backgroundColor: AppColors.primary,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      actions: [
        BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            final unread =
                state is NotificationsLoaded ? state.unreadCount : 0;
            return IconButton(
              icon: Badge(
                isLabelVisible: unread > 0,
                label: Text(unread > 99 ? '99+' : '$unread'),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
              ),
              tooltip: 'Notifications',
              onPressed: () => context.push('/notifications'),
            );
          },
        ),
        const SizedBox(width: 4),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, Color(0xFF2E7D32)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      UserAvatar(
                        name: user?.fullName ?? '',
                        avatarUrl: user?.avatarUrl,
                        radius: 30,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$greeting,',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white.withValues(alpha: 0.85),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              user?.fullName.split(' ').first ?? '',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (user != null) ...[
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _HeaderChip(
                          icon: Icons.school_outlined,
                          label: user!.major,
                        ),
                        const SizedBox(width: 8),
                        _HeaderChip(
                          icon: Icons.grade_outlined,
                          label: levelLabel,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    if (label.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

// ── Availability Card ─────────────────────────────────────────────────────────

class _AvailabilityCard extends StatelessWidget {
  const _AvailabilityCard({required this.onToggle});

  final Future<void> Function(TutorProfile) onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is! ProfileLoaded || state.tutorProfile == null) {
          return const SizedBox.shrink();
        }
        final profile = state.tutorProfile!;
        final isAccepting = profile.isAcceptingRequests;
        final activeColor =
            isAccepting ? AppColors.success : cs.outlineVariant;

        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: activeColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isAccepting
                        ? Icons.check_circle_outline_rounded
                        : Icons.pause_circle_outline_rounded,
                    color: activeColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Availability',
                        style: theme.textTheme.labelSmall
                            ?.copyWith(color: cs.outline),
                      ),
                      Text(
                        isAccepting
                            ? 'Accepting new requests'
                            : 'Not accepting requests',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isAccepting
                              ? AppColors.success
                              : cs.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: isAccepting,
                  onChanged: (_) => onToggle(profile),
                  activeThumbColor: AppColors.success,
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.08, end: 0);
      },
    );
  }
}

// ── Stats Grid ────────────────────────────────────────────────────────────────

class _StatsGrid extends StatelessWidget {
  const _StatsGrid();

  static const _crossSpacing = 12.0;
  static const _mainSpacing = 12.0;
  static const _aspectRatio = 1.65;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        return BlocBuilder<AppointmentRequestsCubit, AppointmentRequestsState>(
          builder: (context, reqState) {
            final profile = profileState is ProfileLoaded
                ? profileState.tutorProfile
                : null;
            final pendingCount = reqState is AppointmentRequestsLoaded
                ? reqState.requests
                    .where((r) => r.status == RequestStatus.pending)
                    .length
                : 0;

            final stats = [
              _StatData(
                icon: Icons.star_rounded,
                color: AppColors.gold,
                value: profile?.averageRating.toStringAsFixed(1) ?? '—',
                label: 'Rating',
                sub: '${profile?.totalReviews ?? 0} reviews',
              ),
              _StatData(
                icon: Icons.menu_book_rounded,
                color: AppColors.tutor,
                value: '${profile?.completedSessions ?? 0}',
                label: 'Sessions',
                sub: 'completed',
              ),
              _StatData(
                icon: Icons.inbox_rounded,
                color: AppColors.primary,
                value: '$pendingCount',
                label: 'Pending',
                sub: 'requests',
              ),
              _StatData(
                icon: Icons.payments_outlined,
                color: AppColors.info,
                value: profile?.hourlyRate.toStringAsFixed(0) ?? '0',
                label: '${profile?.currency ?? 'ILS'}/hr',
                sub: 'hourly rate',
              ),
            ];

            return _StatsGridLayout(
              children: [
                for (var i = 0; i < stats.length; i++)
                  _StatCard(stat: stats[i])
                      .animate(delay: (i * 60).ms)
                      .fadeIn(duration: 300.ms)
                      .slideY(begin: 0.12, end: 0),
              ],
            );
          },
        );
      },
    );
  }
}

/// 2×2 grid without [GridView] — shrink-wrapped grids inside [CustomScrollView]
/// often reserve extra viewport height below the last row.
class _StatsGridLayout extends StatelessWidget {
  const _StatsGridLayout({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tileWidth =
            (constraints.maxWidth - _StatsGrid._crossSpacing) / 2;
        final tileHeight = tileWidth / _StatsGrid._aspectRatio;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var row = 0; row < 2; row++) ...[
              if (row > 0) const SizedBox(height: _StatsGrid._mainSpacing),
              SizedBox(
                height: tileHeight,
                child: Row(
                  children: [
                    for (var col = 0; col < 2; col++) ...[
                      if (col > 0)
                        const SizedBox(width: _StatsGrid._crossSpacing),
                      Expanded(child: children[row * 2 + col]),
                    ],
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _StatData {
  const _StatData({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
    required this.sub,
  });

  final IconData icon;
  final Color color;
  final String value;
  final String label;
  final String sub;
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.stat});

  final _StatData stat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: stat.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(stat.icon, color: stat.color, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stat.value,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    stat.label,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: cs.outline),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Subjects ──────────────────────────────────────────────────────────────────

class _SubjectsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is! ProfileLoaded) return const SizedBox.shrink();
        final subjects = state.tutorProfile?.subjects ?? [];
        if (subjects.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Subjects',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: subjects
                  .map((s) => _SubjectPill(subject: s))
                  .toList(),
            ),
          ],
        ).animate().fadeIn(duration: 350.ms);
      },
    );
  }
}

class _SubjectPill extends StatelessWidget {
  const _SubjectPill({required this.subject});

  final String subject;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.tutor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.tutor.withValues(alpha: 0.3)),
      ),
      child: Text(
        subject,
        style: theme.textTheme.labelMedium?.copyWith(
          color: AppColors.tutor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── Pending Requests ──────────────────────────────────────────────────────────

class _PendingRequestsSection extends StatelessWidget {
  const _PendingRequestsSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return BlocBuilder<AppointmentRequestsCubit, AppointmentRequestsState>(
      builder: (context, state) {
        final allPending = state is AppointmentRequestsLoaded
            ? state.requests
                .where((r) => r.status == RequestStatus.pending)
                .toList()
            : <AppointmentRequest>[];
        final pending = allPending.take(3).toList();
        final pendingCount = allPending.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Pending Requests',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                if (pendingCount > 0) ...[
                  const SizedBox(width: 8),
                  _CountBadge(count: pendingCount, color: cs.primary),
                ],
                const Spacer(),
                TextButton(
                  onPressed: () => context.push('/requests/incoming'),
                  child: const Text('See all'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (pending.isEmpty)
              _EmptyRequests(cs: cs, theme: theme)
            else
              ...pending.asMap().entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: RequestCard(request: e.value)
                          .animate(delay: (e.key * 60).ms)
                          .fadeIn(duration: 300.ms),
                    ),
                  ),
          ],
        );
      },
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count, required this.color});

  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$count',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _EmptyRequests extends StatelessWidget {
  const _EmptyRequests({required this.cs, required this.theme});

  final ColorScheme cs;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.inbox_outlined,
                size: 40,
                color: cs.outline,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No pending requests',
              style: theme.textTheme.titleSmall
                  ?.copyWith(color: cs.onSurface),
            ),
            const SizedBox(height: 4),
            Text(
              'Student requests will appear here',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: cs.outline),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}
