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

  static const totalSteps = 6;

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

  ProfileSetupState copyWith({
    int? currentStep,
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
    String? major,
    AcademicLevel? academicLevel,
    double? gpa,
    UserRole? role,
    List<String>? subjects,
    double? hourlyRate,
    String? bio,
    bool? isSaving,
    bool? isDone,
    String? error,
  }) =>
      ProfileSetupState(
        currentStep: currentStep ?? this.currentStep,
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        major: major ?? this.major,
        academicLevel: academicLevel ?? this.academicLevel,
        gpa: gpa ?? this.gpa,
        role: role ?? this.role,
        subjects: subjects ?? this.subjects,
        hourlyRate: hourlyRate ?? this.hourlyRate,
        bio: bio ?? this.bio,
        isSaving: isSaving ?? this.isSaving,
        isDone: isDone ?? this.isDone,
        error: error,
      );
}
