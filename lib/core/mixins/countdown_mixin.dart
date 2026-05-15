import 'dart:async';

import 'package:flutter/material.dart';

mixin CountdownMixin<T extends StatefulWidget> on State<T> {
  Timer? _countdownTimer;
  int _secondsRemaining = 0;
  int get secondsRemaining => _secondsRemaining;
  bool get isCounting => _countdownTimer?.isActive ?? false;

  void startCountdown(int seconds) {
    _countdownTimer?.cancel();
    _secondsRemaining = seconds;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        _countdownTimer?.cancel();
        return;
      }
      if (_secondsRemaining <= 0) {
        _countdownTimer?.cancel();
        onCountdownFinished();
        setState(() {});
        return;
      }
      setState(() => _secondsRemaining--);
    });
    setState(() {});
  }

  void stopCountdown() {
    _countdownTimer?.cancel();
    setState(() => _secondsRemaining = 0);
  }

  /// Called when the countdown reaches zero.
  void onCountdownFinished() {}

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }
}
