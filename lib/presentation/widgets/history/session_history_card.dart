import 'package:flutter/material.dart';
import 'package:ppu_connect/domain/entities/appointment.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/presentation/widgets/history/history_appointment_card.dart';

class SessionHistoryCard extends StatelessWidget {
  const SessionHistoryCard({
    super.key,
    required this.appointment,
    required this.peerName,
    required this.onTap,
    this.outcome,
  });

  final Appointment appointment;
  final String peerName;
  final VoidCallback onTap;
  final SessionOutcome? outcome;

  @override
  Widget build(BuildContext context) {
    return HistoryAppointmentCard(
      appointment: appointment,
      peerName: peerName,
      onTap: onTap,
      outcome: outcome,
    );
  }
}
