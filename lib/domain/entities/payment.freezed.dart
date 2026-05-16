// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Payment {
  String get id => throw _privateConstructorUsedError;
  String? get appointmentId => throw _privateConstructorUsedError;
  String get requestId => throw _privateConstructorUsedError;
  String get tutorId => throw _privateConstructorUsedError;
  String get seekerId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  PaymentStatus get status => throw _privateConstructorUsedError;
  String get cardLast4 => throw _privateConstructorUsedError;
  String get cardBrand => throw _privateConstructorUsedError;
  DateTime? get releasedAt => throw _privateConstructorUsedError;
  DateTime? get refundedAt => throw _privateConstructorUsedError;
  DateTime? get refundRequestedAt => throw _privateConstructorUsedError;
  String? get refundReason => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentCopyWith<Payment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCopyWith<$Res> {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) then) =
      _$PaymentCopyWithImpl<$Res, Payment>;
  @useResult
  $Res call({
    String id,
    String? appointmentId,
    String requestId,
    String tutorId,
    String seekerId,
    double amount,
    String currency,
    PaymentStatus status,
    String cardLast4,
    String cardBrand,
    DateTime? releasedAt,
    DateTime? refundedAt,
    DateTime? refundRequestedAt,
    String? refundReason,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$PaymentCopyWithImpl<$Res, $Val extends Payment>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appointmentId = freezed,
    Object? requestId = null,
    Object? tutorId = null,
    Object? seekerId = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? cardLast4 = null,
    Object? cardBrand = null,
    Object? releasedAt = freezed,
    Object? refundedAt = freezed,
    Object? refundRequestedAt = freezed,
    Object? refundReason = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            appointmentId: freezed == appointmentId
                ? _value.appointmentId
                : appointmentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            requestId: null == requestId
                ? _value.requestId
                : requestId // ignore: cast_nullable_to_non_nullable
                      as String,
            tutorId: null == tutorId
                ? _value.tutorId
                : tutorId // ignore: cast_nullable_to_non_nullable
                      as String,
            seekerId: null == seekerId
                ? _value.seekerId
                : seekerId // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as PaymentStatus,
            cardLast4: null == cardLast4
                ? _value.cardLast4
                : cardLast4 // ignore: cast_nullable_to_non_nullable
                      as String,
            cardBrand: null == cardBrand
                ? _value.cardBrand
                : cardBrand // ignore: cast_nullable_to_non_nullable
                      as String,
            releasedAt: freezed == releasedAt
                ? _value.releasedAt
                : releasedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            refundedAt: freezed == refundedAt
                ? _value.refundedAt
                : refundedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            refundRequestedAt: freezed == refundRequestedAt
                ? _value.refundRequestedAt
                : refundRequestedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            refundReason: freezed == refundReason
                ? _value.refundReason
                : refundReason // ignore: cast_nullable_to_non_nullable
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
abstract class _$$PaymentImplCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$$PaymentImplCopyWith(
    _$PaymentImpl value,
    $Res Function(_$PaymentImpl) then,
  ) = __$$PaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? appointmentId,
    String requestId,
    String tutorId,
    String seekerId,
    double amount,
    String currency,
    PaymentStatus status,
    String cardLast4,
    String cardBrand,
    DateTime? releasedAt,
    DateTime? refundedAt,
    DateTime? refundRequestedAt,
    String? refundReason,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$PaymentImplCopyWithImpl<$Res>
    extends _$PaymentCopyWithImpl<$Res, _$PaymentImpl>
    implements _$$PaymentImplCopyWith<$Res> {
  __$$PaymentImplCopyWithImpl(
    _$PaymentImpl _value,
    $Res Function(_$PaymentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appointmentId = freezed,
    Object? requestId = null,
    Object? tutorId = null,
    Object? seekerId = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? cardLast4 = null,
    Object? cardBrand = null,
    Object? releasedAt = freezed,
    Object? refundedAt = freezed,
    Object? refundRequestedAt = freezed,
    Object? refundReason = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$PaymentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        appointmentId: freezed == appointmentId
            ? _value.appointmentId
            : appointmentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        requestId: null == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as String,
        tutorId: null == tutorId
            ? _value.tutorId
            : tutorId // ignore: cast_nullable_to_non_nullable
                  as String,
        seekerId: null == seekerId
            ? _value.seekerId
            : seekerId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PaymentStatus,
        cardLast4: null == cardLast4
            ? _value.cardLast4
            : cardLast4 // ignore: cast_nullable_to_non_nullable
                  as String,
        cardBrand: null == cardBrand
            ? _value.cardBrand
            : cardBrand // ignore: cast_nullable_to_non_nullable
                  as String,
        releasedAt: freezed == releasedAt
            ? _value.releasedAt
            : releasedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        refundedAt: freezed == refundedAt
            ? _value.refundedAt
            : refundedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        refundRequestedAt: freezed == refundRequestedAt
            ? _value.refundRequestedAt
            : refundRequestedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        refundReason: freezed == refundReason
            ? _value.refundReason
            : refundReason // ignore: cast_nullable_to_non_nullable
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

class _$PaymentImpl implements _Payment {
  const _$PaymentImpl({
    required this.id,
    this.appointmentId,
    required this.requestId,
    required this.tutorId,
    required this.seekerId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.cardLast4,
    required this.cardBrand,
    this.releasedAt,
    this.refundedAt,
    this.refundRequestedAt,
    this.refundReason,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final String id;
  @override
  final String? appointmentId;
  @override
  final String requestId;
  @override
  final String tutorId;
  @override
  final String seekerId;
  @override
  final double amount;
  @override
  final String currency;
  @override
  final PaymentStatus status;
  @override
  final String cardLast4;
  @override
  final String cardBrand;
  @override
  final DateTime? releasedAt;
  @override
  final DateTime? refundedAt;
  @override
  final DateTime? refundRequestedAt;
  @override
  final String? refundReason;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Payment(id: $id, appointmentId: $appointmentId, requestId: $requestId, tutorId: $tutorId, seekerId: $seekerId, amount: $amount, currency: $currency, status: $status, cardLast4: $cardLast4, cardBrand: $cardBrand, releasedAt: $releasedAt, refundedAt: $refundedAt, refundRequestedAt: $refundRequestedAt, refundReason: $refundReason, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.tutorId, tutorId) || other.tutorId == tutorId) &&
            (identical(other.seekerId, seekerId) ||
                other.seekerId == seekerId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.cardLast4, cardLast4) ||
                other.cardLast4 == cardLast4) &&
            (identical(other.cardBrand, cardBrand) ||
                other.cardBrand == cardBrand) &&
            (identical(other.releasedAt, releasedAt) ||
                other.releasedAt == releasedAt) &&
            (identical(other.refundedAt, refundedAt) ||
                other.refundedAt == refundedAt) &&
            (identical(other.refundRequestedAt, refundRequestedAt) ||
                other.refundRequestedAt == refundRequestedAt) &&
            (identical(other.refundReason, refundReason) ||
                other.refundReason == refundReason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    appointmentId,
    requestId,
    tutorId,
    seekerId,
    amount,
    currency,
    status,
    cardLast4,
    cardBrand,
    releasedAt,
    refundedAt,
    refundRequestedAt,
    refundReason,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      __$$PaymentImplCopyWithImpl<_$PaymentImpl>(this, _$identity);
}

abstract class _Payment implements Payment {
  const factory _Payment({
    required final String id,
    final String? appointmentId,
    required final String requestId,
    required final String tutorId,
    required final String seekerId,
    required final double amount,
    required final String currency,
    required final PaymentStatus status,
    required final String cardLast4,
    required final String cardBrand,
    final DateTime? releasedAt,
    final DateTime? refundedAt,
    final DateTime? refundRequestedAt,
    final String? refundReason,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$PaymentImpl;

  @override
  String get id;
  @override
  String? get appointmentId;
  @override
  String get requestId;
  @override
  String get tutorId;
  @override
  String get seekerId;
  @override
  double get amount;
  @override
  String get currency;
  @override
  PaymentStatus get status;
  @override
  String get cardLast4;
  @override
  String get cardBrand;
  @override
  DateTime? get releasedAt;
  @override
  DateTime? get refundedAt;
  @override
  DateTime? get refundRequestedAt;
  @override
  String? get refundReason;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
