import 'package:ppu_connect/domain/entities/tutoring_request.dart';

abstract interface class TutoringRequestRepository {
  Future<TutoringRequest> create(TutoringRequest request);
  Future<TutoringRequest?> getById(String id);
  Future<void> close(String id);
  Stream<List<TutoringRequest>> watchMyRequests(String seekerId);
  Future<List<TutoringRequest>> getOpenRequests({int page = 0, String? subject});
}
