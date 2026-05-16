import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/presentation/cubits/notifications/notifications_cubit.dart';
import 'package:ppu_connect/presentation/widgets/navigation/app_nav_bar.dart';

class MainShellPage extends StatelessWidget {
  const MainShellPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          final unread =
              state is NotificationsLoaded ? state.unreadCount : 0;
          return AppNavBar(
            currentIndex: navigationShell.currentIndex,
            unreadNotifications: unread,
            onNotificationTap: () => context.push('/notifications'),
            onTap: (index) => navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            ),
          );
        },
      ),
    );
  }
}
