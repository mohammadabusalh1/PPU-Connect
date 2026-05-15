import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/report.dart';
import 'package:ppu_connect/domain/repositories/report_repository.dart';

part 'reports_state.dart';

@injectable
class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit(this._repo) : super(const ReportsInitial());
  final ReportRepository _repo;
  StreamSubscription<List<Report>>? _sub;

  void watchMy(String reporterId) {
    _sub?.cancel();
    emit(const ReportsLoading());
    _sub = _repo.watchMyReports(reporterId).listen(
      (list) {
        if (isClosed) return;
        emit(ReportsLoaded(reports: list));
      },
      onError: (e) {
        if (isClosed) return;
        emit(ReportsError(e.toString().replaceFirst('Exception: ', '')));
      },
    );
  }

  Future<void> submit(Report report) async {
    try {
      await _repo.submitReport(report);
      if (isClosed) return;
      emit(const ReportSubmitSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(ReportsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
