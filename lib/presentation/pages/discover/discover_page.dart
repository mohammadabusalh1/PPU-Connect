import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/core/constants/app_constants.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/browse_tutors/browse_tutors_cubit.dart';
import 'package:ppu_connect/presentation/cubits/notifications/notifications_cubit.dart';
import 'package:ppu_connect/presentation/widgets/feedback/empty_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/tutor/tutor_card.dart';
import 'package:shimmer/shimmer.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  void _load({String? query}) {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<BrowseTutorsCubit>().load(
            query: query,
            currentUserId: authState.user.id,
          );
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Tutors'),
        actions: [
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              final unread =
                  state is NotificationsLoaded ? state.unreadCount : 0;
              return IconButton(
                icon: Badge(
                  isLabelVisible: unread > 0,
                  label: Text(unread > 99 ? '99+' : '$unread'),
                  child: const Icon(Icons.notifications_outlined),
                ),
                onPressed: () => context.push('/notifications'),
                tooltip: 'Notifications',
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: SearchBar(
              controller: _searchCtrl,
              hintText: 'Search by name or subject…',
              leading: const Icon(Icons.search),
              trailing: [
                if (_searchCtrl.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchCtrl.clear();
                      _load();
                    },
                  ),
              ],
              onSubmitted: (q) => _load(query: q.isEmpty ? null : q),
              onChanged: (q) {
                if (q.isEmpty) _load();
                setState(() {});
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<BrowseTutorsCubit, BrowseTutorsState>(
        builder: (context, state) {
          if (state is BrowseTutorsLoading) return const _Skeleton();
          if (state is BrowseTutorsError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () => _load(),
            );
          }
          if (state is BrowseTutorsLoaded) {
            if (state.tutors.isEmpty) {
              return EmptyStateWidget(
                title: 'No tutors found',
                subtitle: 'Try a different search term',
                lottieAsset: AppLottie.emptySearch,
                action: () {
                  _searchCtrl.clear();
                  _load();
                },
                actionLabel: 'Clear search',
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.tutors.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final t = state.tutors[i];
                return TutorCard(
                  user: t.user,
                  profile: t.profile,
                  onTap: () => context.push('/discover/tutors/${t.profile.userId}'),
                )
                    .animate(delay: (i * 40).ms)
                    .fadeIn(duration: 300.ms)
                    .slideY(begin: 0.15, end: 0);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
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
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) => Container(
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
