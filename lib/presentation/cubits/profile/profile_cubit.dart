import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/tutor_profile.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/repositories/tutor_profile_repository.dart';
import 'package:ppu_connect/domain/repositories/user_repository.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._userRepo, this._tutorRepo) : super(const ProfileInitial());
  final UserRepository _userRepo;
  final TutorProfileRepository _tutorRepo;

  /// Loads the user and their tutor profile (if any).
  /// Pass [forceRefresh] to bypass the already-loaded guard.
  Future<void> load(String userId, {bool forceRefresh = false}) async {
    if (!forceRefresh && state is ProfileLoaded) return;
    emit(const ProfileLoading());
    try {
      final user = await _userRepo.getUserById(userId);
      if (isClosed) return;
      if (user == null) {
        emit(const ProfileError('User not found'));
        return;
      }

      TutorProfile? tutorProfile;
      try {
        tutorProfile = await _tutorRepo.getProfile(userId);
      } catch (e) {
        // Tutor profile is optional; a bad/corrupt doc must not block the user header.
        debugPrint('[ProfileCubit] tutor profile fetch error (non-fatal): $e');
      }

      if (isClosed) return;
      emit(ProfileLoaded(user: user, tutorProfile: tutorProfile));
    } catch (e) {
      debugPrint('[ProfileCubit] load error: $e');
      if (isClosed) return;
      emit(ProfileError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<bool> updateUser(User updated) async {
    final current = state;
    if (current is! ProfileLoaded) return false;
    emit(current.copyWith(isSaving: true));
    try {
      await _userRepo.updateUser(updated);
      if (isClosed) return false;
      emit(current.copyWith(user: updated, isSaving: false));
      return true;
    } catch (e) {
      debugPrint('[ProfileCubit] updateUser error: $e');
      if (isClosed) return false;
      emit(current.copyWith(isSaving: false));
      return false;
    }
  }

  Future<bool> updateTutorProfile(TutorProfile profile) async {
    final current = state;
    if (current is! ProfileLoaded) return false;
    emit(current.copyWith(isSaving: true));
    try {
      await _tutorRepo.updateProfile(profile);
      if (isClosed) return false;
      emit(current.copyWith(tutorProfile: profile, isSaving: false));
      return true;
    } catch (e) {
      debugPrint('[ProfileCubit] updateTutorProfile error: $e');
      if (isClosed) return false;
      emit(current.copyWith(isSaving: false));
      return false;
    }
  }
}
