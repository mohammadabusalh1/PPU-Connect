import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppu_connect/core/di/injection.dart';
import 'package:ppu_connect/presentation/cubits/notifications/notifications_cubit.dart';

/// Ensures [NotificationsCubit] is available when opened from a shell tab.
class NotificationsScope extends StatelessWidget {
  const NotificationsScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationsCubit>(),
      child: child,
    );
  }
}
