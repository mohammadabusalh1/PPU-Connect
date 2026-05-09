import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/firestore_converters.dart';
import '../../domain/entities/tutoring_request.dart';
import '../../domain/enums/enums.dart';
import '../../domain/value_objects/time_range.dart';

part 'tutoring_request_model.freezed.dart';
part 'tutoring_request_model.g.dart';

@freezed
class TutoringRequestModel with _$TutoringRequestModel {
  const factory TutoringRequestModel({
    required String id,
    required String seekerId,
    required String subject,
    required String description,
    required List<int> preferredDays,
    @NullableTimeRangeConverter() TimeRange? preferredTimeRange,
    @RequestStatusConverter() required RequestStatus status,
    required List<String> respondedTutorIds,
    @TimestampConverter() required DateTime expiresAt,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _TutoringRequestModel;

  factory TutoringRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TutoringRequestModelFromJson(json);

  factory TutoringRequestModel.fromEntity(TutoringRequest entity) =>
      TutoringRequestModel(
        id: entity.id,
        seekerId: entity.seekerId,
        subject: entity.subject,
        description: entity.description,
        preferredDays: List<int>.from(entity.preferredDays),
        preferredTimeRange: entity.preferredTimeRange,
        status: entity.status,
        respondedTutorIds: List<String>.from(entity.respondedTutorIds),
        expiresAt: entity.expiresAt,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}

extension TutoringRequestModelX on TutoringRequestModel {
  TutoringRequest toEntity() => TutoringRequest(
        id: id,
        seekerId: seekerId,
        subject: subject,
        description: description,
        preferredDays: preferredDays,
        preferredTimeRange: preferredTimeRange,
        status: status,
        respondedTutorIds: respondedTutorIds,
        expiresAt: expiresAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
