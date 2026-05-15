part of 'browse_tutors_cubit.dart';

sealed class BrowseTutorsState {
  const BrowseTutorsState();
}

final class BrowseTutorsInitial extends BrowseTutorsState {
  const BrowseTutorsInitial();
}

final class BrowseTutorsLoading extends BrowseTutorsState {
  const BrowseTutorsLoading();
}

final class BrowseTutorsLoaded extends BrowseTutorsState {
  const BrowseTutorsLoaded({required this.tutors, this.query});
  final List<TutorWithUser> tutors;
  final String? query;
}

final class BrowseTutorsError extends BrowseTutorsState {
  const BrowseTutorsError(this.message);
  final String message;
}
