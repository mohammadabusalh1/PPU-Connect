// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tutoring_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TutoringRequest {
  String get id => throw _privateConstructorUsedError;
  String get seekerId => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<int> get preferredDays => throw _privateConstructorUsedError;
  TimeRange? get preferredTimeRange => throw _privateConstructorUsedError;
  RequestStatus get status => throw _privateConstructorUsedError;
  List<String> get respondedTutorIds => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of TutoringRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TutoringRequestCopyWith<TutoringRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TutoringRequestCopyWith<$Res> {
  factory $TutoringRequestCopyWith(
    TutoringRequest value,
    $Res Function(TutoringRequest) then,
  ) = _$TutoringRequestCopyWithImpl<$Res, TutoringRequest>;
  @useResult
  $Res call({
    String id,
    String seekerId,
    String subject,
    String description,
    List<int> preferredDays,
    TimeRange? preferredTimeRange,
    RequestStatus status,
    List<String> respondedTutorIds,
    DateTime expiresAt,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$TutoringRequestCopyWithImpl<$Res, $Val extends TutoringRequest>
    implements $TutoringRequestCopyWith<$Res> {
  _$TutoringRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TutoringRequest
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
abstract class _$$TutoringRequestImplCopyWith<$Res>
    implements $TutoringRequestCopyWith<$Res> {
  factory _$$TutoringRequestImplCopyWith(
    _$TutoringRequestImpl value,
    $Res Function(_$TutoringRequestImpl) then,
  ) = __$$TutoringRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String seekerId,
    String subject,
    String description,
    List<int> preferredDays,
    TimeRange? preferredTimeRange,
    RequestStatus status,
    List<String> respondedTutorIds,
    DateTime expiresAt,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$TutoringRequestImplCopyWithImpl<$Res>
    extends _$TutoringRequestCopyWithImpl<$Res, _$TutoringRequestImpl>
    implements _$$TutoringRequestImplCopyWith<$Res> {
  __$$TutoringRequestImplCopyWithImpl(
    _$TutoringRequestImpl _value,
    $Res Function(_$TutoringRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TutoringRequest
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
      _$TutoringRequestImpl(
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

class _$TutoringRequestImpl implements _TutoringRequest {
  const _$TutoringRequestImpl({
    required this.id,
    required this.seekerId,
    required this.subject,
    required this.description,
    required final List<int> preferredDays,
    this.preferredTimeRange,
    required this.status,
    required final List<String> respondedTutorIds,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  }) : _preferredDays = preferredDays,
       _respondedTutorIds = respondedTutorIds;

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
  final TimeRange? preferredTimeRange;
  @override
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
  final DateTime expiresAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'TutoringRequest(id: $id, seekerId: $seekerId, subject: $subject, description: $description, preferredDays: $preferredDays, preferredTimeRange: $preferredTimeRange, status: $status, respondedTutorIds: $respondedTutorIds, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TutoringRequestImpl &&
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

  /// Create a copy of TutoringRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TutoringRequestImplCopyWith<_$TutoringRequestImpl> get copyWith =>
      __$$TutoringRequestImplCopyWithImpl<_$TutoringRequestImpl>(
        this,
        _$identity,
      );
}

abstract class _TutoringRequest implements TutoringRequest {
  const factory _TutoringRequest({
    required final String id,
    required final String seekerId,
    required final String subject,
    required final String description,
    required final List<int> preferredDays,
    final TimeRange? preferredTimeRange,
    required final RequestStatus status,
    required final List<String> respondedTutorIds,
    required final DateTime expiresAt,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$TutoringRequestImpl;

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
  TimeRange? get preferredTimeRange;
  @override
  RequestStatus get status;
  @override
  List<String> get respondedTutorIds;
  @override
  DateTime get expiresAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of TutoringRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TutoringRequestImplCopyWith<_$TutoringRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
