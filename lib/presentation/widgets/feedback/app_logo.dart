import 'package:flutter/material.dart';
import 'package:ppu_connect/core/constants/app_constants.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 64});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.logo,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Icon(
        Icons.school,
        size: size * 0.55,
      ),
    );
  }
}
