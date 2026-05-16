import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/tutor_profile.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/core/utils/user_display_name.dart';
import 'package:ppu_connect/domain/repositories/tutor_profile_repository.dart';
import 'package:ppu_connect/domain/repositories/user_repository.dart';

part 'profile_setup_state.dart';

@injectable
class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  ProfileSetupCubit(this._userRepo, this._tutorRepo)
      : super(const ProfileSetupState());
  final UserRepository _userRepo;
  final TutorProfileRepository _tutorRepo;

  void nextStep() {
    if (state.currentStep < ProfileSetupState.totalSteps - 1) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void prevStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void updatePersonalInfo({
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
  }) {
    emit(state.copyWith(
      fullName: fullName ?? state.fullName,
      phoneNumber: phoneNumber ?? state.phoneNumber,
      avatarUrl: avatarUrl ?? state.avatarUrl,
    ));
  }

  void updateAcademicInfo({
    String? major,
    AcademicLevel? academicLevel,
    double? gpa,
  }) {
    emit(state.copyWith(
      major: major ?? state.major,
      academicLevel: academicLevel ?? state.academicLevel,
      gpa: gpa ?? state.gpa,
    ));
  }

  void updateRole(UserRole role) => emit(state.copyWith(role: role));

  void updateTutorDetails({
    List<String>? subjects,
    double? hourlyRate,
    String? bio,
  }) {
    emit(state.copyWith(
      subjects: subjects ?? state.subjects,
      hourlyRate: hourlyRate ?? state.hourlyRate,
      bio: bio ?? state.bio,
    ));
  }

  Future<void> save(String userId, {required String email}) async {
    emit(state.copyWith(isSaving: true, error: null));
    try {
      final now = DateTime.now();
      final existing = await _userRepo.getUserById(userId);
      final user = User(
        id: userId,
        fullName: () {
          final fromState = state.fullName.trim();
          if (fromState.isNotEmpty) return fromState;
          final fromExisting = existing?.fullName.trim() ?? '';
          if (fromExisting.isNotEmpty) return fromExisting;
          return resolveUserDisplayName(fullName: '', email: email);
        }(),
        email: email,
        phoneNumber: state.phoneNumber ?? existing?.phoneNumber,
        avatarUrl: state.avatarUrl ?? existing?.avatarUrl,
        major: state.major,
        academicLevel: state.academicLevel,
        gpa: state.gpa ?? existing?.gpa,
        role: state.role,
        isActive: true,
        reportCount: existing?.reportCount ?? 0,
        createdAt: existing?.createdAt ?? now,
        updatedAt: now,
      );
      await _userRepo.updateUser(user);

      if (state.role != UserRole.seeker) {
        final profile = TutorProfile(
          userId: userId,
          bio: state.bio,
          subjects: state.subjects,
          hourlyRate: state.hourlyRate,
          currency: 'ILS',
          averageRating: 0,
          totalReviews: 0,
          completedSessions: 0,
          isAcceptingRequests: true,
          weeklySlots: const [],
          createdAt: now,
          updatedAt: now,
        );
        await _tutorRepo.createProfile(profile);
      }

      if (isClosed) return;
      emit(state.copyWith(isSaving: false, isDone: true));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        isSaving: false,
        error: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }
}
