import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ppu_connect/core/constants/app_constants.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.size = 120});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        AppLottie.loading,
        width: size,
        height: size,
        repeat: true,
      ),
    );
  }
}
