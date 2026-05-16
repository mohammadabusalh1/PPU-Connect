import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/firestore_converters.dart';
import '../../domain/entities/appointment_request.dart';
import '../../domain/enums/enums.dart';

part 'appointment_request_model.freezed.dart';
part 'appointment_request_model.g.dart';

@freezed
class AppointmentRequestModel with _$AppointmentRequestModel {
  const factory AppointmentRequestModel({
    required String id,
    required String senderId,
    required String senderName,
    String? senderAvatarUrl,
    required String receiverId,
    required String tutorId,
    required String seekerId,
    required String subject,
    String? note,
    @TimestampConverter() required DateTime proposedStartAt,
    @TimestampConverter() required DateTime proposedEndAt,
    @RequestStatusConverter() required RequestStatus status,
    String? linkedTutoringRequestId,
    @TimestampConverter() required DateTime expiresAt,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _AppointmentRequestModel;

  factory AppointmentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentRequestModelFromJson(json);

  factory AppointmentRequestModel.fromEntity(AppointmentRequest entity) =>
      AppointmentRequestModel(
        id: entity.id,
        senderId: entity.senderId,
        senderName: entity.senderName,
        senderAvatarUrl: entity.senderAvatarUrl,
        receiverId: entity.receiverId,
        tutorId: entity.tutorId,
        seekerId: entity.seekerId,
        subject: entity.subject,
        note: entity.note,
        proposedStartAt: entity.proposedStartAt,
        proposedEndAt: entity.proposedEndAt,
        status: entity.status,
        linkedTutoringRequestId: entity.linkedTutoringRequestId,
        expiresAt: entity.expiresAt,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}

extension AppointmentRequestModelX on AppointmentRequestModel {
  AppointmentRequest toEntity() => AppointmentRequest(
        id: id,
        senderId: senderId,
        senderName: senderName,
        senderAvatarUrl: senderAvatarUrl,
        receiverId: receiverId,
        tutorId: tutorId,
        seekerId: seekerId,
        subject: subject,
        note: note,
        proposedStartAt: proposedStartAt,
        proposedEndAt: proposedEndAt,
        status: status,
        linkedTutoringRequestId: linkedTutoringRequestId,
        expiresAt: expiresAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
