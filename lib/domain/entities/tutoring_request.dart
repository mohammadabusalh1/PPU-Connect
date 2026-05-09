import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/enums.dart';
import '../value_objects/time_range.dart';

part 'tutoring_request.freezed.dart';

@freezed
class TutoringRequest with _$TutoringRequest {
  const factory TutoringRequest({
    required String id,
    required String seekerId,
    required String subject,
    required String description,
    required List<int> preferredDays,
    TimeRange? preferredTimeRange,
    required RequestStatus status,
    required List<String> respondedTutorIds,
    required DateTime expiresAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _TutoringRequest;
}
