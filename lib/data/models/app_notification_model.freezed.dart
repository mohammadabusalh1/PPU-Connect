// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppNotificationModel _$AppNotificationModelFromJson(Map<String, dynamic> json) {
  return _AppNotificationModel.fromJson(json);
}

/// @nodoc
mixin _$AppNotificationModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  @NotificationTypeConverter()
  NotificationType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  Map<String, String> get payload => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get readAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AppNotificationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppNotificationModelCopyWith<AppNotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppNotificationModelCopyWith<$Res> {
  factory $AppNotificationModelCopyWith(
    AppNotificationModel value,
    $Res Function(AppNotificationModel) then,
  ) = _$AppNotificationModelCopyWithImpl<$Res, AppNotificationModel>;
  @useResult
  $Res call({
    String id,
    String userId,
    @NotificationTypeConverter() NotificationType type,
    String title,
    String body,
    Map<String, String> payload,
    bool isRead,
    @NullableTimestampConverter() DateTime? readAt,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$AppNotificationModelCopyWithImpl<
  $Res,
  $Val extends AppNotificationModel
>
    implements $AppNotificationModelCopyWith<$Res> {
  _$AppNotificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? body = null,
    Object? payload = null,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as NotificationType,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            body: null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String,
            payload: null == payload
                ? _value.payload
                : payload // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            readAt: freezed == readAt
                ? _value.readAt
                : readAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
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
abstract class _$$AppNotificationModelImplCopyWith<$Res>
    implements $AppNotificationModelCopyWith<$Res> {
  factory _$$AppNotificationModelImplCopyWith(
    _$AppNotificationModelImpl value,
    $Res Function(_$AppNotificationModelImpl) then,
  ) = __$$AppNotificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    @NotificationTypeConverter() NotificationType type,
    String title,
    String body,
    Map<String, String> payload,
    bool isRead,
    @NullableTimestampConverter() DateTime? readAt,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$AppNotificationModelImplCopyWithImpl<$Res>
    extends _$AppNotificationModelCopyWithImpl<$Res, _$AppNotificationModelImpl>
    implements _$$AppNotificationModelImplCopyWith<$Res> {
  __$$AppNotificationModelImplCopyWithImpl(
    _$AppNotificationModelImpl _value,
    $Res Function(_$AppNotificationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? body = null,
    Object? payload = null,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$AppNotificationModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as NotificationType,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
        payload: null == payload
            ? _value._payload
            : payload // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        readAt: freezed == readAt
            ? _value.readAt
            : readAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
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
class _$AppNotificationModelImpl implements _AppNotificationModel {
  const _$AppNotificationModelImpl({
    required this.id,
    required this.userId,
    @NotificationTypeConverter() required this.type,
    required this.title,
    required this.body,
    required final Map<String, String> payload,
    required this.isRead,
    @NullableTimestampConverter() this.readAt,
    @TimestampConverter() required this.createdAt,
  }) : _payload = payload;

  factory _$AppNotificationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppNotificationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  @NotificationTypeConverter()
  final NotificationType type;
  @override
  final String title;
  @override
  final String body;
  final Map<String, String> _payload;
  @override
  Map<String, String> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  @override
  final bool isRead;
  @override
  @NullableTimestampConverter()
  final DateTime? readAt;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'AppNotificationModel(id: $id, userId: $userId, type: $type, title: $title, body: $body, payload: $payload, isRead: $isRead, readAt: $readAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppNotificationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality().equals(other._payload, _payload) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    type,
    title,
    body,
    const DeepCollectionEquality().hash(_payload),
    isRead,
    readAt,
    createdAt,
  );

  /// Create a copy of AppNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppNotificationModelImplCopyWith<_$AppNotificationModelImpl>
  get copyWith =>
      __$$AppNotificationModelImplCopyWithImpl<_$AppNotificationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppNotificationModelImplToJson(this);
  }
}

abstract class _AppNotificationModel implements AppNotificationModel {
  const factory _AppNotificationModel({
    required final String id,
    required final String userId,
    @NotificationTypeConverter() required final NotificationType type,
    required final String title,
    required final String body,
    required final Map<String, String> payload,
    required final bool isRead,
    @NullableTimestampConverter() final DateTime? readAt,
    @TimestampConverter() required final DateTime createdAt,
  }) = _$AppNotificationModelImpl;

  factory _AppNotificationModel.fromJson(Map<String, dynamic> json) =
      _$AppNotificationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  @NotificationTypeConverter()
  NotificationType get type;
  @override
  String get title;
  @override
  String get body;
  @override
  Map<String, String> get payload;
  @override
  bool get isRead;
  @override
  @NullableTimestampConverter()
  DateTime? get readAt;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of AppNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppNotificationModelImplCopyWith<_$AppNotificationModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
