import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/datasources/tutoring_request_remote_data_source.dart';
import 'package:ppu_connect/data/models/tutoring_request_model.dart';
import 'package:ppu_connect/domain/entities/tutoring_request.dart';
import 'package:ppu_connect/domain/repositories/tutoring_request_repository.dart';

@Injectable(as: TutoringRequestRepository)
class TutoringRequestRepositoryImpl implements TutoringRequestRepository {
  const TutoringRequestRepositoryImpl(this._ds);
  final TutoringRequestRemoteDataSource _ds;

  @override
  Future<TutoringRequest> create(TutoringRequest request) async {
    final m = await _ds.create(TutoringRequestModel.fromEntity(request));
    return m.toEntity();
  }

  @override
  Future<TutoringRequest?> getById(String id) async {
    final m = await _ds.getById(id);
    return m?.toEntity();
  }

  @override
  Future<void> close(String id) => _ds.close(id);

  @override
  Stream<List<TutoringRequest>> watchMyRequests(String seekerId) =>
      _ds.watchMyRequests(seekerId).map((list) => list.map((m) => m.toEntity()).toList());

  @override
  Future<List<TutoringRequest>> getOpenRequests({
    int page = 0,
    String? subject,
  }) async {
    final models = await _ds.getOpenRequests(page: page, subject: subject);
    return models.map((m) => m.toEntity()).toList();
  }
}
