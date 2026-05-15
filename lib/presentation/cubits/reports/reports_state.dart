part of 'reports_cubit.dart';

sealed class ReportsState {
  const ReportsState();
}

final class ReportsInitial extends ReportsState {
  const ReportsInitial();
}

final class ReportsLoading extends ReportsState {
  const ReportsLoading();
}

final class ReportsLoaded extends ReportsState {
  const ReportsLoaded({required this.reports});
  final List<Report> reports;
}

final class ReportSubmitSuccess extends ReportsState {
  const ReportSubmitSuccess();
}

final class ReportsError extends ReportsState {
  const ReportsError(this.message);
  final String message;
}
