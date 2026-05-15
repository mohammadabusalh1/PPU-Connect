import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/datasources/tutor_profile_remote_data_source.dart';
import 'package:ppu_connect/data/models/tutor_profile_model.dart';
import 'package:ppu_connect/domain/entities/tutor_profile.dart';
import 'package:ppu_connect/domain/repositories/tutor_profile_repository.dart';

@Injectable(as: TutorProfileRepository)
class TutorProfileRepositoryImpl implements TutorProfileRepository {
  const TutorProfileRepositoryImpl(this._ds);
  final TutorProfileRemoteDataSource _ds;

  @override
  Future<TutorProfile?> getProfile(String tutorId) async {
    final m = await _ds.getProfile(tutorId);
    return m?.toEntity();
  }

  @override
  Future<void> createProfile(TutorProfile profile) =>
      _ds.saveProfile(TutorProfileModel.fromEntity(profile));

  @override
  Future<void> updateProfile(TutorProfile profile) =>
      _ds.saveProfile(TutorProfileModel.fromEntity(profile));

  @override
  Stream<TutorProfile?> watchProfile(String tutorId) =>
      _ds.watchProfile(tutorId).map((m) => m?.toEntity());

  @override
  Future<List<TutorProfile>> searchTutors({
    String? subject,
    double? maxRate,
    int page = 0,
    int pageSize = 20,
  }) async {
    final models = await _ds.searchTutors(
      subject: subject,
      maxRate: maxRate,
      page: page,
      pageSize: pageSize,
    );
    return models.map((m) => m.toEntity()).toList();
  }
}
