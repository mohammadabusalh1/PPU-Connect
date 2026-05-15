import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/datasources/session_confirmation_remote_data_source.dart';
import 'package:ppu_connect/data/models/session_confirmation_model.dart';
import 'package:ppu_connect/domain/entities/session_confirmation.dart';
import 'package:ppu_connect/domain/repositories/session_confirmation_repository.dart';

@Injectable(as: SessionConfirmationRepository)
class SessionConfirmationRepositoryImpl
    implements SessionConfirmationRepository {
  const SessionConfirmationRepositoryImpl(this._ds);
  final SessionConfirmationRemoteDataSource _ds;

  @override
  Future<SessionConfirmation?> getForAppointment(String appointmentId) async {
    final m = await _ds.getForAppointment(appointmentId);
    return m?.toEntity();
  }

  @override
  Future<void> confirmAttendance(String appointmentId, String userId) =>
      _ds.confirmAttendance(appointmentId, userId);

  @override
  Future<void> reportNoShow(String appointmentId, String reporterId) =>
      _ds.reportNoShow(appointmentId, reporterId);

  @override
  Stream<SessionConfirmation?> watchForAppointment(String appointmentId) =>
      _ds.watchForAppointment(appointmentId).map((m) => m?.toEntity());
}
