import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/core/di/injection.dart';
import 'package:ppu_connect/core/theme/app_theme.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/notifications/notifications_cubit.dart';

import 'router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthBloc _authBloc;
  late final NotificationsCubit _notificationsCubit;
  late final GoRouter _router;
  late final StreamSubscription<AuthState> _authSub;

  @override
  void initState() {
    super.initState();
    _authBloc = getIt<AuthBloc>()..add(const AuthStarted());
    _notificationsCubit = getIt<NotificationsCubit>();
    _authSub = _authBloc.stream.listen((state) {
      if (state is AuthAuthenticated) {
        _notificationsCubit.watch(state.user.id);
      } else if (state is AuthUnauthenticated) {
        _notificationsCubit.reset();
      }
    });
    _router = createRouter(_authBloc);
  }

  @override
  void dispose() {
    _authSub.cancel();
    _notificationsCubit.close();
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _authBloc),
        BlocProvider.value(value: _notificationsCubit),
      ],
      child: MaterialApp.router(
        title: 'PPU Connect',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
