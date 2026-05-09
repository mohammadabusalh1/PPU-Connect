// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_slot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WeeklySlotModel _$WeeklySlotModelFromJson(Map<String, dynamic> json) {
  return _WeeklySlotModel.fromJson(json);
}

/// @nodoc
mixin _$WeeklySlotModel {
  String get id => throw _privateConstructorUsedError;
  int get dayOfWeek => throw _privateConstructorUsedError;
  @AppTimeOfDayConverter()
  AppTimeOfDay get startTime => throw _privateConstructorUsedError;
  @AppTimeOfDayConverter()
  AppTimeOfDay get endTime => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this WeeklySlotModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeeklySlotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklySlotModelCopyWith<WeeklySlotModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklySlotModelCopyWith<$Res> {
  factory $WeeklySlotModelCopyWith(
    WeeklySlotModel value,
    $Res Function(WeeklySlotModel) then,
  ) = _$WeeklySlotModelCopyWithImpl<$Res, WeeklySlotModel>;
  @useResult
  $Res call({
    String id,
    int dayOfWeek,
    @AppTimeOfDayConverter() AppTimeOfDay startTime,
    @AppTimeOfDayConverter() AppTimeOfDay endTime,
    bool isActive,
  });
}

/// @nodoc
class _$WeeklySlotModelCopyWithImpl<$Res, $Val extends WeeklySlotModel>
    implements $WeeklySlotModelCopyWith<$Res> {
  _$WeeklySlotModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklySlotModel
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
abstract class _$$WeeklySlotModelImplCopyWith<$Res>
    implements $WeeklySlotModelCopyWith<$Res> {
  factory _$$WeeklySlotModelImplCopyWith(
    _$WeeklySlotModelImpl value,
    $Res Function(_$WeeklySlotModelImpl) then,
  ) = __$$WeeklySlotModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int dayOfWeek,
    @AppTimeOfDayConverter() AppTimeOfDay startTime,
    @AppTimeOfDayConverter() AppTimeOfDay endTime,
    bool isActive,
  });
}

/// @nodoc
class __$$WeeklySlotModelImplCopyWithImpl<$Res>
    extends _$WeeklySlotModelCopyWithImpl<$Res, _$WeeklySlotModelImpl>
    implements _$$WeeklySlotModelImplCopyWith<$Res> {
  __$$WeeklySlotModelImplCopyWithImpl(
    _$WeeklySlotModelImpl _value,
    $Res Function(_$WeeklySlotModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeeklySlotModel
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
      _$WeeklySlotModelImpl(
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
@JsonSerializable()
class _$WeeklySlotModelImpl implements _WeeklySlotModel {
  const _$WeeklySlotModelImpl({
    required this.id,
    required this.dayOfWeek,
    @AppTimeOfDayConverter() required this.startTime,
    @AppTimeOfDayConverter() required this.endTime,
    required this.isActive,
  });

  factory _$WeeklySlotModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklySlotModelImplFromJson(json);

  @override
  final String id;
  @override
  final int dayOfWeek;
  @override
  @AppTimeOfDayConverter()
  final AppTimeOfDay startTime;
  @override
  @AppTimeOfDayConverter()
  final AppTimeOfDay endTime;
  @override
  final bool isActive;

  @override
  String toString() {
    return 'WeeklySlotModel(id: $id, dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklySlotModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, dayOfWeek, startTime, endTime, isActive);

  /// Create a copy of WeeklySlotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklySlotModelImplCopyWith<_$WeeklySlotModelImpl> get copyWith =>
      __$$WeeklySlotModelImplCopyWithImpl<_$WeeklySlotModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklySlotModelImplToJson(this);
  }
}

abstract class _WeeklySlotModel implements WeeklySlotModel {
  const factory _WeeklySlotModel({
    required final String id,
    required final int dayOfWeek,
    @AppTimeOfDayConverter() required final AppTimeOfDay startTime,
    @AppTimeOfDayConverter() required final AppTimeOfDay endTime,
    required final bool isActive,
  }) = _$WeeklySlotModelImpl;

  factory _WeeklySlotModel.fromJson(Map<String, dynamic> json) =
      _$WeeklySlotModelImpl.fromJson;

  @override
  String get id;
  @override
  int get dayOfWeek;
  @override
  @AppTimeOfDayConverter()
  AppTimeOfDay get startTime;
  @override
  @AppTimeOfDayConverter()
  AppTimeOfDay get endTime;
  @override
  bool get isActive;

  /// Create a copy of WeeklySlotModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklySlotModelImplCopyWith<_$WeeklySlotModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
