import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/models/report_model.dart';

abstract interface class ReportRemoteDataSource {
  Future<void> submitReport(ReportModel report);
  Stream<List<ReportModel>> watchMyReports(String reporterId);
}

@Injectable(as: ReportRemoteDataSource)
class ReportRemoteDataSourceImpl implements ReportRemoteDataSource {
  const ReportRemoteDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('reports');

  @override
  Future<void> submitReport(ReportModel report) =>
      _col.doc(report.id.isEmpty ? null : report.id).set(report.toJson());

  @override
  Stream<List<ReportModel>> watchMyReports(String reporterId) => _col
      .where('reporterId', isEqualTo: reporterId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) =>
          s.docs.map((d) => ReportModel.fromJson({'id': d.id, ...d.data()})).toList());
}
