// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tutoring_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TutoringRequestModel _$TutoringRequestModelFromJson(Map<String, dynamic> json) {
  return _TutoringRequestModel.fromJson(json);
}

/// @nodoc
mixin _$TutoringRequestModel {
  String get id => throw _privateConstructorUsedError;
  String get seekerId => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<int> get preferredDays => throw _privateConstructorUsedError;
  @NullableTimeRangeConverter()
  TimeRange? get preferredTimeRange => throw _privateConstructorUsedError;
  @RequestStatusConverter()
  RequestStatus get status => throw _privateConstructorUsedError;
  List<String> get respondedTutorIds => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get expiresAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this TutoringRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TutoringRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TutoringRequestModelCopyWith<TutoringRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TutoringRequestModelCopyWith<$Res> {
  factory $TutoringRequestModelCopyWith(
    TutoringRequestModel value,
    $Res Function(TutoringRequestModel) then,
  ) = _$TutoringRequestModelCopyWithImpl<$Res, TutoringRequestModel>;
  @useResult
  $Res call({
    String id,
    String seekerId,
    String subject,
    String description,
    List<int> preferredDays,
    @NullableTimeRangeConverter() TimeRange? preferredTimeRange,
    @RequestStatusConverter() RequestStatus status,
    List<String> respondedTutorIds,
    @TimestampConverter() DateTime expiresAt,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class _$TutoringRequestModelCopyWithImpl<
  $Res,
  $Val extends TutoringRequestModel
>
    implements $TutoringRequestModelCopyWith<$Res> {
  _$TutoringRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TutoringRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seekerId = null,
    Object? subject = null,
    Object? description = null,
    Object? preferredDays = null,
    Object? preferredTimeRange = freezed,
    Object? status = null,
    Object? respondedTutorIds = null,
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
            seekerId: null == seekerId
                ? _value.seekerId
                : seekerId // ignore: cast_nullable_to_non_nullable
                      as String,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            preferredDays: null == preferredDays
                ? _value.preferredDays
                : preferredDays // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            preferredTimeRange: freezed == preferredTimeRange
                ? _value.preferredTimeRange
                : preferredTimeRange // ignore: cast_nullable_to_non_nullable
                      as TimeRange?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RequestStatus,
            respondedTutorIds: null == respondedTutorIds
                ? _value.respondedTutorIds
                : respondedTutorIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
abstract class _$$TutoringRequestModelImplCopyWith<$Res>
    implements $TutoringRequestModelCopyWith<$Res> {
  factory _$$TutoringRequestModelImplCopyWith(
    _$TutoringRequestModelImpl value,
    $Res Function(_$TutoringRequestModelImpl) then,
  ) = __$$TutoringRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String seekerId,
    String subject,
    String description,
    List<int> preferredDays,
    @NullableTimeRangeConverter() TimeRange? preferredTimeRange,
    @RequestStatusConverter() RequestStatus status,
    List<String> respondedTutorIds,
    @TimestampConverter() DateTime expiresAt,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class __$$TutoringRequestModelImplCopyWithImpl<$Res>
    extends _$TutoringRequestModelCopyWithImpl<$Res, _$TutoringRequestModelImpl>
    implements _$$TutoringRequestModelImplCopyWith<$Res> {
  __$$TutoringRequestModelImplCopyWithImpl(
    _$TutoringRequestModelImpl _value,
    $Res Function(_$TutoringRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TutoringRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seekerId = null,
    Object? subject = null,
    Object? description = null,
    Object? preferredDays = null,
    Object? preferredTimeRange = freezed,
    Object? status = null,
    Object? respondedTutorIds = null,
    Object? expiresAt = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$TutoringRequestModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        seekerId: null == seekerId
            ? _value.seekerId
            : seekerId // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        preferredDays: null == preferredDays
            ? _value._preferredDays
            : preferredDays // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        preferredTimeRange: freezed == preferredTimeRange
            ? _value.preferredTimeRange
            : preferredTimeRange // ignore: cast_nullable_to_non_nullable
                  as TimeRange?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RequestStatus,
        respondedTutorIds: null == respondedTutorIds
            ? _value._respondedTutorIds
            : respondedTutorIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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
class _$TutoringRequestModelImpl implements _TutoringRequestModel {
  const _$TutoringRequestModelImpl({
    required this.id,
    required this.seekerId,
    required this.subject,
    required this.description,
    required final List<int> preferredDays,
    @NullableTimeRangeConverter() this.preferredTimeRange,
    @RequestStatusConverter() required this.status,
    required final List<String> respondedTutorIds,
    @TimestampConverter() required this.expiresAt,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.updatedAt,
  }) : _preferredDays = preferredDays,
       _respondedTutorIds = respondedTutorIds;

  factory _$TutoringRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TutoringRequestModelImplFromJson(json);

  @override
  final String id;
  @override
  final String seekerId;
  @override
  final String subject;
  @override
  final String description;
  final List<int> _preferredDays;
  @override
  List<int> get preferredDays {
    if (_preferredDays is EqualUnmodifiableListView) return _preferredDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredDays);
  }

  @override
  @NullableTimeRangeConverter()
  final TimeRange? preferredTimeRange;
  @override
  @RequestStatusConverter()
  final RequestStatus status;
  final List<String> _respondedTutorIds;
  @override
  List<String> get respondedTutorIds {
    if (_respondedTutorIds is EqualUnmodifiableListView)
      return _respondedTutorIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_respondedTutorIds);
  }

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
    return 'TutoringRequestModel(id: $id, seekerId: $seekerId, subject: $subject, description: $description, preferredDays: $preferredDays, preferredTimeRange: $preferredTimeRange, status: $status, respondedTutorIds: $respondedTutorIds, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TutoringRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.seekerId, seekerId) ||
                other.seekerId == seekerId) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._preferredDays,
              _preferredDays,
            ) &&
            (identical(other.preferredTimeRange, preferredTimeRange) ||
                other.preferredTimeRange == preferredTimeRange) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
              other._respondedTutorIds,
              _respondedTutorIds,
            ) &&
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
    seekerId,
    subject,
    description,
    const DeepCollectionEquality().hash(_preferredDays),
    preferredTimeRange,
    status,
    const DeepCollectionEquality().hash(_respondedTutorIds),
    expiresAt,
    createdAt,
    updatedAt,
  );

  /// Create a copy of TutoringRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TutoringRequestModelImplCopyWith<_$TutoringRequestModelImpl>
  get copyWith =>
      __$$TutoringRequestModelImplCopyWithImpl<_$TutoringRequestModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TutoringRequestModelImplToJson(this);
  }
}

abstract class _TutoringRequestModel implements TutoringRequestModel {
  const factory _TutoringRequestModel({
    required final String id,
    required final String seekerId,
    required final String subject,
    required final String description,
    required final List<int> preferredDays,
    @NullableTimeRangeConverter() final TimeRange? preferredTimeRange,
    @RequestStatusConverter() required final RequestStatus status,
    required final List<String> respondedTutorIds,
    @TimestampConverter() required final DateTime expiresAt,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime updatedAt,
  }) = _$TutoringRequestModelImpl;

  factory _TutoringRequestModel.fromJson(Map<String, dynamic> json) =
      _$TutoringRequestModelImpl.fromJson;

  @override
  String get id;
  @override
  String get seekerId;
  @override
  String get subject;
  @override
  String get description;
  @override
  List<int> get preferredDays;
  @override
  @NullableTimeRangeConverter()
  TimeRange? get preferredTimeRange;
  @override
  @RequestStatusConverter()
  RequestStatus get status;
  @override
  List<String> get respondedTutorIds;
  @override
  @TimestampConverter()
  DateTime get expiresAt;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of TutoringRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TutoringRequestModelImplCopyWith<_$TutoringRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
