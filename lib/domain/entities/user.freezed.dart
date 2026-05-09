// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String get major => throw _privateConstructorUsedError;
  AcademicLevel get academicLevel => throw _privateConstructorUsedError;
  double? get gpa => throw _privateConstructorUsedError;
  UserRole get role => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get reportCount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({
    String id,
    String fullName,
    String email,
    String? phoneNumber,
    String? avatarUrl,
    String major,
    AcademicLevel academicLevel,
    double? gpa,
    UserRole role,
    bool isActive,
    int reportCount,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? avatarUrl = freezed,
    Object? major = null,
    Object? academicLevel = null,
    Object? gpa = freezed,
    Object? role = null,
    Object? isActive = null,
    Object? reportCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            major: null == major
                ? _value.major
                : major // ignore: cast_nullable_to_non_nullable
                      as String,
            academicLevel: null == academicLevel
                ? _value.academicLevel
                : academicLevel // ignore: cast_nullable_to_non_nullable
                      as AcademicLevel,
            gpa: freezed == gpa
                ? _value.gpa
                : gpa // ignore: cast_nullable_to_non_nullable
                      as double?,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as UserRole,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            reportCount: null == reportCount
                ? _value.reportCount
                : reportCount // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
    _$UserImpl value,
    $Res Function(_$UserImpl) then,
  ) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String fullName,
    String email,
    String? phoneNumber,
    String? avatarUrl,
    String major,
    AcademicLevel academicLevel,
    double? gpa,
    UserRole role,
    bool isActive,
    int reportCount,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
    : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? avatarUrl = freezed,
    Object? major = null,
    Object? academicLevel = null,
    Object? gpa = freezed,
    Object? role = null,
    Object? isActive = null,
    Object? reportCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$UserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        major: null == major
            ? _value.major
            : major // ignore: cast_nullable_to_non_nullable
                  as String,
        academicLevel: null == academicLevel
            ? _value.academicLevel
            : academicLevel // ignore: cast_nullable_to_non_nullable
                  as AcademicLevel,
        gpa: freezed == gpa
            ? _value.gpa
            : gpa // ignore: cast_nullable_to_non_nullable
                  as double?,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as UserRole,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        reportCount: null == reportCount
            ? _value.reportCount
            : reportCount // ignore: cast_nullable_to_non_nullable
                  as int,
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

class _$UserImpl implements _User {
  const _$UserImpl({
    required this.id,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.avatarUrl,
    required this.major,
    required this.academicLevel,
    this.gpa,
    required this.role,
    required this.isActive,
    required this.reportCount,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final String id;
  @override
  final String fullName;
  @override
  final String email;
  @override
  final String? phoneNumber;
  @override
  final String? avatarUrl;
  @override
  final String major;
  @override
  final AcademicLevel academicLevel;
  @override
  final double? gpa;
  @override
  final UserRole role;
  @override
  final bool isActive;
  @override
  final int reportCount;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'User(id: $id, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, avatarUrl: $avatarUrl, major: $major, academicLevel: $academicLevel, gpa: $gpa, role: $role, isActive: $isActive, reportCount: $reportCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.academicLevel, academicLevel) ||
                other.academicLevel == academicLevel) &&
            (identical(other.gpa, gpa) || other.gpa == gpa) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.reportCount, reportCount) ||
                other.reportCount == reportCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fullName,
    email,
    phoneNumber,
    avatarUrl,
    major,
    academicLevel,
    gpa,
    role,
    isActive,
    reportCount,
    createdAt,
    updatedAt,
  );

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);
}

abstract class _User implements User {
  const factory _User({
    required final String id,
    required final String fullName,
    required final String email,
    final String? phoneNumber,
    final String? avatarUrl,
    required final String major,
    required final AcademicLevel academicLevel,
    final double? gpa,
    required final UserRole role,
    required final bool isActive,
    required final int reportCount,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$UserImpl;

  @override
  String get id;
  @override
  String get fullName;
  @override
  String get email;
  @override
  String? get phoneNumber;
  @override
  String? get avatarUrl;
  @override
  String get major;
  @override
  AcademicLevel get academicLevel;
  @override
  double? get gpa;
  @override
  UserRole get role;
  @override
  bool get isActive;
  @override
  int get reportCount;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
