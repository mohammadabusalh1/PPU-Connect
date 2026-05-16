// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppointmentRequestModel _$AppointmentRequestModelFromJson(
  Map<String, dynamic> json,
) {
  return _AppointmentRequestModel.fromJson(json);
}

/// @nodoc
mixin _$AppointmentRequestModel {
  String get id => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  String? get senderAvatarUrl => throw _privateConstructorUsedError;
  String get receiverId => throw _privateConstructorUsedError;
  String get tutorId => throw _privateConstructorUsedError;
  String get seekerId => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get proposedStartAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get proposedEndAt => throw _privateConstructorUsedError;
  @RequestStatusConverter()
  RequestStatus get status => throw _privateConstructorUsedError;
  String? get linkedTutoringRequestId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get expiresAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AppointmentRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppointmentRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentRequestModelCopyWith<AppointmentRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentRequestModelCopyWith<$Res> {
  factory $AppointmentRequestModelCopyWith(
    AppointmentRequestModel value,
    $Res Function(AppointmentRequestModel) then,
  ) = _$AppointmentRequestModelCopyWithImpl<$Res, AppointmentRequestModel>;
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderName,
    String? senderAvatarUrl,
    String receiverId,
    String tutorId,
    String seekerId,
    String subject,
    String? note,
    @TimestampConverter() DateTime proposedStartAt,
    @TimestampConverter() DateTime proposedEndAt,
    @RequestStatusConverter() RequestStatus status,
    String? linkedTutoringRequestId,
    @TimestampConverter() DateTime expiresAt,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class _$AppointmentRequestModelCopyWithImpl<
  $Res,
  $Val extends AppointmentRequestModel
>
    implements $AppointmentRequestModelCopyWith<$Res> {
  _$AppointmentRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppointmentRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? senderAvatarUrl = freezed,
    Object? receiverId = null,
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
abstract class _$$AppointmentRequestModelImplCopyWith<$Res>
    implements $AppointmentRequestModelCopyWith<$Res> {
  factory _$$AppointmentRequestModelImplCopyWith(
    _$AppointmentRequestModelImpl value,
    $Res Function(_$AppointmentRequestModelImpl) then,
  ) = __$$AppointmentRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderName,
    String? senderAvatarUrl,
    String receiverId,
    String tutorId,
    String seekerId,
    String subject,
    String? note,
    @TimestampConverter() DateTime proposedStartAt,
    @TimestampConverter() DateTime proposedEndAt,
    @RequestStatusConverter() RequestStatus status,
    String? linkedTutoringRequestId,
    @TimestampConverter() DateTime expiresAt,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class __$$AppointmentRequestModelImplCopyWithImpl<$Res>
    extends
        _$AppointmentRequestModelCopyWithImpl<
          $Res,
          _$AppointmentRequestModelImpl
        >
    implements _$$AppointmentRequestModelImplCopyWith<$Res> {
  __$$AppointmentRequestModelImplCopyWithImpl(
    _$AppointmentRequestModelImpl _value,
    $Res Function(_$AppointmentRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppointmentRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? senderAvatarUrl = freezed,
    Object? receiverId = null,
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
      _$AppointmentRequestModelImpl(
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
@JsonSerializable()
class _$AppointmentRequestModelImpl implements _AppointmentRequestModel {
  const _$AppointmentRequestModelImpl({
    required this.id,
    required this.senderId,
    required this.senderName,
    this.senderAvatarUrl,
    required this.receiverId,
    required this.tutorId,
    required this.seekerId,
    required this.subject,
    this.note,
    @TimestampConverter() required this.proposedStartAt,
    @TimestampConverter() required this.proposedEndAt,
    @RequestStatusConverter() required this.status,
    this.linkedTutoringRequestId,
    @TimestampConverter() required this.expiresAt,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.updatedAt,
  });

  factory _$AppointmentRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentRequestModelImplFromJson(json);

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
  final String tutorId;
  @override
  final String seekerId;
  @override
  final String subject;
  @override
  final String? note;
  @override
  @TimestampConverter()
  final DateTime proposedStartAt;
  @override
  @TimestampConverter()
  final DateTime proposedEndAt;
  @override
  @RequestStatusConverter()
  final RequestStatus status;
  @override
  final String? linkedTutoringRequestId;
  @override
  @TimestampConverter()
  final DateTime expiresAt;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'AppointmentRequestModel(id: $id, senderId: $senderId, senderName: $senderName, senderAvatarUrl: $senderAvatarUrl, receiverId: $receiverId, tutorId: $tutorId, seekerId: $seekerId, subject: $subject, note: $note, proposedStartAt: $proposedStartAt, proposedEndAt: $proposedEndAt, status: $status, linkedTutoringRequestId: $linkedTutoringRequestId, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderAvatarUrl, senderAvatarUrl) ||
                other.senderAvatarUrl == senderAvatarUrl) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    senderId,
    senderName,
    senderAvatarUrl,
    receiverId,
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

  /// Create a copy of AppointmentRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentRequestModelImplCopyWith<_$AppointmentRequestModelImpl>
  get copyWith =>
      __$$AppointmentRequestModelImplCopyWithImpl<
        _$AppointmentRequestModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentRequestModelImplToJson(this);
  }
}

abstract class _AppointmentRequestModel implements AppointmentRequestModel {
  const factory _AppointmentRequestModel({
    required final String id,
    required final String senderId,
    required final String senderName,
    final String? senderAvatarUrl,
    required final String receiverId,
    required final String tutorId,
    required final String seekerId,
    required final String subject,
    final String? note,
    @TimestampConverter() required final DateTime proposedStartAt,
    @TimestampConverter() required final DateTime proposedEndAt,
    @RequestStatusConverter() required final RequestStatus status,
    final String? linkedTutoringRequestId,
    @TimestampConverter() required final DateTime expiresAt,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime updatedAt,
  }) = _$AppointmentRequestModelImpl;

  factory _AppointmentRequestModel.fromJson(Map<String, dynamic> json) =
      _$AppointmentRequestModelImpl.fromJson;

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
  String get tutorId;
  @override
  String get seekerId;
  @override
  String get subject;
  @override
  String? get note;
  @override
  @TimestampConverter()
  DateTime get proposedStartAt;
  @override
  @TimestampConverter()
  DateTime get proposedEndAt;
  @override
  @RequestStatusConverter()
  RequestStatus get status;
  @override
  String? get linkedTutoringRequestId;
  @override
  @TimestampConverter()
  DateTime get expiresAt;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of AppointmentRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentRequestModelImplCopyWith<_$AppointmentRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
