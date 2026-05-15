import 'package:flutter/material.dart';
import 'package:ppu_connect/core/constants/app_constants.dart';
import 'package:ppu_connect/core/theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 64});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.22),
        child: Image.asset(
          AppImages.logo,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Icon(
            Icons.school,
            color: Colors.white,
            size: size * 0.55,
          ),
        ),
      ),
    );
  }
}
