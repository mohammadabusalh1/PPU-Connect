// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_confirmation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SessionConfirmationModel _$SessionConfirmationModelFromJson(
  Map<String, dynamic> json,
) {
  return _SessionConfirmationModel.fromJson(json);
}

/// @nodoc
mixin _$SessionConfirmationModel {
  String get id => throw _privateConstructorUsedError;
  String get appointmentId => throw _privateConstructorUsedError;
  bool get tutorConfirmed => throw _privateConstructorUsedError;
  bool get seekerConfirmed => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get tutorConfirmedAt => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get seekerConfirmedAt => throw _privateConstructorUsedError;
  @NullableSessionOutcomeConverter()
  SessionOutcome? get outcome => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get resolvedAt => throw _privateConstructorUsedError;

  /// Serializes this SessionConfirmationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionConfirmationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionConfirmationModelCopyWith<SessionConfirmationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionConfirmationModelCopyWith<$Res> {
  factory $SessionConfirmationModelCopyWith(
    SessionConfirmationModel value,
    $Res Function(SessionConfirmationModel) then,
  ) = _$SessionConfirmationModelCopyWithImpl<$Res, SessionConfirmationModel>;
  @useResult
  $Res call({
    String id,
    String appointmentId,
    bool tutorConfirmed,
    bool seekerConfirmed,
    @NullableTimestampConverter() DateTime? tutorConfirmedAt,
    @NullableTimestampConverter() DateTime? seekerConfirmedAt,
    @NullableSessionOutcomeConverter() SessionOutcome? outcome,
    @NullableTimestampConverter() DateTime? resolvedAt,
  });
}

/// @nodoc
class _$SessionConfirmationModelCopyWithImpl<
  $Res,
  $Val extends SessionConfirmationModel
>
    implements $SessionConfirmationModelCopyWith<$Res> {
  _$SessionConfirmationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionConfirmationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appointmentId = null,
    Object? tutorConfirmed = null,
    Object? seekerConfirmed = null,
    Object? tutorConfirmedAt = freezed,
    Object? seekerConfirmedAt = freezed,
    Object? outcome = freezed,
    Object? resolvedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            appointmentId: null == appointmentId
                ? _value.appointmentId
                : appointmentId // ignore: cast_nullable_to_non_nullable
                      as String,
            tutorConfirmed: null == tutorConfirmed
                ? _value.tutorConfirmed
                : tutorConfirmed // ignore: cast_nullable_to_non_nullable
                      as bool,
            seekerConfirmed: null == seekerConfirmed
                ? _value.seekerConfirmed
                : seekerConfirmed // ignore: cast_nullable_to_non_nullable
                      as bool,
            tutorConfirmedAt: freezed == tutorConfirmedAt
                ? _value.tutorConfirmedAt
                : tutorConfirmedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            seekerConfirmedAt: freezed == seekerConfirmedAt
                ? _value.seekerConfirmedAt
                : seekerConfirmedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            outcome: freezed == outcome
                ? _value.outcome
                : outcome // ignore: cast_nullable_to_non_nullable
                      as SessionOutcome?,
            resolvedAt: freezed == resolvedAt
                ? _value.resolvedAt
                : resolvedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SessionConfirmationModelImplCopyWith<$Res>
    implements $SessionConfirmationModelCopyWith<$Res> {
  factory _$$SessionConfirmationModelImplCopyWith(
    _$SessionConfirmationModelImpl value,
    $Res Function(_$SessionConfirmationModelImpl) then,
  ) = __$$SessionConfirmationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String appointmentId,
    bool tutorConfirmed,
    bool seekerConfirmed,
    @NullableTimestampConverter() DateTime? tutorConfirmedAt,
    @NullableTimestampConverter() DateTime? seekerConfirmedAt,
    @NullableSessionOutcomeConverter() SessionOutcome? outcome,
    @NullableTimestampConverter() DateTime? resolvedAt,
  });
}

