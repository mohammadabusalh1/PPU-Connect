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

  Future<void> load(String userId) async {
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
      } catch (_) {
        // Tutor profile is optional; a bad/corrupt doc must not block the user header.
      }

      if (isClosed) return;
      emit(ProfileLoaded(user: user, tutorProfile: tutorProfile));
    } catch (e) {
      if (isClosed) return;
      emit(ProfileError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<bool> updateUser(User updated) async {
    final current = state;
    if (current is! ProfileLoaded) return false;
    try {
      await _userRepo.updateUser(updated);
      if (isClosed) return false;
      emit(current.copyWith(user: updated));
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateTutorProfile(TutorProfile profile) async {
    final current = state;
    if (current is! ProfileLoaded) return false;
    try {
      await _tutorRepo.updateProfile(profile);
      if (isClosed) return false;
      emit(current.copyWith(tutorProfile: profile));
      return true;
    } catch (_) {
      return false;
    }
  }
}
