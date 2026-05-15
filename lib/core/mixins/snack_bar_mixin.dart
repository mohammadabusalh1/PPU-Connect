import 'package:flutter/material.dart';

mixin SnackBarMixin<T extends StatefulWidget> on State<T> {
  void showSuccessSnack(String message) => _show(message, isError: false);
  void showErrorSnack(String message) => _show(message, isError: true);

  void _show(String message, {required bool isError}) {
    if (!mounted) return;
    final cs = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? cs.error : cs.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
  }
}
