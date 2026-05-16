// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Appointment {
  String get id => throw _privateConstructorUsedError;
  String get appointmentRequestId => throw _privateConstructorUsedError;
  String get tutorId => throw _privateConstructorUsedError;
  String get seekerId => throw _privateConstructorUsedError;
  String? get tutorName => throw _privateConstructorUsedError;
  String? get seekerName => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  DateTime get startAt => throw _privateConstructorUsedError;
  DateTime get endAt => throw _privateConstructorUsedError;
  AppointmentStatus get status => throw _privateConstructorUsedError;
  String? get cancelledBy => throw _privateConstructorUsedError;
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  String? get cancellationReason => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentCopyWith<Appointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentCopyWith<$Res> {
  factory $AppointmentCopyWith(
    Appointment value,
    $Res Function(Appointment) then,
  ) = _$AppointmentCopyWithImpl<$Res, Appointment>;
  @useResult
  $Res call({
    String id,
    String appointmentRequestId,
    String tutorId,
    String seekerId,
    String? tutorName,
    String? seekerName,
    String subject,
    DateTime startAt,
    DateTime endAt,
    AppointmentStatus status,
    String? cancelledBy,
    DateTime? cancelledAt,
    String? cancellationReason,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$AppointmentCopyWithImpl<$Res, $Val extends Appointment>
    implements $AppointmentCopyWith<$Res> {
  _$AppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appointmentRequestId = null,
    Object? tutorId = null,
    Object? seekerId = null,
    Object? tutorName = freezed,
    Object? seekerName = freezed,
    Object? subject = null,
    Object? startAt = null,
    Object? endAt = null,
    Object? status = null,
    Object? cancelledBy = freezed,
    Object? cancelledAt = freezed,
    Object? cancellationReason = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            appointmentRequestId: null == appointmentRequestId
                ? _value.appointmentRequestId
                : appointmentRequestId // ignore: cast_nullable_to_non_nullable
                      as String,
            tutorId: null == tutorId
                ? _value.tutorId
                : tutorId // ignore: cast_nullable_to_non_nullable
                      as String,
            seekerId: null == seekerId
                ? _value.seekerId
                : seekerId // ignore: cast_nullable_to_non_nullable
                      as String,
            tutorName: freezed == tutorName
                ? _value.tutorName
                : tutorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            seekerName: freezed == seekerName
                ? _value.seekerName
                : seekerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            startAt: null == startAt
                ? _value.startAt
                : startAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endAt: null == endAt
                ? _value.endAt
                : endAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as AppointmentStatus,
            cancelledBy: freezed == cancelledBy
                ? _value.cancelledBy
                : cancelledBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            cancelledAt: freezed == cancelledAt
                ? _value.cancelledAt
                : cancelledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            cancellationReason: freezed == cancellationReason
                ? _value.cancellationReason
                : cancellationReason // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$AppointmentImplCopyWith<$Res>
    implements $AppointmentCopyWith<$Res> {
  factory _$$AppointmentImplCopyWith(
    _$AppointmentImpl value,
    $Res Function(_$AppointmentImpl) then,
  ) = __$$AppointmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String appointmentRequestId,
    String tutorId,
    String seekerId,
    String? tutorName,
    String? seekerName,
    String subject,
    DateTime startAt,
    DateTime endAt,
    AppointmentStatus status,
    String? cancelledBy,
    DateTime? cancelledAt,
    String? cancellationReason,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$AppointmentImplCopyWithImpl<$Res>
    extends _$AppointmentCopyWithImpl<$Res, _$AppointmentImpl>
    implements _$$AppointmentImplCopyWith<$Res> {
  __$$AppointmentImplCopyWithImpl(
    _$AppointmentImpl _value,
    $Res Function(_$AppointmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appointmentRequestId = null,
    Object? tutorId = null,
    Object? seekerId = null,
    Object? tutorName = freezed,
    Object? seekerName = freezed,
    Object? subject = null,
    Object? startAt = null,
    Object? endAt = null,
    Object? status = null,
    Object? cancelledBy = freezed,
    Object? cancelledAt = freezed,
    Object? cancellationReason = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$AppointmentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        appointmentRequestId: null == appointmentRequestId
            ? _value.appointmentRequestId
            : appointmentRequestId // ignore: cast_nullable_to_non_nullable
                  as String,
        tutorId: null == tutorId
            ? _value.tutorId
            : tutorId // ignore: cast_nullable_to_non_nullable
                  as String,
        seekerId: null == seekerId
            ? _value.seekerId
            : seekerId // ignore: cast_nullable_to_non_nullable
                  as String,
        tutorName: freezed == tutorName
            ? _value.tutorName
            : tutorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        seekerName: freezed == seekerName
            ? _value.seekerName
            : seekerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        startAt: null == startAt
            ? _value.startAt
            : startAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endAt: null == endAt
            ? _value.endAt
            : endAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AppointmentStatus,
        cancelledBy: freezed == cancelledBy
            ? _value.cancelledBy
            : cancelledBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        cancelledAt: freezed == cancelledAt
            ? _value.cancelledAt
            : cancelledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cancellationReason: freezed == cancellationReason
            ? _value.cancellationReason
            : cancellationReason // ignore: cast_nullable_to_non_nullable
                  as String?,
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

class _$AppointmentImpl implements _Appointment {
  const _$AppointmentImpl({
    required this.id,
    required this.appointmentRequestId,
    required this.tutorId,
    required this.seekerId,
    this.tutorName,
    this.seekerName,
    required this.subject,
    required this.startAt,
    required this.endAt,
    required this.status,
    this.cancelledBy,
    this.cancelledAt,
    this.cancellationReason,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final String id;
  @override
  final String appointmentRequestId;
  @override
  final String tutorId;
  @override
  final String seekerId;
  @override
  final String? tutorName;
  @override
  final String? seekerName;
  @override
  final String subject;
  @override
  final DateTime startAt;
  @override
  final DateTime endAt;
  @override
  final AppointmentStatus status;
  @override
  final String? cancelledBy;
  @override
  final DateTime? cancelledAt;
  @override
  final String? cancellationReason;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Appointment(id: $id, appointmentRequestId: $appointmentRequestId, tutorId: $tutorId, seekerId: $seekerId, tutorName: $tutorName, seekerName: $seekerName, subject: $subject, startAt: $startAt, endAt: $endAt, status: $status, cancelledBy: $cancelledBy, cancelledAt: $cancelledAt, cancellationReason: $cancellationReason, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appointmentRequestId, appointmentRequestId) ||
                other.appointmentRequestId == appointmentRequestId) &&
            (identical(other.tutorId, tutorId) || other.tutorId == tutorId) &&
            (identical(other.seekerId, seekerId) ||
                other.seekerId == seekerId) &&
            (identical(other.tutorName, tutorName) ||
                other.tutorName == tutorName) &&
            (identical(other.seekerName, seekerName) ||
                other.seekerName == seekerName) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.cancelledBy, cancelledBy) ||
                other.cancelledBy == cancelledBy) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.cancellationReason, cancellationReason) ||
                other.cancellationReason == cancellationReason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    appointmentRequestId,
    tutorId,
    seekerId,
    tutorName,
    seekerName,
    subject,
    startAt,
    endAt,
    status,
    cancelledBy,
    cancelledAt,
    cancellationReason,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentImplCopyWith<_$AppointmentImpl> get copyWith =>
      __$$AppointmentImplCopyWithImpl<_$AppointmentImpl>(this, _$identity);
}

abstract class _Appointment implements Appointment {
  const factory _Appointment({
    required final String id,
    required final String appointmentRequestId,
    required final String tutorId,
    required final String seekerId,
    final String? tutorName,
    final String? seekerName,
    required final String subject,
    required final DateTime startAt,
    required final DateTime endAt,
    required final AppointmentStatus status,
    final String? cancelledBy,
    final DateTime? cancelledAt,
    final String? cancellationReason,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$AppointmentImpl;

  @override
  String get id;
  @override
  String get appointmentRequestId;
  @override
  String get tutorId;
  @override
  String get seekerId;
  @override
  String? get tutorName;
  @override
  String? get seekerName;
  @override
  String get subject;
  @override
  DateTime get startAt;
  @override
  DateTime get endAt;
  @override
  AppointmentStatus get status;
  @override
  String? get cancelledBy;
  @override
  DateTime? get cancelledAt;
  @override
  String? get cancellationReason;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentImplCopyWith<_$AppointmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
