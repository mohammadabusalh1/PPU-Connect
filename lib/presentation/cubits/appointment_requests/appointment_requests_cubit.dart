import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/appointment_request.dart';
import 'package:ppu_connect/domain/repositories/appointment_repository.dart';

part 'appointment_requests_state.dart';

@injectable
class AppointmentRequestsCubit extends Cubit<AppointmentRequestsState> {
  AppointmentRequestsCubit(this._repo)
      : super(const AppointmentRequestsInitial());
  final AppointmentRepository _repo;
  StreamSubscription<List<AppointmentRequest>>? _sub;

  void watchIncoming(String tutorId) => _watch(_repo.watchIncomingRequests(tutorId));
  void watchSent(String senderId) => _watch(_repo.watchSentRequests(senderId));

  void _watch(Stream<List<AppointmentRequest>> stream) {
    _sub?.cancel();
    emit(const AppointmentRequestsLoading());
    _sub = stream.listen(
      (list) {
        if (isClosed) return;
        emit(AppointmentRequestsLoaded(requests: list));
      },
      onError: (e) {
        if (isClosed) return;
        emit(AppointmentRequestsError(e.toString().replaceFirst('Exception: ', '')));
      },
    );
  }

  Future<void> accept(String requestId) async {
    try {
      await _repo.acceptRequest(requestId);
    } catch (e) {
      if (isClosed) return;
      emit(AppointmentRequestsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> reject(String requestId, {String? reason}) async {
    try {
      await _repo.rejectRequest(requestId, reason: reason);
    } catch (e) {
      if (isClosed) return;
      emit(AppointmentRequestsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> sendRequest(AppointmentRequest request) async {
    try {
      await _repo.sendRequest(request);
    } catch (e) {
      if (isClosed) return;
      emit(AppointmentRequestsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> cancel(String requestId) async {
    try {
      await _repo.cancelRequest(requestId);
    } catch (e) {
      if (isClosed) return;
      emit(AppointmentRequestsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
