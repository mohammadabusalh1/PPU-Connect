import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ppu_connect/domain/enums/enums.dart';

class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.role = UserRole.seeker,
    this.unreadCount = 0,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final UserRole role;
  final int unreadCount;

  String get _homeLabel => switch (role) {
        UserRole.tutor => 'Requests',
        _ => 'Discover',
      };

  IconData _icon(int index, bool active) {
    return switch (index) {
      0 => active ? Icons.explore : Icons.explore_outlined,
      1 => active ? Icons.calendar_month : Icons.calendar_month_outlined,
      2 => active ? Icons.history : Icons.history_outlined,
      _ => active ? Icons.person : Icons.person_outline,
    };
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: [
        NavigationDestination(
          icon: Icon(_icon(0, false)),
          selectedIcon: Icon(_icon(0, true)),
          label: _homeLabel,
        ),
        NavigationDestination(
          icon: Icon(_icon(1, false)),
          selectedIcon: Icon(_icon(1, true)),
          label: 'Schedule',
        ),
        NavigationDestination(
          icon: Icon(_icon(2, false)),
          selectedIcon: Icon(_icon(2, true)),
          label: 'History',
        ),
        NavigationDestination(
          icon: Icon(_icon(3, false)),
          selectedIcon: Icon(_icon(3, true)),
          label: 'Profile',
        ),
      ],
    ).animate().slideY(begin: 1, end: 0, duration: 300.ms, curve: Curves.easeOut);
  }
}
