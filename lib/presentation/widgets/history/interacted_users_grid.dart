import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ppu_connect/core/theme/app_colors.dart';
import 'package:ppu_connect/presentation/widgets/user/user_avatar.dart';

class InteractedPeer {
  const InteractedPeer({
    required this.id,
    required this.name,
    required this.isTutor,
    this.sessionCount = 0,
  });

  final String id;
  final String name;
  final bool isTutor;
  final int sessionCount;
}

class InteractedUsersGrid extends StatelessWidget {
  const InteractedUsersGrid({
    super.key,
    required this.peers,
    this.scrollController,
    this.onPeerTap,
  });

  final List<InteractedPeer> peers;
  final ScrollController? scrollController;
  final void Function(InteractedPeer peer)? onPeerTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.95,
      ),
      itemCount: peers.length,
      itemBuilder: (context, i) {
        final peer = peers[i];
        final roleColor = peer.isTutor ? AppColors.tutor : AppColors.seeker;

        return Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          color: cs.surfaceContainerLow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: onPeerTap == null ? null : () => onPeerTap!(peer),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: roleColor.withValues(alpha: 0.4),
                        width: 2.5,
                      ),
                    ),
                    child: UserAvatar(name: peer.name, radius: 30),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    peer.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: roleColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      peer.isTutor ? 'Tutor' : 'Student',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: roleColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (peer.sessionCount > 0) ...[
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history_rounded,
                            size: 11, color: cs.onSurfaceVariant),
                        const SizedBox(width: 3),
                        Text(
                          '${peer.sessionCount} ${peer.sessionCount == 1 ? 'session' : 'sessions'}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: cs.onSurfaceVariant,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        )
            .animate(delay: (i * 40).ms)
            .fadeIn(duration: 280.ms)
            .slideY(begin: 0.06, end: 0, duration: 280.ms, curve: Curves.easeOut);
      },
    );
  }
}
