import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand
  static const primary = Color(0xFF1565C0);
  static const primaryDark = Color(0xFF003C8F);
  static const primaryLight = Color(0xFF5E92F3);

  // Role tints (from FEATURES.md spec)
  static const seeker = Color(0xFF2196F3);
  static const tutor = Color(0xFF4CAF50);
  static const both = Color(0xFF9C27B0);

  // Semantic
  static const success = Color(0xFF2E7D32);
  static const warning = Color(0xFFE65100);
  static const error = Color(0xFFD32F2F);
  static const info = Color(0xFF0277BD);

  // Status (appointment / payment)
  static const confirmed = Color(0xFF2E7D32);
  static const pending = Color(0xFFF57F17);
  static const rejected = Color(0xFFD32F2F);
  static const expired = Color(0xFF757575);
  static const completed = Color(0xFF1B5E20);
  static const cancelled = Color(0xFFEF9A9A);
  static const held = Color(0xFFF57F17);
  static const released = Color(0xFF2E7D32);
  static const refunded = Color(0xFF1565C0);

  // Accent
  static const gold = Color(0xFFF5C518);

  // Neutral
  static const divider = Color(0xFFE0E0E0);
  static const shimmerBase = Color(0xFFE0E0E0);
  static const shimmerHighlight = Color(0xFFF5F5F5);
}
