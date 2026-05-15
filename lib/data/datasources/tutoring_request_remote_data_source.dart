import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/models/tutoring_request_model.dart';
import 'package:ppu_connect/domain/enums/enums.dart';

abstract interface class TutoringRequestRemoteDataSource {
  Future<TutoringRequestModel> create(TutoringRequestModel request);
  Future<TutoringRequestModel?> getById(String id);
  Future<void> close(String id);
  Stream<List<TutoringRequestModel>> watchMyRequests(String seekerId);
  Future<List<TutoringRequestModel>> getOpenRequests({int page = 0, String? subject});
}

@Injectable(as: TutoringRequestRemoteDataSource)
class TutoringRequestRemoteDataSourceImpl
    implements TutoringRequestRemoteDataSource {
  const TutoringRequestRemoteDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('tutoringRequests');

  @override
  Future<TutoringRequestModel> create(TutoringRequestModel request) async {
    final doc = _col.doc(request.id.isEmpty ? null : request.id);
    final data = request.toJson();
    await doc.set(data);
    return TutoringRequestModel.fromJson({'id': doc.id, ...data});
  }

  @override
  Future<TutoringRequestModel?> getById(String id) async {
    final doc = await _col.doc(id).get();
    if (!doc.exists || doc.data() == null) return null;
    return TutoringRequestModel.fromJson({'id': id, ...doc.data()!});
  }

  @override
  Future<void> close(String id) => _col.doc(id).update({
        'status': RequestStatus.cancelled.name,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  @override
  Stream<List<TutoringRequestModel>> watchMyRequests(String seekerId) => _col
      .where('seekerId', isEqualTo: seekerId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) => s.docs
          .map((d) => TutoringRequestModel.fromJson({'id': d.id, ...d.data()}))
          .toList());

  @override
  Future<List<TutoringRequestModel>> getOpenRequests({
    int page = 0,
    String? subject,
  }) async {
    var q = _col
        .where('status', isEqualTo: RequestStatus.pending.name)
        .orderBy('createdAt', descending: true)
        .limit(20);

    final snap = await q.get();
    final models = snap.docs
        .map((d) => TutoringRequestModel.fromJson({'id': d.id, ...d.data()}))
        .toList();

    if (subject != null && subject.isNotEmpty) {
      return models
          .where((m) => m.subject.toLowerCase().contains(subject.toLowerCase()))
          .toList();
    }
    return models;
  }
}
