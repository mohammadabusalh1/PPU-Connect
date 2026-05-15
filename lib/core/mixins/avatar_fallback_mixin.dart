import 'package:flutter/material.dart';

mixin AvatarFallbackMixin {
  /// Returns initials (up to 2 chars) from a display name.
  String initialsFrom(String? name) {
    if (name == null || name.trim().isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  /// Deterministic background color derived from the name string.
  Color avatarColorFor(String? name, ColorScheme cs) {
    if (name == null || name.isEmpty) return cs.primaryContainer;
    final palette = [
      cs.primaryContainer,
      cs.secondaryContainer,
      cs.tertiaryContainer,
      cs.errorContainer,
    ];
    final index = name.codeUnits.fold(0, (a, b) => a + b) % palette.length;
    return palette[index];
  }
}
