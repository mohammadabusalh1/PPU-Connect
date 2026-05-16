import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/enums/enums.dart';
import '../../domain/value_objects/app_time_of_day.dart';
import '../../domain/value_objects/time_range.dart';

class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic value) {
    if (value is Timestamp) return value.toDate().toUtc();
    if (value is String) return DateTime.parse(value).toUtc();
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value, isUtc: true);
    return (value as DateTime).toUtc();
  }

  @override
  dynamic toJson(DateTime date) => Timestamp.fromDate(date.toUtc());
}

class NullableTimestampConverter implements JsonConverter<DateTime?, dynamic> {
  const NullableTimestampConverter();

  @override
  DateTime? fromJson(dynamic value) {
    if (value == null) return null;
    return const TimestampConverter().fromJson(value);
  }

  @override
  dynamic toJson(DateTime? date) =>
      date == null ? null : Timestamp.fromDate(date.toUtc());
}

class AppTimeOfDayConverter
    implements JsonConverter<AppTimeOfDay, Map<String, dynamic>> {
  const AppTimeOfDayConverter();

  @override
  AppTimeOfDay fromJson(Map<String, dynamic> json) =>
      AppTimeOfDay(hour: json['hour'] as int, minute: json['minute'] as int);

  @override
  Map<String, dynamic> toJson(AppTimeOfDay time) =>
      {'hour': time.hour, 'minute': time.minute};
}

class NullableTimeRangeConverter
    implements JsonConverter<TimeRange?, Map<String, dynamic>?> {
  const NullableTimeRangeConverter();

  @override
  TimeRange? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return TimeRange(
      start: const AppTimeOfDayConverter()
          .fromJson(json['start'] as Map<String, dynamic>),
      end: const AppTimeOfDayConverter()
          .fromJson(json['end'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic>? toJson(TimeRange? range) {
    if (range == null) return null;
    return {
      'start': const AppTimeOfDayConverter().toJson(range.start),
      'end': const AppTimeOfDayConverter().toJson(range.end),
    };
  }
}

class UserRoleConverter implements JsonConverter<UserRole, String> {
  const UserRoleConverter();
  @override
  UserRole fromJson(String json) => UserRole.values.byName(json);
  @override
  String toJson(UserRole v) => v.name;
}

class AcademicLevelConverter implements JsonConverter<AcademicLevel, String> {
  const AcademicLevelConverter();
  @override
  AcademicLevel fromJson(String json) => AcademicLevel.values.byName(json);
  @override
  String toJson(AcademicLevel v) => v.name;
}

class AppointmentStatusConverter
    implements JsonConverter<AppointmentStatus, String> {
  const AppointmentStatusConverter();
  @override
  AppointmentStatus fromJson(String json) =>
      AppointmentStatus.values.byName(json);
  @override
  String toJson(AppointmentStatus v) => v.name;
}

class RequestStatusConverter implements JsonConverter<RequestStatus, String> {
  const RequestStatusConverter();
  @override
  RequestStatus fromJson(String json) => RequestStatus.values.byName(json);
  @override
  String toJson(RequestStatus v) => v.name;
}

class SessionOutcomeConverter implements JsonConverter<SessionOutcome, String> {
  const SessionOutcomeConverter();
  @override
  SessionOutcome fromJson(String json) => SessionOutcome.values.byName(json);
  @override
  String toJson(SessionOutcome v) => v.name;
}

class NullableSessionOutcomeConverter
    implements JsonConverter<SessionOutcome?, String?> {
  const NullableSessionOutcomeConverter();
  @override
  SessionOutcome? fromJson(String? json) =>
      json == null ? null : SessionOutcome.values.byName(json);
  @override
  String? toJson(SessionOutcome? v) => v?.name;
}

class PaymentStatusConverter implements JsonConverter<PaymentStatus, String> {
  const PaymentStatusConverter();
  @override
  PaymentStatus fromJson(String json) => PaymentStatus.values.byName(json);
  @override
  String toJson(PaymentStatus v) => v.name;
}

class ReportStatusConverter implements JsonConverter<ReportStatus, String> {
  const ReportStatusConverter();
  @override
  ReportStatus fromJson(String json) => ReportStatus.values.byName(json);
  @override
  String toJson(ReportStatus v) => v.name;
}

class StringMapConverter implements JsonConverter<Map<String, String>, dynamic> {
  const StringMapConverter();

  @override
  Map<String, String> fromJson(dynamic json) {
    if (json == null) return {};
    if (json is! Map) return {};
    return json.map(
      (key, value) => MapEntry(key.toString(), value?.toString() ?? ''),
    );
  }

  @override
  dynamic toJson(Map<String, String> object) => object;
}

class NotificationTypeConverter
    implements JsonConverter<NotificationType, String> {
  const NotificationTypeConverter();
  @override
  NotificationType fromJson(String json) =>
      NotificationType.values.byName(json);
  @override
  String toJson(NotificationType v) => v.name;
}

class ReportReasonConverter implements JsonConverter<ReportReason, String> {
  const ReportReasonConverter();
  @override
  ReportReason fromJson(String json) => ReportReason.values.byName(json);
  @override
  String toJson(ReportReason v) => v.name;
}
