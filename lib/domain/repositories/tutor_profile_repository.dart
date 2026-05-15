import 'package:ppu_connect/domain/entities/tutor_profile.dart';

abstract interface class TutorProfileRepository {
  Future<TutorProfile?> getProfile(String tutorId);
  Future<void> createProfile(TutorProfile profile);
  Future<void> updateProfile(TutorProfile profile);
  Stream<TutorProfile?> watchProfile(String tutorId);
  Future<List<TutorProfile>> searchTutors({
    String? subject,
    double? maxRate,
    int page = 0,
    int pageSize = 20,
  });
}
