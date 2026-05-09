// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WeeklySlot {
  String get id => throw _privateConstructorUsedError;

  /// ISO 8601: 1 = Monday … 7 = Sunday
  int get dayOfWeek => throw _privateConstructorUsedError;
  AppTimeOfDay get startTime => throw _privateConstructorUsedError;
  AppTimeOfDay get endTime => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Create a copy of WeeklySlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklySlotCopyWith<WeeklySlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklySlotCopyWith<$Res> {
  factory $WeeklySlotCopyWith(
    WeeklySlot value,
    $Res Function(WeeklySlot) then,
  ) = _$WeeklySlotCopyWithImpl<$Res, WeeklySlot>;
  @useResult
  $Res call({
    String id,
    int dayOfWeek,
    AppTimeOfDay startTime,
    AppTimeOfDay endTime,
    bool isActive,
  });
}

/// @nodoc
class _$WeeklySlotCopyWithImpl<$Res, $Val extends WeeklySlot>
    implements $WeeklySlotCopyWith<$Res> {
  _$WeeklySlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklySlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dayOfWeek = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            dayOfWeek: null == dayOfWeek
                ? _value.dayOfWeek
                : dayOfWeek // ignore: cast_nullable_to_non_nullable
                      as int,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as AppTimeOfDay,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as AppTimeOfDay,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WeeklySlotImplCopyWith<$Res>
    implements $WeeklySlotCopyWith<$Res> {
  factory _$$WeeklySlotImplCopyWith(
    _$WeeklySlotImpl value,
    $Res Function(_$WeeklySlotImpl) then,
  ) = __$$WeeklySlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int dayOfWeek,
    AppTimeOfDay startTime,
    AppTimeOfDay endTime,
    bool isActive,
  });
}

/// @nodoc
class __$$WeeklySlotImplCopyWithImpl<$Res>
    extends _$WeeklySlotCopyWithImpl<$Res, _$WeeklySlotImpl>
    implements _$$WeeklySlotImplCopyWith<$Res> {
  __$$WeeklySlotImplCopyWithImpl(
    _$WeeklySlotImpl _value,
    $Res Function(_$WeeklySlotImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeeklySlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dayOfWeek = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? isActive = null,
  }) {
    return _then(
      _$WeeklySlotImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        dayOfWeek: null == dayOfWeek
            ? _value.dayOfWeek
            : dayOfWeek // ignore: cast_nullable_to_non_nullable
                  as int,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as AppTimeOfDay,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as AppTimeOfDay,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$WeeklySlotImpl implements _WeeklySlot {
  const _$WeeklySlotImpl({
    required this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.isActive,
  });

  @override
  final String id;

  /// ISO 8601: 1 = Monday … 7 = Sunday
  @override
  final int dayOfWeek;
  @override
  final AppTimeOfDay startTime;
  @override
  final AppTimeOfDay endTime;
  @override
  final bool isActive;

  @override
  String toString() {
    return 'WeeklySlot(id: $id, dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklySlotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, dayOfWeek, startTime, endTime, isActive);

  /// Create a copy of WeeklySlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklySlotImplCopyWith<_$WeeklySlotImpl> get copyWith =>
      __$$WeeklySlotImplCopyWithImpl<_$WeeklySlotImpl>(this, _$identity);
}

abstract class _WeeklySlot implements WeeklySlot {
  const factory _WeeklySlot({
    required final String id,
    required final int dayOfWeek,
    required final AppTimeOfDay startTime,
    required final AppTimeOfDay endTime,
    required final bool isActive,
  }) = _$WeeklySlotImpl;

  @override
  String get id;

  /// ISO 8601: 1 = Monday … 7 = Sunday
  @override
  int get dayOfWeek;
  @override
  AppTimeOfDay get startTime;
  @override
  AppTimeOfDay get endTime;
  @override
  bool get isActive;

  /// Create a copy of WeeklySlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklySlotImplCopyWith<_$WeeklySlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
