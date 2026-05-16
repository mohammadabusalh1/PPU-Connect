// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tutor_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TutorProfileModel _$TutorProfileModelFromJson(Map<String, dynamic> json) {
  return _TutorProfileModel.fromJson(json);
}

/// @nodoc
mixin _$TutorProfileModel {
  String get userId => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  List<String> get subjects => throw _privateConstructorUsedError;
  double get hourlyRate => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  double get averageRating => throw _privateConstructorUsedError;
  int get totalReviews => throw _privateConstructorUsedError;
  int get completedSessions => throw _privateConstructorUsedError;
  bool get isAcceptingRequests => throw _privateConstructorUsedError;
  @WeeklySlotsConverter()
  List<WeeklySlotModel> get weeklySlots => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this TutorProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TutorProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TutorProfileModelCopyWith<TutorProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TutorProfileModelCopyWith<$Res> {
  factory $TutorProfileModelCopyWith(
    TutorProfileModel value,
    $Res Function(TutorProfileModel) then,
  ) = _$TutorProfileModelCopyWithImpl<$Res, TutorProfileModel>;
  @useResult
  $Res call({
    String userId,
    String? bio,
    List<String> subjects,
    double hourlyRate,
    String currency,
    double averageRating,
    int totalReviews,
    int completedSessions,
    bool isAcceptingRequests,
    @WeeklySlotsConverter() List<WeeklySlotModel> weeklySlots,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class _$TutorProfileModelCopyWithImpl<$Res, $Val extends TutorProfileModel>
    implements $TutorProfileModelCopyWith<$Res> {
  _$TutorProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TutorProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? bio = freezed,
    Object? subjects = null,
    Object? hourlyRate = null,
    Object? currency = null,
    Object? averageRating = null,
    Object? totalReviews = null,
    Object? completedSessions = null,
    Object? isAcceptingRequests = null,
    Object? weeklySlots = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            subjects: null == subjects
                ? _value.subjects
                : subjects // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            hourlyRate: null == hourlyRate
                ? _value.hourlyRate
                : hourlyRate // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            averageRating: null == averageRating
                ? _value.averageRating
                : averageRating // ignore: cast_nullable_to_non_nullable
                      as double,
            totalReviews: null == totalReviews
                ? _value.totalReviews
                : totalReviews // ignore: cast_nullable_to_non_nullable
                      as int,
            completedSessions: null == completedSessions
                ? _value.completedSessions
                : completedSessions // ignore: cast_nullable_to_non_nullable
                      as int,
            isAcceptingRequests: null == isAcceptingRequests
                ? _value.isAcceptingRequests
                : isAcceptingRequests // ignore: cast_nullable_to_non_nullable
                      as bool,
            weeklySlots: null == weeklySlots
                ? _value.weeklySlots
                : weeklySlots // ignore: cast_nullable_to_non_nullable
                      as List<WeeklySlotModel>,
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
abstract class _$$TutorProfileModelImplCopyWith<$Res>
    implements $TutorProfileModelCopyWith<$Res> {
  factory _$$TutorProfileModelImplCopyWith(
    _$TutorProfileModelImpl value,
    $Res Function(_$TutorProfileModelImpl) then,
  ) = __$$TutorProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String? bio,
    List<String> subjects,
    double hourlyRate,
    String currency,
    double averageRating,
    int totalReviews,
    int completedSessions,
    bool isAcceptingRequests,
    @WeeklySlotsConverter() List<WeeklySlotModel> weeklySlots,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class __$$TutorProfileModelImplCopyWithImpl<$Res>
    extends _$TutorProfileModelCopyWithImpl<$Res, _$TutorProfileModelImpl>
    implements _$$TutorProfileModelImplCopyWith<$Res> {
  __$$TutorProfileModelImplCopyWithImpl(
    _$TutorProfileModelImpl _value,
    $Res Function(_$TutorProfileModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TutorProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? bio = freezed,
    Object? subjects = null,
    Object? hourlyRate = null,
    Object? currency = null,
    Object? averageRating = null,
    Object? totalReviews = null,
    Object? completedSessions = null,
    Object? isAcceptingRequests = null,
    Object? weeklySlots = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$TutorProfileModelImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        subjects: null == subjects
            ? _value._subjects
            : subjects // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        hourlyRate: null == hourlyRate
            ? _value.hourlyRate
            : hourlyRate // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        averageRating: null == averageRating
            ? _value.averageRating
            : averageRating // ignore: cast_nullable_to_non_nullable
                  as double,
        totalReviews: null == totalReviews
            ? _value.totalReviews
            : totalReviews // ignore: cast_nullable_to_non_nullable
                  as int,
        completedSessions: null == completedSessions
            ? _value.completedSessions
            : completedSessions // ignore: cast_nullable_to_non_nullable
                  as int,
        isAcceptingRequests: null == isAcceptingRequests
            ? _value.isAcceptingRequests
            : isAcceptingRequests // ignore: cast_nullable_to_non_nullable
                  as bool,
        weeklySlots: null == weeklySlots
            ? _value._weeklySlots
            : weeklySlots // ignore: cast_nullable_to_non_nullable
                  as List<WeeklySlotModel>,
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
class _$TutorProfileModelImpl implements _TutorProfileModel {
  const _$TutorProfileModelImpl({
    required this.userId,
    this.bio,
    required final List<String> subjects,
    required this.hourlyRate,
    required this.currency,
    required this.averageRating,
    required this.totalReviews,
    required this.completedSessions,
    required this.isAcceptingRequests,
    @WeeklySlotsConverter() required final List<WeeklySlotModel> weeklySlots,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.updatedAt,
  }) : _subjects = subjects,
       _weeklySlots = weeklySlots;

  factory _$TutorProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TutorProfileModelImplFromJson(json);

  @override
  final String userId;
  @override
  final String? bio;
  final List<String> _subjects;
  @override
  List<String> get subjects {
    if (_subjects is EqualUnmodifiableListView) return _subjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subjects);
  }

  @override
  final double hourlyRate;
  @override
  final String currency;
  @override
  final double averageRating;
  @override
  final int totalReviews;
  @override
  final int completedSessions;
  @override
  final bool isAcceptingRequests;
  final List<WeeklySlotModel> _weeklySlots;
  @override
  @WeeklySlotsConverter()
  List<WeeklySlotModel> get weeklySlots {
    if (_weeklySlots is EqualUnmodifiableListView) return _weeklySlots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weeklySlots);
  }

  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'TutorProfileModel(userId: $userId, bio: $bio, subjects: $subjects, hourlyRate: $hourlyRate, currency: $currency, averageRating: $averageRating, totalReviews: $totalReviews, completedSessions: $completedSessions, isAcceptingRequests: $isAcceptingRequests, weeklySlots: $weeklySlots, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TutorProfileModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            const DeepCollectionEquality().equals(other._subjects, _subjects) &&
            (identical(other.hourlyRate, hourlyRate) ||
                other.hourlyRate == hourlyRate) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalReviews, totalReviews) ||
                other.totalReviews == totalReviews) &&
            (identical(other.completedSessions, completedSessions) ||
                other.completedSessions == completedSessions) &&
            (identical(other.isAcceptingRequests, isAcceptingRequests) ||
                other.isAcceptingRequests == isAcceptingRequests) &&
            const DeepCollectionEquality().equals(
              other._weeklySlots,
              _weeklySlots,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    bio,
    const DeepCollectionEquality().hash(_subjects),
    hourlyRate,
    currency,
    averageRating,
    totalReviews,
    completedSessions,
    isAcceptingRequests,
    const DeepCollectionEquality().hash(_weeklySlots),
    createdAt,
    updatedAt,
  );

  /// Create a copy of TutorProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TutorProfileModelImplCopyWith<_$TutorProfileModelImpl> get copyWith =>
      __$$TutorProfileModelImplCopyWithImpl<_$TutorProfileModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TutorProfileModelImplToJson(this);
  }
}

abstract class _TutorProfileModel implements TutorProfileModel {
  const factory _TutorProfileModel({
    required final String userId,
    final String? bio,
    required final List<String> subjects,
    required final double hourlyRate,
    required final String currency,
    required final double averageRating,
    required final int totalReviews,
    required final int completedSessions,
    required final bool isAcceptingRequests,
    @WeeklySlotsConverter() required final List<WeeklySlotModel> weeklySlots,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime updatedAt,
  }) = _$TutorProfileModelImpl;

  factory _TutorProfileModel.fromJson(Map<String, dynamic> json) =
      _$TutorProfileModelImpl.fromJson;

  @override
  String get userId;
  @override
  String? get bio;
  @override
  List<String> get subjects;
  @override
  double get hourlyRate;
  @override
  String get currency;
  @override
  double get averageRating;
  @override
  int get totalReviews;
  @override
  int get completedSessions;
  @override
  bool get isAcceptingRequests;
  @override
  @WeeklySlotsConverter()
  List<WeeklySlotModel> get weeklySlots;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of TutorProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TutorProfileModelImplCopyWith<_$TutorProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
