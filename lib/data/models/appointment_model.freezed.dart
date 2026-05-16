// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) {
  return _AppointmentModel.fromJson(json);
}

/// @nodoc
mixin _$AppointmentModel {
  String get id => throw _privateConstructorUsedError;
  String get appointmentRequestId => throw _privateConstructorUsedError;
  String get tutorId => throw _privateConstructorUsedError;
  String get seekerId => throw _privateConstructorUsedError;
  String? get tutorName => throw _privateConstructorUsedError;
  String? get seekerName => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get startAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get endAt => throw _privateConstructorUsedError;
  @AppointmentStatusConverter()
  AppointmentStatus get status => throw _privateConstructorUsedError;
  String? get cancelledBy => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  String? get cancellationReason => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AppointmentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentModelCopyWith<AppointmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentModelCopyWith<$Res> {
  factory $AppointmentModelCopyWith(
    AppointmentModel value,
    $Res Function(AppointmentModel) then,
  ) = _$AppointmentModelCopyWithImpl<$Res, AppointmentModel>;
  @useResult
  $Res call({
    String id,
    String appointmentRequestId,
    String tutorId,
    String seekerId,
    String? tutorName,
    String? seekerName,
    String subject,
    @TimestampConverter() DateTime startAt,
    @TimestampConverter() DateTime endAt,
    @AppointmentStatusConverter() AppointmentStatus status,
    String? cancelledBy,
    @NullableTimestampConverter() DateTime? cancelledAt,
    String? cancellationReason,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class _$AppointmentModelCopyWithImpl<$Res, $Val extends AppointmentModel>
    implements $AppointmentModelCopyWith<$Res> {
  _$AppointmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppointmentModel
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
abstract class _$$AppointmentModelImplCopyWith<$Res>
    implements $AppointmentModelCopyWith<$Res> {
  factory _$$AppointmentModelImplCopyWith(
    _$AppointmentModelImpl value,
    $Res Function(_$AppointmentModelImpl) then,
  ) = __$$AppointmentModelImplCopyWithImpl<$Res>;
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
    @TimestampConverter() DateTime startAt,
    @TimestampConverter() DateTime endAt,
    @AppointmentStatusConverter() AppointmentStatus status,
    String? cancelledBy,
    @NullableTimestampConverter() DateTime? cancelledAt,
    String? cancellationReason,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class __$$AppointmentModelImplCopyWithImpl<$Res>
    extends _$AppointmentModelCopyWithImpl<$Res, _$AppointmentModelImpl>
    implements _$$AppointmentModelImplCopyWith<$Res> {
  __$$AppointmentModelImplCopyWithImpl(
    _$AppointmentModelImpl _value,
    $Res Function(_$AppointmentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppointmentModel
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
      _$AppointmentModelImpl(
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
@JsonSerializable()
class _$AppointmentModelImpl implements _AppointmentModel {
  const _$AppointmentModelImpl({
    required this.id,
    required this.appointmentRequestId,
    required this.tutorId,
    required this.seekerId,
    this.tutorName,
    this.seekerName,
    required this.subject,
    @TimestampConverter() required this.startAt,
    @TimestampConverter() required this.endAt,
    @AppointmentStatusConverter() required this.status,
    this.cancelledBy,
    @NullableTimestampConverter() this.cancelledAt,
    this.cancellationReason,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.updatedAt,
  });

  factory _$AppointmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentModelImplFromJson(json);

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
  @TimestampConverter()
  final DateTime startAt;
  @override
  @TimestampConverter()
  final DateTime endAt;
  @override
  @AppointmentStatusConverter()
  final AppointmentStatus status;
  @override
  final String? cancelledBy;
  @override
  @NullableTimestampConverter()
  final DateTime? cancelledAt;
  @override
  final String? cancellationReason;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'AppointmentModel(id: $id, appointmentRequestId: $appointmentRequestId, tutorId: $tutorId, seekerId: $seekerId, tutorName: $tutorName, seekerName: $seekerName, subject: $subject, startAt: $startAt, endAt: $endAt, status: $status, cancelledBy: $cancelledBy, cancelledAt: $cancelledAt, cancellationReason: $cancellationReason, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of AppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentModelImplCopyWith<_$AppointmentModelImpl> get copyWith =>
      __$$AppointmentModelImplCopyWithImpl<_$AppointmentModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentModelImplToJson(this);
  }
}

abstract class _AppointmentModel implements AppointmentModel {
  const factory _AppointmentModel({
    required final String id,
    required final String appointmentRequestId,
    required final String tutorId,
    required final String seekerId,
    final String? tutorName,
    final String? seekerName,
    required final String subject,
    @TimestampConverter() required final DateTime startAt,
    @TimestampConverter() required final DateTime endAt,
    @AppointmentStatusConverter() required final AppointmentStatus status,
    final String? cancelledBy,
    @NullableTimestampConverter() final DateTime? cancelledAt,
    final String? cancellationReason,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime updatedAt,
  }) = _$AppointmentModelImpl;

  factory _AppointmentModel.fromJson(Map<String, dynamic> json) =
      _$AppointmentModelImpl.fromJson;

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
  @TimestampConverter()
  DateTime get startAt;
  @override
  @TimestampConverter()
  DateTime get endAt;
  @override
  @AppointmentStatusConverter()
  AppointmentStatus get status;
  @override
  String? get cancelledBy;
  @override
  @NullableTimestampConverter()
  DateTime? get cancelledAt;
  @override
  String? get cancellationReason;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of AppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentModelImplCopyWith<_$AppointmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
