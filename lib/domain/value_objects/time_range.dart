import 'package:equatable/equatable.dart';

import 'app_time_of_day.dart';

class TimeRange extends Equatable {
  final AppTimeOfDay start;
  final AppTimeOfDay end;

  const TimeRange({required this.start, required this.end});

  Duration get duration => end.difference(start);

  bool overlaps(TimeRange other) =>
      start.isBefore(other.end) && end.isAfter(other.start);

  @override
  List<Object?> get props => [start, end];
}
