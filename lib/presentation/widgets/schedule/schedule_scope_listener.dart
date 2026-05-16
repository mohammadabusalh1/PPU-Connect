import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/schedule/schedule_cubit.dart';

/// Starts [ScheduleCubit.watch] when auth is ready and re-subscribes on login.
class ScheduleScopeListener extends StatefulWidget {
  const ScheduleScopeListener({super.key, required this.child});

  final Widget child;

  @override
  State<ScheduleScopeListener> createState() => _ScheduleScopeListenerState();
}

class _ScheduleScopeListenerState extends State<ScheduleScopeListener> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncWatch());
  }

  void _syncWatch() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<ScheduleCubit>().watch(authState.user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) =>
          prev.runtimeType != curr.runtimeType ||
          (curr is AuthAuthenticated &&
              prev is AuthAuthenticated &&
              prev.user.id != curr.user.id),
      listener: (_, __) => _syncWatch(),
      child: widget.child,
    );
  }
}
