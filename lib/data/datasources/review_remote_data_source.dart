import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/models/review_model.dart';

abstract interface class ReviewRemoteDataSource {
  Future<void> submitReview(ReviewModel review);
  Future<List<ReviewModel>> getReviewsForTutor(String tutorId, {int page = 0});
  Stream<List<ReviewModel>> watchReviewsForTutor(String tutorId);
  Future<List<ReviewModel>> getReviewsGiven(String authorId, {int page = 0});
}

@Injectable(as: ReviewRemoteDataSource)
class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  const ReviewRemoteDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('reviews');

  @override
  Future<void> submitReview(ReviewModel review) =>
      _col.doc(review.id.isEmpty ? null : review.id).set(review.toJson());

  @override
  Future<List<ReviewModel>> getReviewsForTutor(
    String tutorId, {
    int page = 0,
  }) async {
    final snap = await _col
        .where('tutorId', isEqualTo: tutorId)
        .where('isVisible', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .limit(20)
        .get();
    return snap.docs
        .map((d) => ReviewModel.fromJson({'id': d.id, ...d.data()}))
        .toList();
  }

  @override
  Stream<List<ReviewModel>> watchReviewsForTutor(String tutorId) => _col
      .where('tutorId', isEqualTo: tutorId)
      .where('isVisible', isEqualTo: true)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) =>
          s.docs.map((d) => ReviewModel.fromJson({'id': d.id, ...d.data()})).toList());

  @override
  Future<List<ReviewModel>> getReviewsGiven(
    String authorId, {
    int page = 0,
  }) async {
    final snap = await _col
        .where('authorId', isEqualTo: authorId)
        .orderBy('createdAt', descending: true)
        .limit(20)
        .get();
    return snap.docs
        .map((d) => ReviewModel.fromJson({'id': d.id, ...d.data()}))
        .toList();
  }
}
