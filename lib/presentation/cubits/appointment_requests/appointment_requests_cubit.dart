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

  /// Loads [requestId] to decide incoming vs sent stream (fixes [UserRole.both]).
  Future<void> watchForDetail({
    required String userId,
    required String requestId,
  }) async {
    emit(const AppointmentRequestsLoading());
    try {
      final request = await _repo.getRequest(requestId);
      if (isClosed) return;
      if (request == null) {
        emit(const AppointmentRequestsError('Request not found'));
        return;
      }
      if (request.tutorId == userId) {
        watchIncoming(userId);
      } else if (request.seekerId == userId) {
        watchSent(userId);
      } else {
        emit(const AppointmentRequestsError('Request not found'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(AppointmentRequestsError(_messageFrom(e)));
    }
  }

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
        emit(AppointmentRequestsError(_messageFrom(e)));
      },
    );
  }

  Future<({bool ok, String? error})> accept(String requestId) async {
    try {
      await _repo.acceptRequest(requestId);
      return (ok: true, error: null);
    } catch (e) {
      return (ok: false, error: _messageFrom(e));
    }
  }

  Future<({bool ok, String? error})> reject(
    String requestId, {
    String? reason,
  }) async {
    try {
      await _repo.rejectRequest(requestId, reason: reason);
      return (ok: true, error: null);
    } catch (e) {
      return (ok: false, error: _messageFrom(e));
    }
  }

  Future<({bool ok, String? error})> sendRequest(
    AppointmentRequest request,
  ) async {
    try {
      await _repo.sendRequest(request);
      return (ok: true, error: null);
    } catch (e) {
      return (ok: false, error: _messageFrom(e));
    }
  }

  Future<({bool ok, String? error})> cancel(String requestId) async {
    try {
      await _repo.cancelRequest(requestId);
      return (ok: true, error: null);
    } catch (e) {
      return (ok: false, error: _messageFrom(e));
    }
  }

  String _messageFrom(Object e) =>
      e.toString().replaceFirst('Exception: ', '');

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
