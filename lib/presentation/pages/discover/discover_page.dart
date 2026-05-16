import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/core/constants/app_constants.dart';
import 'package:ppu_connect/domain/entities/tutor_with_user.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/browse_tutors/browse_tutors_cubit.dart';
import 'package:ppu_connect/presentation/cubits/notifications/notifications_cubit.dart';
import 'package:ppu_connect/presentation/widgets/feedback/empty_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/tutor/tutor_card.dart';
import 'package:ppu_connect/presentation/widgets/tutor/tutor_card_skeleton.dart';

enum _QuickFilter {
  all('All', null),
  accepting('Accepting', Icons.check_circle_outline_rounded),
  topRated('Top Rated', Icons.star_rounded),
  affordable('≤ 50/hr', Icons.trending_down_rounded);

  const _QuickFilter(this.label, this.icon);
  final String label;
  final IconData? icon;
}

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final _searchCtrl = TextEditingController();
  Timer? _debounce;
  _QuickFilter _filter = _QuickFilter.all;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _debounce?.cancel();
    super.dispose();
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

  void _onSearchChanged(String q) {
    setState(() {});
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _load(query: q.trim().isEmpty ? null : q.trim());
    });
  }

  List<TutorWithUser> _applyFilter(List<TutorWithUser> tutors) {
    return switch (_filter) {
      _QuickFilter.all => tutors,
      _QuickFilter.accepting =>
        tutors.where((t) => t.profile.isAcceptingRequests).toList(),
      _QuickFilter.topRated =>
        tutors.where((t) => t.profile.averageRating >= 4.0).toList(),
      _QuickFilter.affordable =>
        tutors.where((t) => t.profile.hourlyRate <= 50).toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Tutor'),
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
          const SizedBox(width: 4),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: SearchBar(
              controller: _searchCtrl,
              hintText: 'Search by name or subject…',
              leading: const Icon(Icons.search_rounded),
              trailing: [
                if (_searchCtrl.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      _searchCtrl.clear();
                      _load();
                    },
                  ),
              ],
              onChanged: _onSearchChanged,
              onSubmitted: (q) {
                _debounce?.cancel();
                _load(query: q.trim().isEmpty ? null : q.trim());
              },
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _QuickFilterRow(
            selected: _filter,
            onSelected: (f) {
              HapticFeedback.selectionClick();
              setState(() => _filter = f);
            },
          ),
          Expanded(
            child: BlocBuilder<BrowseTutorsCubit, BrowseTutorsState>(
              builder: (context, state) {
                if (state is BrowseTutorsLoading ||
                    state is BrowseTutorsInitial) {
                  return const _TutorListSkeleton();
                }
                if (state is BrowseTutorsError) {
                  return ErrorStateWidget(
                    message: state.message,
                    onRetry: _load,
                  );
                }
                if (state is BrowseTutorsLoaded) {
                  final tutors = _applyFilter(state.tutors);
                  if (tutors.isEmpty) {
                    return EmptyStateWidget(
                      title: _filter == _QuickFilter.all
                          ? 'No tutors found'
                          : 'No matches for this filter',
                      subtitle: _filter == _QuickFilter.all
                          ? 'Try a different search term'
                          : 'Remove the filter or adjust your search',
                      lottieAsset: AppLottie.emptySearch,
                      action: () {
                        _searchCtrl.clear();
                        setState(() => _filter = _QuickFilter.all);
                        _load();
                      },
                      actionLabel: 'Clear all',
                    );
                  }
                  return _TutorListView(
                    tutors: tutors,
                    onTap: (id) => context.push('/discover/tutors/$id'),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickFilterRow extends StatelessWidget {
  const _QuickFilterRow({required this.selected, required this.onSelected});

  final _QuickFilter selected;
  final ValueChanged<_QuickFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: _QuickFilter.values.map((f) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(f.label),
              avatar: f.icon != null ? Icon(f.icon, size: 16) : null,
              selected: f == selected,
              onSelected: (_) => onSelected(f),
              showCheckmark: false,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _TutorListView extends StatelessWidget {
  const _TutorListView({required this.tutors, required this.onTap});

  final List<TutorWithUser> tutors;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          sliver: SliverToBoxAdapter(
            child: Text(
              '${tutors.length} ${tutors.length == 1 ? 'tutor' : 'tutors'} available',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: cs.outline,
                  ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 88),
          sliver: SliverList.separated(
            itemCount: tutors.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final t = tutors[i];
              return TutorCard(
                user: t.user,
                profile: t.profile,
                onTap: () => onTap(t.profile.userId),
              )
                  .animate(delay: (i * 50).ms)
                  .fadeIn(duration: 350.ms)
                  .slideY(begin: 0.08, end: 0);
            },
          ),
        ),
      ],
    );
  }
}

class _TutorListSkeleton extends StatelessWidget {
  const _TutorListSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, __) => const TutorCardSkeleton(),
    );
  }
}
