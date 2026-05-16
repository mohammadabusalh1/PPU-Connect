/// Base path for appointment detail / cancel / confirm flows.
enum AppointmentRouteScope {
  schedule('/schedule'),
  history('/history');

  const AppointmentRouteScope(this.basePath);
  final String basePath;

  String appointmentDetail(String id) => '$basePath/appointments/$id';

  String appointmentCancel(String id) => '${appointmentDetail(id)}/cancel';

  String appointmentConfirm(String id) => '${appointmentDetail(id)}/confirm';

  String sessionDetail(String appointmentId) =>
      '$basePath/sessions/$appointmentId';
}
