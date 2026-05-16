import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/appointment_requests/appointment_requests_cubit.dart';
import 'package:ppu_connect/presentation/widgets/appointment/request_card.dart';
import 'package:ppu_connect/core/constants/app_constants.dart';
import 'package:ppu_connect/presentation/widgets/feedback/empty_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_state_widget.dart';
import 'package:ppu_connect/presentation/widgets/feedback/loading_indicator.dart';


class IncomingRequestsPage extends StatefulWidget {
  const IncomingRequestsPage({super.key});

  @override
  State<IncomingRequestsPage> createState() => _IncomingRequestsPageState();
}

class _IncomingRequestsPageState extends State<IncomingRequestsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _watch());
  }

  void _watch() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<AppointmentRequestsCubit>().watchIncoming(authState.user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Incoming Requests')),
      body: BlocBuilder<AppointmentRequestsCubit, AppointmentRequestsState>(
        builder: (context, state) {
          if (state is AppointmentRequestsLoading) return const LoadingIndicator();
          if (state is AppointmentRequestsError) {
            return ErrorStateWidget(message: state.message, onRetry: _watch);
          }
          if (state is AppointmentRequestsLoaded) {
            if (state.requests.isEmpty) {
              return const EmptyStateWidget(
                lottieAsset: AppLottie.emptySearch,
                title: 'No incoming requests',
                subtitle: 'Students will send you session requests here',
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.requests.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) => RequestCard(request: state.requests[i])
                  .animate(delay: (i * 40).ms)
                  .fadeIn(duration: 250.ms),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
