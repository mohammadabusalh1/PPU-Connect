import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppu_connect/core/di/injection.dart';
import 'package:ppu_connect/presentation/cubits/payments/payments_cubit.dart';

/// Ensures [PaymentsCubit] is available when opened from a shell tab.
class PaymentsScope extends StatelessWidget {
  const PaymentsScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PaymentsCubit>(),
      child: child,
    );
  }
}
