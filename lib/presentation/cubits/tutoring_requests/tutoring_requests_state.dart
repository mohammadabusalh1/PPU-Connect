part of 'tutoring_requests_cubit.dart';

sealed class TutoringRequestsState {
  const TutoringRequestsState();
}

final class TutoringRequestsInitial extends TutoringRequestsState {
  const TutoringRequestsInitial();
}

final class TutoringRequestsLoading extends TutoringRequestsState {
  const TutoringRequestsLoading();
}

final class TutoringRequestsLoaded extends TutoringRequestsState {
  const TutoringRequestsLoaded({required this.requests});
  final List<TutoringRequest> requests;
}

final class TutoringRequestsError extends TutoringRequestsState {
  const TutoringRequestsError(this.message);
  final String message;
}
