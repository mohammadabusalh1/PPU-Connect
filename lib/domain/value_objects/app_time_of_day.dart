import 'package:equatable/equatable.dart';

/// Pure-Dart time-of-day value object. Avoids Flutter's TimeOfDay in the domain layer.
class AppTimeOfDay extends Equatable {
  final int hour;
  final int minute;

  const AppTimeOfDay({required this.hour, required this.minute})
      : assert(hour >= 0 && hour < 24, 'hour must be 0–23'),
        assert(minute >= 0 && minute < 60, 'minute must be 0–59');

  int get totalMinutes => hour * 60 + minute;

  bool isAfter(AppTimeOfDay other) => totalMinutes > other.totalMinutes;
  bool isBefore(AppTimeOfDay other) => totalMinutes < other.totalMinutes;
  bool isAtOrAfter(AppTimeOfDay other) => totalMinutes >= other.totalMinutes;
  bool isAtOrBefore(AppTimeOfDay other) => totalMinutes <= other.totalMinutes;

  Duration difference(AppTimeOfDay other) =>
      Duration(minutes: totalMinutes - other.totalMinutes);

  @override
  List<Object?> get props => [hour, minute];

  @override
  String toString() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}
