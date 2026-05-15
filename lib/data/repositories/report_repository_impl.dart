import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/datasources/report_remote_data_source.dart';
import 'package:ppu_connect/data/models/report_model.dart';
import 'package:ppu_connect/domain/entities/report.dart';
import 'package:ppu_connect/domain/repositories/report_repository.dart';

@Injectable(as: ReportRepository)
class ReportRepositoryImpl implements ReportRepository {
  const ReportRepositoryImpl(this._ds);
  final ReportRemoteDataSource _ds;

  @override
  Future<void> submitReport(Report report) =>
      _ds.submitReport(ReportModel.fromEntity(report));

  @override
  Stream<List<Report>> watchMyReports(String reporterId) => _ds
      .watchMyReports(reporterId)
      .map((list) => list.map((m) => m.toEntity()).toList());
}
