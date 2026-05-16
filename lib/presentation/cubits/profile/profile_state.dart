part of 'profile_cubit.dart';

sealed class ProfileState {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileLoaded extends ProfileState {
  const ProfileLoaded({
    required this.user,
    this.tutorProfile,
    this.isSaving = false,
  });

  final User user;
  final TutorProfile? tutorProfile;

  /// True while an updateUser / updateTutorProfile call is in flight.
  /// Pages use BlocSelector on this field to drive loading indicators
  /// without rebuilding the entire widget tree.
  final bool isSaving;

  ProfileLoaded copyWith({
    User? user,
    TutorProfile? tutorProfile,
    bool? isSaving,
  }) =>
      ProfileLoaded(
        user: user ?? this.user,
        tutorProfile: tutorProfile ?? this.tutorProfile,
        isSaving: isSaving ?? this.isSaving,
      );
}

final class ProfileError extends ProfileState {
  const ProfileError(this.message);
  final String message;
}
