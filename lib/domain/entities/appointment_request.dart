import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/enums.dart';

part 'appointment_request.freezed.dart';

@freezed
class AppointmentRequest with _$AppointmentRequest {
  const factory AppointmentRequest({
    required String id,
    required String senderId,
    required String senderName,
    String? senderAvatarUrl,
    required String receiverId,
    required String tutorId,
    required String seekerId,
    required String subject,
    String? note,
    required DateTime proposedStartAt,
    required DateTime proposedEndAt,
    required RequestStatus status,
    String? linkedTutoringRequestId,
    required DateTime expiresAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AppointmentRequest;
}
