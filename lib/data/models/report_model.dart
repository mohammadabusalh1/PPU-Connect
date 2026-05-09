import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/firestore_converters.dart';
import '../../domain/entities/report.dart';
import '../../domain/enums/enums.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

@freezed
class ReportModel with _$ReportModel {
  const factory ReportModel({
    required String id,
    required String reporterId,
    required String reportedUserId,
    String? appointmentId,
    @ReportReasonConverter() required ReportReason reason,
    required String description,
    @ReportStatusConverter() required ReportStatus status,
    @NullableTimestampConverter() DateTime? resolvedAt,
    String? adminNote,
    @TimestampConverter() required DateTime createdAt,
  }) = _ReportModel;

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  factory ReportModel.fromEntity(Report entity) => ReportModel(
        id: entity.id,
        reporterId: entity.reporterId,
        reportedUserId: entity.reportedUserId,
        appointmentId: entity.appointmentId,
        reason: entity.reason,
        description: entity.description,
        status: entity.status,
        resolvedAt: entity.resolvedAt,
        adminNote: entity.adminNote,
        createdAt: entity.createdAt,
      );
}

extension ReportModelX on ReportModel {
  Report toEntity() => Report(
        id: id,
        reporterId: reporterId,
        reportedUserId: reportedUserId,
        appointmentId: appointmentId,
        reason: reason,
        description: description,
        status: status,
        resolvedAt: resolvedAt,
        adminNote: adminNote,
        createdAt: createdAt,
      );
}
