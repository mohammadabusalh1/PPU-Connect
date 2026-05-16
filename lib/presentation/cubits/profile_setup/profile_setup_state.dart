part of 'profile_setup_cubit.dart';

final class ProfileSetupState {
  const ProfileSetupState({
    this.currentStep = 0,
    this.fullName = '',
    this.phoneNumber,
    this.avatarUrl,
    this.major = '',
    this.academicLevel = AcademicLevel.firstYear,
    this.gpa,
    this.role = UserRole.seeker,
    this.subjects = const [],
    this.hourlyRate = 0,
    this.bio,
    this.isSaving = false,
    this.isDone = false,
    this.error,
  });

  final int currentStep;
  final String fullName;
  final String? phoneNumber;
  final String? avatarUrl;
  final String major;
  final AcademicLevel academicLevel;
  final double? gpa;
  final UserRole role;
  final List<String> subjects;
  final double hourlyRate;
  final String? bio;
  final bool isSaving;
  final bool isDone;
  final String? error;

  bool get showTutorSteps =>
      role == UserRole.tutor || role == UserRole.both;

  // Derived from role — no longer a stale constant.
  int get totalSteps => showTutorSteps ? 3 : 2;

  ProfileSetupState copyWith({
    int? currentStep,
    String? fullName,
    String? phoneNumber,
    bool clearPhoneNumber = false,
    String? avatarUrl,
    bool clearAvatarUrl = false,
    String? major,
    AcademicLevel? academicLevel,
    double? gpa,
    bool clearGpa = false,
    UserRole? role,
    List<String>? subjects,
    double? hourlyRate,
    String? bio,
    bool clearBio = false,
    bool? isSaving,
    bool? isDone,
    // error uses direct assignment so callers can explicitly set null to clear it.
    Object? error = _keep,
  }) =>
      ProfileSetupState(
        currentStep: currentStep ?? this.currentStep,
        fullName: fullName ?? this.fullName,
        phoneNumber:
            clearPhoneNumber ? null : (phoneNumber ?? this.phoneNumber),
        avatarUrl: clearAvatarUrl ? null : (avatarUrl ?? this.avatarUrl),
        major: major ?? this.major,
        academicLevel: academicLevel ?? this.academicLevel,
        gpa: clearGpa ? null : (gpa ?? this.gpa),
        role: role ?? this.role,
        subjects: subjects ?? this.subjects,
        hourlyRate: hourlyRate ?? this.hourlyRate,
        bio: clearBio ? null : (bio ?? this.bio),
        isSaving: isSaving ?? this.isSaving,
        isDone: isDone ?? this.isDone,
        error: identical(error, _keep) ? this.error : error as String?,
      );
}

// Sentinel so copyWith(error: null) explicitly clears the error field.
const Object _keep = Object();