/// @nodoc
class __$$SessionConfirmationModelImplCopyWithImpl<$Res>
    extends
        _$SessionConfirmationModelCopyWithImpl<
          $Res,
          _$SessionConfirmationModelImpl
        >
    implements _$$SessionConfirmationModelImplCopyWith<$Res> {
  __$$SessionConfirmationModelImplCopyWithImpl(
    _$SessionConfirmationModelImpl _value,
    $Res Function(_$SessionConfirmationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionConfirmationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appointmentId = null,
    Object? tutorConfirmed = null,
    Object? seekerConfirmed = null,
    Object? tutorConfirmedAt = freezed,
    Object? seekerConfirmedAt = freezed,
    Object? outcome = freezed,
    Object? resolvedAt = freezed,
  }) {
    return _then(
      _$SessionConfirmationModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        appointmentId: null == appointmentId
            ? _value.appointmentId
            : appointmentId // ignore: cast_nullable_to_non_nullable
                  as String,
        tutorConfirmed: null == tutorConfirmed
            ? _value.tutorConfirmed
            : tutorConfirmed // ignore: cast_nullable_to_non_nullable
                  as bool,
        seekerConfirmed: null == seekerConfirmed
            ? _value.seekerConfirmed
            : seekerConfirmed // ignore: cast_nullable_to_non_nullable
                  as bool,
        tutorConfirmedAt: freezed == tutorConfirmedAt
            ? _value.tutorConfirmedAt
            : tutorConfirmedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        seekerConfirmedAt: freezed == seekerConfirmedAt
            ? _value.seekerConfirmedAt
            : seekerConfirmedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        outcome: freezed == outcome
            ? _value.outcome
            : outcome // ignore: cast_nullable_to_non_nullable
                  as SessionOutcome?,
        resolvedAt: freezed == resolvedAt
            ? _value.resolvedAt
            : resolvedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionConfirmationModelImpl implements _SessionConfirmationModel {
  const _$SessionConfirmationModelImpl({
    required this.id,
    required this.appointmentId,
    required this.tutorConfirmed,
    required this.seekerConfirmed,
    @NullableTimestampConverter() this.tutorConfirmedAt,
    @NullableTimestampConverter() this.seekerConfirmedAt,
    @NullableSessionOutcomeConverter() this.outcome,
    @NullableTimestampConverter() this.resolvedAt,
  });

  factory _$SessionConfirmationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionConfirmationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String appointmentId;
  @override
  final bool tutorConfirmed;
  @override
  final bool seekerConfirmed;
  @override
  @NullableTimestampConverter()
  final DateTime? tutorConfirmedAt;
  @override
  @NullableTimestampConverter()
  final DateTime? seekerConfirmedAt;
  @override
  @NullableSessionOutcomeConverter()
  final SessionOutcome? outcome;
  @override
  @NullableTimestampConverter()
  final DateTime? resolvedAt;

  @override
  String toString() {
    return 'SessionConfirmationModel(id: $id, appointmentId: $appointmentId, tutorConfirmed: $tutorConfirmed, seekerConfirmed: $seekerConfirmed, tutorConfirmedAt: $tutorConfirmedAt, seekerConfirmedAt: $seekerConfirmedAt, outcome: $outcome, resolvedAt: $resolvedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionConfirmationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.tutorConfirmed, tutorConfirmed) ||
                other.tutorConfirmed == tutorConfirmed) &&
            (identical(other.seekerConfirmed, seekerConfirmed) ||
                other.seekerConfirmed == seekerConfirmed) &&
            (identical(other.tutorConfirmedAt, tutorConfirmedAt) ||
                other.tutorConfirmedAt == tutorConfirmedAt) &&
            (identical(other.seekerConfirmedAt, seekerConfirmedAt) ||
                other.seekerConfirmedAt == seekerConfirmedAt) &&
            (identical(other.outcome, outcome) || other.outcome == outcome) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    appointmentId,
    tutorConfirmed,
    seekerConfirmed,
    tutorConfirmedAt,
    seekerConfirmedAt,
    outcome,
    resolvedAt,
  );

  /// Create a copy of SessionConfirmationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionConfirmationModelImplCopyWith<_$SessionConfirmationModelImpl>
  get copyWith =>
      __$$SessionConfirmationModelImplCopyWithImpl<
        _$SessionConfirmationModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionConfirmationModelImplToJson(this);
  }
}

abstract class _SessionConfirmationModel implements SessionConfirmationModel {
  const factory _SessionConfirmationModel({
    required final String id,
    required final String appointmentId,
    required final bool tutorConfirmed,
    required final bool seekerConfirmed,
    @NullableTimestampConverter() final DateTime? tutorConfirmedAt,
    @NullableTimestampConverter() final DateTime? seekerConfirmedAt,
    @NullableSessionOutcomeConverter() final SessionOutcome? outcome,
    @NullableTimestampConverter() final DateTime? resolvedAt,
  }) = _$SessionConfirmationModelImpl;

  factory _SessionConfirmationModel.fromJson(Map<String, dynamic> json) =
      _$SessionConfirmationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get appointmentId;
  @override
  bool get tutorConfirmed;
  @override
  bool get seekerConfirmed;
  @override
  @NullableTimestampConverter()
  DateTime? get tutorConfirmedAt;
  @override
  @NullableTimestampConverter()
  DateTime? get seekerConfirmedAt;
  @override
  @NullableSessionOutcomeConverter()
  SessionOutcome? get outcome;
  @override
  @NullableTimestampConverter()
  DateTime? get resolvedAt;

  /// Create a copy of SessionConfirmationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionConfirmationModelImplCopyWith<_$SessionConfirmationModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
