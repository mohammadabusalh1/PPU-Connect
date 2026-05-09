enum UserRole { seeker, tutor, both }

enum AcademicLevel {
  firstYear,
  secondYear,
  thirdYear,
  fourthYear,
  fifthYear,
  graduate,
}

enum AppointmentStatus { confirmed, cancelled, completed, expired }

enum RequestStatus { pending, accepted, rejected, cancelled, expired }

enum SessionOutcome { completed, seekerAbsent, tutorAbsent, bothAbsent, disputed }

enum PaymentStatus { pending, released, refunded, held }

enum ReportStatus { open, underReview, resolved, dismissed }

enum NotificationType {
  appointmentRequest,
  appointmentConfirmed,
  appointmentCancelled,
  appointmentExpired,
  sessionStartingSoon,
  sessionConfirmationRequired,
  paymentReleased,
  paymentRefunded,
  newReview,
  reportUpdate,
  tutoringRequestMatch,
}

enum ReportReason {
  noShow,
  inappropriateBehavior,
  harassment,
  fraud,
  fakeProfile,
  other,
}
