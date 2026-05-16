import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppu_connect/core/di/injection.dart';
import 'package:ppu_connect/presentation/cubits/reports/reports_cubit.dart';

/// Ensures [ReportsCubit] is available when opened from the profile shell tab.
class ReportsScope extends StatelessWidget {
  const ReportsScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ReportsCubit>(),
      child: child,
    );
  }
}
