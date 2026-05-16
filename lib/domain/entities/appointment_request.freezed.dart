// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppointmentRequest {
  String get id => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  String? get senderAvatarUrl => throw _privateConstructorUsedError;
  String get receiverId => throw _privateConstructorUsedError;
  String? get receiverName => throw _privateConstructorUsedError;
  String? get receiverAvatarUrl => throw _privateConstructorUsedError;
  String get tutorId => throw _privateConstructorUsedError;
  String get seekerId => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  DateTime get proposedStartAt => throw _privateConstructorUsedError;
  DateTime get proposedEndAt => throw _privateConstructorUsedError;
  RequestStatus get status => throw _privateConstructorUsedError;
  String? get linkedTutoringRequestId => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of AppointmentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentRequestCopyWith<AppointmentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentRequestCopyWith<$Res> {
  factory $AppointmentRequestCopyWith(
    AppointmentRequest value,
    $Res Function(AppointmentRequest) then,
  ) = _$AppointmentRequestCopyWithImpl<$Res, AppointmentRequest>;
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderName,
    String? senderAvatarUrl,
    String receiverId,
    String? receiverName,
    String? receiverAvatarUrl,
    String tutorId,
    String seekerId,
    String subject,
    String? note,
    DateTime proposedStartAt,
    DateTime proposedEndAt,
    RequestStatus status,
    String? linkedTutoringRequestId,
    DateTime expiresAt,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$AppointmentRequestCopyWithImpl<$Res, $Val extends AppointmentRequest>
    implements $AppointmentRequestCopyWith<$Res> {
  _$AppointmentRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppointmentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? senderAvatarUrl = freezed,
    Object? receiverId = null,
    Object? receiverName = freezed,
    Object? receiverAvatarUrl = freezed,
    Object? tutorId = null,
    Object? seekerId = null,
    Object? subject = null,
    Object? note = freezed,
    Object? proposedStartAt = null,
    Object? proposedEndAt = null,
    Object? status = null,
    Object? linkedTutoringRequestId = freezed,
    Object? expiresAt = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            senderId: null == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderName: null == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                      as String,
            senderAvatarUrl: freezed == senderAvatarUrl
                ? _value.senderAvatarUrl
                : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            receiverId: null == receiverId
                ? _value.receiverId
                : receiverId // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverName: freezed == receiverName
                ? _value.receiverName
                : receiverName // ignore: cast_nullable_to_non_nullable
                      as String?,
            receiverAvatarUrl: freezed == receiverAvatarUrl
                ? _value.receiverAvatarUrl
                : receiverAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            tutorId: null == tutorId
                ? _value.tutorId
                : tutorId // ignore: cast_nullable_to_non_nullable
                      as String,
            seekerId: null == seekerId
                ? _value.seekerId
                : seekerId // ignore: cast_nullable_to_non_nullable
                      as String,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            proposedStartAt: null == proposedStartAt
                ? _value.proposedStartAt
                : proposedStartAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            proposedEndAt: null == proposedEndAt
                ? _value.proposedEndAt
                : proposedEndAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RequestStatus,
            linkedTutoringRequestId: freezed == linkedTutoringRequestId
                ? _value.linkedTutoringRequestId
                : linkedTutoringRequestId // ignore: cast_nullable_to_non_nullable
                      as String?,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppointmentRequestImplCopyWith<$Res>
    implements $AppointmentRequestCopyWith<$Res> {
  factory _$$AppointmentRequestImplCopyWith(
    _$AppointmentRequestImpl value,
    $Res Function(_$AppointmentRequestImpl) then,
  ) = __$$AppointmentRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderName,
    String? senderAvatarUrl,
    String receiverId,
    String? receiverName,
    String? receiverAvatarUrl,
    String tutorId,
    String seekerId,
    String subject,
    String? note,
    DateTime proposedStartAt,
    DateTime proposedEndAt,
    RequestStatus status,
    String? linkedTutoringRequestId,
    DateTime expiresAt,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$AppointmentRequestImplCopyWithImpl<$Res>
    extends _$AppointmentRequestCopyWithImpl<$Res, _$AppointmentRequestImpl>
    implements _$$AppointmentRequestImplCopyWith<$Res> {
  __$$AppointmentRequestImplCopyWithImpl(
    _$AppointmentRequestImpl _value,
    $Res Function(_$AppointmentRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppointmentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? senderAvatarUrl = freezed,
    Object? receiverId = null,
    Object? receiverName = freezed,
    Object? receiverAvatarUrl = freezed,
    Object? tutorId = null,
    Object? seekerId = null,
    Object? subject = null,
    Object? note = freezed,
    Object? proposedStartAt = null,
    Object? proposedEndAt = null,
    Object? status = null,
    Object? linkedTutoringRequestId = freezed,
    Object? expiresAt = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$AppointmentRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        senderId: null == senderId
            ? _value.senderId
            : senderId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderName: null == senderName
            ? _value.senderName
            : senderName // ignore: cast_nullable_to_non_nullable
                  as String,
        senderAvatarUrl: freezed == senderAvatarUrl
            ? _value.senderAvatarUrl
            : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        receiverId: null == receiverId
            ? _value.receiverId
            : receiverId // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverName: freezed == receiverName
            ? _value.receiverName
            : receiverName // ignore: cast_nullable_to_non_nullable
                  as String?,
        receiverAvatarUrl: freezed == receiverAvatarUrl
            ? _value.receiverAvatarUrl
            : receiverAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        tutorId: null == tutorId
            ? _value.tutorId
            : tutorId // ignore: cast_nullable_to_non_nullable
                  as String,
        seekerId: null == seekerId
            ? _value.seekerId
            : seekerId // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        proposedStartAt: null == proposedStartAt
            ? _value.proposedStartAt
            : proposedStartAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        proposedEndAt: null == proposedEndAt
            ? _value.proposedEndAt
            : proposedEndAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RequestStatus,
        linkedTutoringRequestId: freezed == linkedTutoringRequestId
            ? _value.linkedTutoringRequestId
            : linkedTutoringRequestId // ignore: cast_nullable_to_non_nullable
                  as String?,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$AppointmentRequestImpl implements _AppointmentRequest {
  const _$AppointmentRequestImpl({
    required this.id,
    required this.senderId,
    required this.senderName,
    this.senderAvatarUrl,
    required this.receiverId,
    this.receiverName,
    this.receiverAvatarUrl,
    required this.tutorId,
    required this.seekerId,
    required this.subject,
    this.note,
    required this.proposedStartAt,
    required this.proposedEndAt,
    required this.status,
    this.linkedTutoringRequestId,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final String id;
  @override
  final String senderId;
  @override
  final String senderName;
  @override
  final String? senderAvatarUrl;
  @override
  final String receiverId;
  @override
  final String? receiverName;
  @override
  final String? receiverAvatarUrl;
  @override
  final String tutorId;
  @override
  final String seekerId;
  @override
  final String subject;
  @override
  final String? note;
  @override
  final DateTime proposedStartAt;
  @override
  final DateTime proposedEndAt;
  @override
  final RequestStatus status;
  @override
  final String? linkedTutoringRequestId;
  @override
  final DateTime expiresAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'AppointmentRequest(id: $id, senderId: $senderId, senderName: $senderName, senderAvatarUrl: $senderAvatarUrl, receiverId: $receiverId, receiverName: $receiverName, receiverAvatarUrl: $receiverAvatarUrl, tutorId: $tutorId, seekerId: $seekerId, subject: $subject, note: $note, proposedStartAt: $proposedStartAt, proposedEndAt: $proposedEndAt, status: $status, linkedTutoringRequestId: $linkedTutoringRequestId, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderAvatarUrl, senderAvatarUrl) ||
                other.senderAvatarUrl == senderAvatarUrl) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.receiverName, receiverName) ||
                other.receiverName == receiverName) &&
            (identical(other.receiverAvatarUrl, receiverAvatarUrl) ||
                other.receiverAvatarUrl == receiverAvatarUrl) &&
            (identical(other.tutorId, tutorId) || other.tutorId == tutorId) &&
            (identical(other.seekerId, seekerId) ||
                other.seekerId == seekerId) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.proposedStartAt, proposedStartAt) ||
                other.proposedStartAt == proposedStartAt) &&
            (identical(other.proposedEndAt, proposedEndAt) ||
                other.proposedEndAt == proposedEndAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(
                  other.linkedTutoringRequestId,
                  linkedTutoringRequestId,
                ) ||
                other.linkedTutoringRequestId == linkedTutoringRequestId) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    senderId,
    senderName,
    senderAvatarUrl,
    receiverId,
    receiverName,
    receiverAvatarUrl,
    tutorId,
    seekerId,
    subject,
    note,
    proposedStartAt,
    proposedEndAt,
    status,
    linkedTutoringRequestId,
    expiresAt,
    createdAt,
    updatedAt,
  );

  /// Create a copy of AppointmentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentRequestImplCopyWith<_$AppointmentRequestImpl> get copyWith =>
      __$$AppointmentRequestImplCopyWithImpl<_$AppointmentRequestImpl>(
        this,
        _$identity,
      );
}

abstract class _AppointmentRequest implements AppointmentRequest {
  const factory _AppointmentRequest({
    required final String id,
    required final String senderId,
    required final String senderName,
    final String? senderAvatarUrl,
    required final String receiverId,
    final String? receiverName,
    final String? receiverAvatarUrl,
    required final String tutorId,
    required final String seekerId,
    required final String subject,
    final String? note,
    required final DateTime proposedStartAt,
    required final DateTime proposedEndAt,
    required final RequestStatus status,
    final String? linkedTutoringRequestId,
    required final DateTime expiresAt,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$AppointmentRequestImpl;

  @override
  String get id;
  @override
  String get senderId;
  @override
  String get senderName;
  @override
  String? get senderAvatarUrl;
  @override
  String get receiverId;
  @override
  String? get receiverName;
  @override
  String? get receiverAvatarUrl;
  @override
  String get tutorId;
  @override
  String get seekerId;
  @override
  String get subject;
  @override
  String? get note;
  @override
  DateTime get proposedStartAt;
  @override
  DateTime get proposedEndAt;
  @override
  RequestStatus get status;
  @override
  String? get linkedTutoringRequestId;
  @override
  DateTime get expiresAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of AppointmentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentRequestImplCopyWith<_$AppointmentRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
