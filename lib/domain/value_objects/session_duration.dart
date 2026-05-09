import 'package:equatable/equatable.dart';

class SessionDuration extends Equatable {
  final Duration value;

  const SessionDuration(this.value);

  double get inHours => value.inMinutes / 60.0;

  bool get isValid => value.inMinutes >= 30;

  @override
  List<Object?> get props => [value];
}
