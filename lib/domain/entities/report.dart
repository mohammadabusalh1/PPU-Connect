import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/enums.dart';

part 'report.freezed.dart';

@freezed
class Report with _$Report {
  const factory Report({
    required String id,
    required String reporterId,
    required String reportedUserId,
    String? appointmentId,
    required ReportReason reason,
    required String description,
    required ReportStatus status,
    DateTime? resolvedAt,
    String? adminNote,
    required DateTime createdAt,
  }) = _Report;
}
