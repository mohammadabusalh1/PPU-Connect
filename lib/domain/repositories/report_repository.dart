import 'package:ppu_connect/domain/entities/report.dart';

abstract interface class ReportRepository {
  Future<void> submitReport(Report report);
  Stream<List<Report>> watchMyReports(String reporterId);
}
