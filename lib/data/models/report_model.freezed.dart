// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) {
  return _ReportModel.fromJson(json);
}

/// @nodoc
mixin _$ReportModel {
  String get id => throw _privateConstructorUsedError;
  String get reporterId => throw _privateConstructorUsedError;
  String get reportedUserId => throw _privateConstructorUsedError;
  String? get appointmentId => throw _privateConstructorUsedError;
  @ReportReasonConverter()
  ReportReason get reason => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @ReportStatusConverter()
  ReportStatus get status => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get resolvedAt => throw _privateConstructorUsedError;
  String? get adminNote => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ReportModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportModelCopyWith<ReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportModelCopyWith<$Res> {
  factory $ReportModelCopyWith(
    ReportModel value,
    $Res Function(ReportModel) then,
  ) = _$ReportModelCopyWithImpl<$Res, ReportModel>;
  @useResult
  $Res call({
    String id,
    String reporterId,
    String reportedUserId,
    String? appointmentId,
    @ReportReasonConverter() ReportReason reason,
    String description,
    @ReportStatusConverter() ReportStatus status,
    @NullableTimestampConverter() DateTime? resolvedAt,
    String? adminNote,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$ReportModelCopyWithImpl<$Res, $Val extends ReportModel>
    implements $ReportModelCopyWith<$Res> {
  _$ReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reporterId = null,
    Object? reportedUserId = null,
    Object? appointmentId = freezed,
    Object? reason = null,
    Object? description = null,
    Object? status = null,
    Object? resolvedAt = freezed,
    Object? adminNote = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            reporterId: null == reporterId
                ? _value.reporterId
                : reporterId // ignore: cast_nullable_to_non_nullable
                      as String,
            reportedUserId: null == reportedUserId
                ? _value.reportedUserId
                : reportedUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            appointmentId: freezed == appointmentId
                ? _value.appointmentId
                : appointmentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as ReportReason,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ReportStatus,
            resolvedAt: freezed == resolvedAt
                ? _value.resolvedAt
                : resolvedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            adminNote: freezed == adminNote
                ? _value.adminNote
                : adminNote // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReportModelImplCopyWith<$Res>
    implements $ReportModelCopyWith<$Res> {
  factory _$$ReportModelImplCopyWith(
    _$ReportModelImpl value,
    $Res Function(_$ReportModelImpl) then,
  ) = __$$ReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String reporterId,
    String reportedUserId,
    String? appointmentId,
    @ReportReasonConverter() ReportReason reason,
    String description,
    @ReportStatusConverter() ReportStatus status,
    @NullableTimestampConverter() DateTime? resolvedAt,
    String? adminNote,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$ReportModelImplCopyWithImpl<$Res>
    extends _$ReportModelCopyWithImpl<$Res, _$ReportModelImpl>
    implements _$$ReportModelImplCopyWith<$Res> {
  __$$ReportModelImplCopyWithImpl(
    _$ReportModelImpl _value,
    $Res Function(_$ReportModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reporterId = null,
    Object? reportedUserId = null,
    Object? appointmentId = freezed,
    Object? reason = null,
    Object? description = null,
    Object? status = null,
    Object? resolvedAt = freezed,
    Object? adminNote = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$ReportModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        reporterId: null == reporterId
            ? _value.reporterId
            : reporterId // ignore: cast_nullable_to_non_nullable
                  as String,
        reportedUserId: null == reportedUserId
            ? _value.reportedUserId
            : reportedUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        appointmentId: freezed == appointmentId
            ? _value.appointmentId
            : appointmentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as ReportReason,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ReportStatus,
        resolvedAt: freezed == resolvedAt
            ? _value.resolvedAt
            : resolvedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        adminNote: freezed == adminNote
            ? _value.adminNote
            : adminNote // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportModelImpl implements _ReportModel {
  const _$ReportModelImpl({
    required this.id,
    required this.reporterId,
    required this.reportedUserId,
    this.appointmentId,
    @ReportReasonConverter() required this.reason,
    required this.description,
    @ReportStatusConverter() required this.status,
    @NullableTimestampConverter() this.resolvedAt,
    this.adminNote,
    @TimestampConverter() required this.createdAt,
  });

  factory _$ReportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportModelImplFromJson(json);

  @override
  final String id;
  @override
  final String reporterId;
  @override
  final String reportedUserId;
  @override
  final String? appointmentId;
  @override
  @ReportReasonConverter()
  final ReportReason reason;
  @override
  final String description;
  @override
  @ReportStatusConverter()
  final ReportStatus status;
  @override
  @NullableTimestampConverter()
  final DateTime? resolvedAt;
  @override
  final String? adminNote;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'ReportModel(id: $id, reporterId: $reporterId, reportedUserId: $reportedUserId, appointmentId: $appointmentId, reason: $reason, description: $description, status: $status, resolvedAt: $resolvedAt, adminNote: $adminNote, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.reporterId, reporterId) ||
                other.reporterId == reporterId) &&
            (identical(other.reportedUserId, reportedUserId) ||
                other.reportedUserId == reportedUserId) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt) &&
            (identical(other.adminNote, adminNote) ||
                other.adminNote == adminNote) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    reporterId,
    reportedUserId,
    appointmentId,
    reason,
    description,
    status,
    resolvedAt,
    adminNote,
    createdAt,
  );

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportModelImplCopyWith<_$ReportModelImpl> get copyWith =>
      __$$ReportModelImplCopyWithImpl<_$ReportModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportModelImplToJson(this);
  }
}

abstract class _ReportModel implements ReportModel {
  const factory _ReportModel({
    required final String id,
    required final String reporterId,
    required final String reportedUserId,
    final String? appointmentId,
    @ReportReasonConverter() required final ReportReason reason,
    required final String description,
    @ReportStatusConverter() required final ReportStatus status,
    @NullableTimestampConverter() final DateTime? resolvedAt,
    final String? adminNote,
    @TimestampConverter() required final DateTime createdAt,
  }) = _$ReportModelImpl;

  factory _ReportModel.fromJson(Map<String, dynamic> json) =
      _$ReportModelImpl.fromJson;

  @override
  String get id;
  @override
  String get reporterId;
  @override
  String get reportedUserId;
  @override
  String? get appointmentId;
  @override
  @ReportReasonConverter()
  ReportReason get reason;
  @override
  String get description;
  @override
  @ReportStatusConverter()
  ReportStatus get status;
  @override
  @NullableTimestampConverter()
  DateTime? get resolvedAt;
  @override
  String? get adminNote;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of ReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportModelImplCopyWith<_$ReportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
