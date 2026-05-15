import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/models/tutor_profile_model.dart';

abstract interface class TutorProfileRemoteDataSource {
  Future<TutorProfileModel?> getProfile(String tutorId);
  Future<void> saveProfile(TutorProfileModel profile);
  Stream<TutorProfileModel?> watchProfile(String tutorId);
  Future<List<TutorProfileModel>> searchTutors({
    String? subject,
    double? maxRate,
    int page = 0,
    int pageSize = 20,
  });
}

@Injectable(as: TutorProfileRemoteDataSource)
class TutorProfileRemoteDataSourceImpl implements TutorProfileRemoteDataSource {
  const TutorProfileRemoteDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('tutorProfiles');

  @override
  Future<TutorProfileModel?> getProfile(String tutorId) async {
    final doc = await _col.doc(tutorId).get();
    if (!doc.exists || doc.data() == null) return null;
    return TutorProfileModel.fromJson({'userId': tutorId, ...doc.data()!});
  }

  @override
  Future<void> saveProfile(TutorProfileModel profile) =>
      _col.doc(profile.userId).set(profile.toJson(), SetOptions(merge: true));

  @override
  Stream<TutorProfileModel?> watchProfile(String tutorId) =>
      _col.doc(tutorId).snapshots().map(
            (doc) => doc.exists && doc.data() != null
                ? TutorProfileModel.fromJson({'userId': tutorId, ...doc.data()!})
                : null,
          );

  @override
  Future<List<TutorProfileModel>> searchTutors({
    String? subject,
    double? maxRate,
    int page = 0,
    int pageSize = 20,
  }) async {
    Query<Map<String, dynamic>> q = _col
        .where('isAcceptingRequests', isEqualTo: true)
        .orderBy('averageRating', descending: true)
        .limit(pageSize);

    if (maxRate != null) q = q.where('hourlyRate', isLessThanOrEqualTo: maxRate);

    final snap = await q.get();
    final models = snap.docs.map((d) {
      return TutorProfileModel.fromJson({'userId': d.id, ...d.data()});
    }).toList();

    if (subject != null && subject.isNotEmpty) {
      return models
          .where((m) => m.subjects.any(
                (s) => s.toLowerCase().contains(subject.toLowerCase()),
              ))
          .toList();
    }
    return models;
  }
}
