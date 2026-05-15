import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/tutoring_request.dart';
import 'package:ppu_connect/domain/repositories/tutoring_request_repository.dart';

part 'tutoring_requests_state.dart';

@injectable
class TutoringRequestsCubit extends Cubit<TutoringRequestsState> {
  TutoringRequestsCubit(this._repo) : super(const TutoringRequestsInitial());
  final TutoringRequestRepository _repo;
  StreamSubscription<List<TutoringRequest>>? _sub;

  void watchMy(String seekerId) {
    _sub?.cancel();
    emit(const TutoringRequestsLoading());
    _sub = _repo.watchMyRequests(seekerId).listen(
      (list) {
        if (isClosed) return;
        emit(TutoringRequestsLoaded(requests: list));
      },
      onError: (e) {
        if (isClosed) return;
        emit(TutoringRequestsError(e.toString().replaceFirst('Exception: ', '')));
      },
    );
  }

  Future<void> loadOpen({String? subject}) async {
    emit(const TutoringRequestsLoading());
    try {
      final list = await _repo.getOpenRequests(subject: subject);
      if (isClosed) return;
      emit(TutoringRequestsLoaded(requests: list));
    } catch (e) {
      if (isClosed) return;
      emit(TutoringRequestsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> create(TutoringRequest request) async {
    try {
      await _repo.create(request);
    } catch (e) {
      if (isClosed) return;
      emit(TutoringRequestsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> closeRequest(String id) async {
    try {
      await _repo.close(id);
    } catch (e) {
      if (isClosed) return;
      emit(TutoringRequestsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
